//
//  CountriesViewController.swift
//  MindbodyAssignment
//
//  Created by MeTaLlOiD on 04/04/22.
//

import UIKit

class CountriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var countriesTableView: UITableView!
    
    private var selectedCountry: Country?
    private var countries: [Country]?
    private var refreshControl: UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchCountries()
        addRefreshControl()
    }
    
    // Adds Refresh control to the table view in order to provide pull to refresh feature
    private func addRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(fetchCountries), for: UIControl.Event.valueChanged)
        countriesTableView.addSubview(refreshControl!)
    }
    
    @objc func fetchCountries() {
        startActivityIndicatorAnimation()
        let countriesAPIRequest = CountriesAPIRequest(httpUtility: HttpUtility())
        countriesAPIRequest.fetchCountries { countries, error in
            self.stopActivityIndicatorAnimation()
            if (error == nil) {
                self.countries = countries
                DispatchQueue.main.async {
                    self.countriesTableView.reloadData()
                    self.refreshControl?.endRefreshing()
                }
                
            } else {
                DispatchQueue.main.async {
                    self.showReloadableAlert(title: "Error", message: error!.localizedDescription) { action in
                        self.fetchCountries()
                    }
                }
                
            }
            
        }
    }

    // MARK: - TableViewDelegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let countries = countries {
            let country = countries[indexPath.row]
            selectedCountry = country
            performSegue(withIdentifier: SegueIdentifiers.countryToProvincesSegue.rawValue, sender: nil)
        }
    }
    
    // MARK: - TableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let countries = countries else {
            return 1
        }
        
        return countries.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell") as! CountryTableViewCell
        
        
        if let countries = countries {
            let country = countries [indexPath.row]
            cell.updateCell(countryModel: country)
        }
        
        
        return cell
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.countryToProvincesSegue.rawValue {
            let destinationVC = segue.destination as! CountryDetailsViewController
            destinationVC.country = selectedCountry
        }
    }
    

}
