//
//  YahooWeatherService.swift
//  yahooWeather
//
//  Created by Yugandhar Kommineni on 11/29/17.
//  Copyright © 2017 Yugandhar Kommineni. All rights reserved.
//

import Foundation

class YahooWeaherService {
    private var title: String?
    private var location: String?
    var names = [String]()
    var high = [String]()
    var low = [String]()
    var titleLabel: String {
        return title ?? "0"
    }
    var locationLabel: String {
        return location ?? "Location Invalid"
    }
    
    func weatherData(completed: @escaping ()-> ()) {
        guard let url = URL(string: "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22nome%2C%20orlando%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys") else {
            return
        }
        
        var weatherData = [String: Any]()
        URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            do {
                weatherData = (try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any])
              
                guard  let query = weatherData["query"] as? [String : Any]  else {
                    return
                }
                guard let results = query["results"] as? [String : Any] else {
                    return
                }
                
                guard let channel = results["channel"] as? [String : Any] else {
                    return
                }
                
                guard let title = channel["title"]  as? String else {
                    return
                }
                
                guard  let lastBuildDate = channel["lastBuildDate"] as? String else {
                    return
                }
                
                self.title = title
                self.location = lastBuildDate
                
                guard let item = channel["item"] as? [String : Any] else {
                    return
                }
                
                guard let forecast = item["forecast"] as? [[String : Any]] else {
                    return
                }
                
                for day in forecast {
                    if let name = day["date"] as? String {
                        self.names.append(name)
                    }
                }
                
                for day in forecast {
                    if let name = day["high"] as? String {
                        self.high.append(name)
                    }
                }
                
                for day in forecast {
                    if let name = day["low"] as? String {
                        self.low.append(name)
                    }
                }
                
                completed()
            } catch let error as NSError {
                print(error)
            }
        }).resume()
    }
}
