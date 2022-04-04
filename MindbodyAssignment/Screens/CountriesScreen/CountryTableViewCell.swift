//
//  CountryTableViewCell.swift
//  MindbodyAssignment
//
//  Created by MeTaLlOiD on 04/04/22.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var flagImageView: LazyImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    
    func updateCell(countryModel: Country) {
        flagImageView.loadExternalImage(countryName: countryModel.Code)
        countryNameLabel.text = countryModel.Name
    }
}

