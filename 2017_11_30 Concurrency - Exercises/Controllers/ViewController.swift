//
//  ViewController.swift
//  2017_11_30 Concurrency - Exercises
//
//  Created by C4Q on 11/30/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var myTableView: UITableView!
    var countries = [Country](){
        didSet{
            myTableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let countrySetup = countries[indexPath.row]
        guard let cell: UITableViewCell = myTableView.dequeueReusableCell(withIdentifier: "myCell") else {
            let defaultCell = UITableViewCell()
            defaultCell.textLabel?.text = countrySetup.name
            return defaultCell
        }
        cell.textLabel?.text = countrySetup.name
        cell.detailTextLabel?.text = countrySetup.languages.first?.name
        guard let url = URL(string: "http://www.geognos.com/api/en/countries/flag/\(countrySetup.alpha2Code).png") else {
            return cell
        }
        DispatchQueue.global().async {
            guard let rawImage = try? Data(contentsOf: url) else {
                return
            }
            DispatchQueue.main.async {
                guard let onlineImage = UIImage(data: rawImage) else {
                    return
                }
                cell.imageView?.image = onlineImage
                cell.setNeedsLayout()
            }
            
        }
        return cell
    }
    func loadData() {
        let myURL = "https://restcountries.eu/rest/v2/name/united"
        
        let setCountries:([Country])->Void = {(onlineCountries: [Country]) in
            self.countries = onlineCountries
        }
        CountryAPIClient.manager.getCountries(from: myURL, completionHandler: setCountries, errorHandler: {print($0)})
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        loadData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailedCountryViewController{
            let countrySetup = countries[(myTableView.indexPathForSelectedRow?.row)!]
            destination.country = countrySetup
        }
    }
    
}

