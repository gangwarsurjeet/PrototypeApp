//
//  TopicTableViewCell.swift
//  PrototypeApp
//
//  Created by Surjeet on 30/03/21.
//

import UIKit

class TopicTableViewCell: UITableViewCell {

    @IBOutlet weak var topicTitleLabel: UILabel!
    @IBOutlet weak var meditationCountLabel: UILabel!
    @IBOutlet weak var leftLineView: UIView!
    @IBOutlet weak var containerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
   
        selectionStyle = .none
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = UIColor.black.withAlphaComponent(0.07).cgColor
    }
    
    func setData(_ topic: Topic) {
        topicTitleLabel.text = topic.title
        let count = (topic.meditations?.count ?? 0) + (topic.subTopicMeditationsCount ?? 0)
        meditationCountLabel.text = "\(count) Meditations"
        
        let colorCode = topic.color ?? "#000000"
        leftLineView.backgroundColor = UIColor(rgba: colorCode)
    }
    
}
