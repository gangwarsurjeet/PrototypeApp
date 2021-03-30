//
//  Meditation.swift
//  PrototypeApp
//
//  Created by Surjeet on 30/03/21.
//

import UIKit

struct MeditationModel: Codable {
    var meditations: [Meditation]?
}

struct Meditation: Codable {
 
    var backgroundImageUrl: String?
    var descripton: String?
    var featuredPosition: Int?
    var free: Bool?
    var imageUrl: String?
    var meditationOfTheDayDate: String?
    var meditationOfTheDayDescription: String?
    var newUntil: String?
    var playCount: Int?
    var position: Int?
    var releaseDate: String?
    var searchTags: [SearchTags]?
//    var sections: [Int]?
    var teacherName: String?
    var teacherUuid: String?
    var timerShouldCountDown: Bool?
    var title: String?
    var uuid: String?
}


struct SearchTags: Codable {
    var title: String?
    var relatedTerms: [String]?
}
