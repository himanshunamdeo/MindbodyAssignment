//
//  ProvinceTableViewCell.swift
//  MindbodyAssignment
//
//  Created by MeTaLlOiD on 04/04/22.
//

import UIKit

class ProvinceTableViewCell: UITableViewCell {

    @IBOutlet weak var provinceName: UILabel!
    
    public func updateCell(provinceModel: Province) {
        provinceName.text = provinceModel.Name
    }
}
