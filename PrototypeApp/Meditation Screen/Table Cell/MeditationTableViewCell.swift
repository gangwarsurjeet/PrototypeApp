//
//  MeditationTableViewCell.swift
//  PrototypeApp
//
//  Created by Surjeet on 30/03/21.
//

import UIKit
import SDWebImage

class MeditationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var medImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(_ medication: Meditation) {
        titleLabel.text = medication.title
        descLabel.text = medication.teacherName
        
        if let image = medication.imageUrl, let imageURL = URL(string: image), imageURL.host != nil {
            medImageView.backgroundColor = .clear
            medImageView.sd_setImage(with: imageURL, placeholderImage: nil, options: SDWebImageOptions.progressiveLoad, context: nil)
        } else {
            medImageView.image = nil
            medImageView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }
    }
}
