//
//  Topic.swift
//  PrototypeApp
//
//  Created by Surjeet on 30/03/21.
//

import UIKit

struct TopicModel: Codable {
    var topics: [Topic]?
}

struct Topic: Codable {
    var uuid: String?
    var parentUuid: String?
    var title: String?
    var color: String?
    
    var description: String?
    var descriptionShort: String?

    var thumbnailUrl: String?
    var imageUrl: String?
    
    var meditations: [String]?
    
    var position: Int?
    var featured: Bool?
    
    var subTopicMeditationsCount: Int?
    
    mutating func updateSubTopicMeditationsCount(_ count: Int) {
        subTopicMeditationsCount = count
    }
}
