//
//  CountryDetailsViewController.swift
//  MindbodyAssignment
//
//  Created by MeTaLlOiD on 04/04/22.
//

import UIKit

class CountryDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    public var country: Country?
    
    @IBOutlet weak var provinceTableView: UITableView!
    
    private var provinces: [Province]?
    private var refreshControl: UIRefreshControl?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = country?.Name.appending("'s").appending(" Provinces")
        fetchProvinces()
        addRefreshControl()
    }
    
    // Adds Refresh control to the table view in order to provide pull to refresh feature
    private func addRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(fetchProvinces), for: UIControl.Event.valueChanged)
        provinceTableView.addSubview(refreshControl!)
    }
    
    @objc private func fetchProvinces() {
        let request = ProvincesAPIRequest(httpUtility: HttpUtility())
        if let country = country {
            startActivityIndicatorAnimation()
            request.fetchProvinces(countryID: country.ID) { provinces, error in
                self.stopActivityIndicatorAnimation()
                if (error == nil) {
                    if let provinces = provinces {
                        // For Zero proveinces coming in the response
                        if provinces.isEmpty {
                            DispatchQueue.main.async {
                                self.showAlert(title: "Alert", message: "No Provinces found")
                            }
                        }
                        self.provinces = provinces
                        DispatchQueue.main.async {
                            self.provinceTableView.reloadData()
                            self.refreshControl?.endRefreshing()
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showReloadableAlert(title: "Error", message: error!.localizedDescription) { action in
                            self.fetchProvinces()
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Table View datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let provinces = provinces else {
            return 1
        }
        
        return provinces.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProvinceCell") as! ProvinceTableViewCell
        
        if let provinces = provinces {
            let province = provinces[indexPath.row]
            cell.updateCell(provinceModel: province)
        }
        
        return cell
    }
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
