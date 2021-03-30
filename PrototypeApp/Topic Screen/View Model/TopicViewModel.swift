//
//  TopicViewModel.swift
//  PrototypeApp
//
//  Created by Surjeet on 30/03/21.
//

import UIKit

class TopicViewModel: NSObject {

    var showLoader: ((_ show: Bool)->Void)?
    var networkRequestHandler: ((_ error: Error?)->Void)?
    
    var allTopics = [Topic]()
    var topics = [Topic]()
    
    func fetchTopics() {
        showLoader?(true)
        let url = URL(string:"https://tenpercent-interview-project.s3.amazonaws.com/topics.json")!
        NetworkManager.shared.performRequest(url: url, type: .GET) { [weak self] (result: Result<TopicModel, Error>) in
            self?.showLoader?(false)
            switch result {
            case .success(let topicModel):
                if let topicArray = topicModel.topics {
                    self?.allTopics.append(contentsOf: topicArray)
                }
                self?.getParentTopics()
            case .failure(let error):
                self?.networkRequestHandler?(error)
            }
        }
    }
    
    private func getParentTopics() {
        let parentTopics = allTopics.filter { (topic) -> Bool in
            return topic.parentUuid == nil
        }.sorted { (topic1, topic2) -> Bool in
            return (topic1.position ?? 0) < (topic2.position ?? 0)
        }
        
        parentTopics.forEach { (topic) in
            let subtopics = allTopics.filter({$0.parentUuid == topic.uuid})
            let meditataionIDs = Set(subtopics.map({$0.meditations ?? []}).joined())
            
            var newTopic = topic
            newTopic.updateSubTopicMeditationsCount(meditataionIDs.count)
            topics.append(newTopic)
        }
//        topics.append(contentsOf: parentTopics)
        self.networkRequestHandler?(nil)
    }
    
    func fetchSubTopics(index: Int) -> [Topic] {
        let topic = getTopic(index: index)
        let subtopics = allTopics.filter({$0.parentUuid == topic.uuid})
        return subtopics
    }
}

extension TopicViewModel {
    func getNumberOfTopics() -> Int {
        return topics.count
    }
    
    func getTopic(index: Int) -> Topic {
        return topics[index]
    }
}
