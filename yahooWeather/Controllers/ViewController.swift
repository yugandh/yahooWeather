//
//  ViewController.swift
//  yahooWeather
//
//  Created by Yugandhar Kommineni on 11/29/17.
//  Copyright © 2017 Yugandhar Kommineni. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
var weather = YahooWeaherService()
 
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! weatherTableViewCell
        
        weather.weatherData {
            DispatchQueue.main.async(execute: {
                cell.titleLabel.text = self.weather.titleLabel
                cell.dateLabel.text = self.weather.locationLabel
            })
        }
        
        return cell
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "weatherForecast", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"ForecastViewController") 
        self.present(viewController, animated: true)
    }
}

