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
        self.closeDaySelectionViewButton()
    }
    
    func closeDaySelectionViewButton() {
        closeButton.frame = CGRect(x:self.view.frame.size.width - 48.0, y:30.0, width: 40.0, height: 40.0)
        closeButton.layer.cornerRadius = closeButton.bounds.size.width / 2
        closeButton.setImage(UIImage(named: "close_button")?.withRenderingMode(.alwaysOriginal), for: .normal)
        closeButton.setImage(UIImage(named: "close_button-Tap")?.withRenderingMode(.alwaysOriginal), for: .highlighted)
        closeButton.addTarget(self, action: #selector(dismissDaySelectionView), for: .touchUpInside)
        self.view.addSubview(closeButton)
    }
    @objc func dismissDaySelectionView() {
self.dismiss(animated: true, completion: nil)
    }
    
}

extension ForecastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
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



