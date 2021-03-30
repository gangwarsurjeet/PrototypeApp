//
//  MeditationTableHeaderCell.swift
//  PrototypeApp
//
//  Created by Surjeet on 30/03/21.
//

import UIKit

class MeditationTableHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.backgroundColor = .white
    }
}
