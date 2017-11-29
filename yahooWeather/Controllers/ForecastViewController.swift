//
//  ForecastViewController.swift
//  yahooWeather
//
//  Created by Yugandhar Kommineni on 11/29/17.
//  Copyright © 2017 Yugandhar Kommineni. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
    var weather = YahooWeaherService()
    var closeButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ForecastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7 // hard coding for now because making service call in tablecell and not using core data to retrieve count.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ForecastTableViewCell
        
        weather.weatherData {
            DispatchQueue.main.async(execute: {
               cell.tempHighLabel.text = self.weather.high[indexPath.row]
                cell.tempLowLabel.text = self.weather.low[indexPath.row]
                cell.dayLabel.text = self.weather.names[indexPath.row]
                cell.partlyView.text = self.weather.partly[indexPath.row]
                cell.sampleImageView.image = UIImage(named:"sun") //not getting any images from server
            })
        }
        
        return cell
    }
}



