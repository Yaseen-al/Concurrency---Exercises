//
//  DetailedCountryViewController.swift
//  2017_11_30 Concurrency - Exercises
//
//  Created by C4Q on 11/30/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import UIKit

class DetailedCountryViewController: UIViewController {
    
    var country: Country?
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var countryFlag: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryCapital: UILabel!
    @IBOutlet weak var countryCurrency: UILabel!
    @IBOutlet weak var CountryCurrentWeather: UILabel!
    @IBOutlet weak var countryPopulation: UILabel!
    
    func spinTheSpinner(){
        spinner.isHidden = false
        spinner.startAnimating()
        
    }
    func spinnerFisrtResponder() {
        spinner.isHidden = true
        spinner.stopAnimating()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinTheSpinner()
        if let country = country{
            countryName.text = country.name
            countryCapital.text = country.capital
            print(country.flag)
            guard let url = URL(string: "http://www.geognos.com/api/en/countries/flag/\(country.alpha2Code).png") else {
                return
            }
            DispatchQueue.global().async {
                guard let rawImage = try? Data(contentsOf: url) else {
                    return
                }
                DispatchQueue.main.async {
                    guard let onlineImage = UIImage(data: rawImage) else {
                        return
                    }
                    self.spinnerFisrtResponder()
                    self.countryFlag.image = onlineImage
                }
                
            }
        }
        // Do any additional setup after loading the view.
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
