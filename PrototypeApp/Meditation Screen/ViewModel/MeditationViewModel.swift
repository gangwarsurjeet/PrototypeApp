//
//  MeditationViewModel.swift
//  PrototypeApp
//
//  Created by Surjeet on 30/03/21.
//

import UIKit
import MBProgressHUD

class MeditationViewModel: NSObject {

    var showLoader: ((_ show: Bool)->Void)?
    var networkRequestHandler: ((_ error: Error?)->Void)?

    var topic: Topic?
    var subTopics: [Topic]?
    
    private var medications = [Meditation]()
    private var filteredMedications = [[Meditation]]()
    
    func fetchMedications() {
        showLoader?(true)
        let url = URL(string:"https://tenpercent-interview-project.s3.amazonaws.com/meditations.json")!
        NetworkManager.shared.performRequest(url: url, type: .GET) { [weak self] (result: Result<MeditationModel, Error>) in
            self?.showLoader?(false)
            switch result {
            case .success(let topicModel):
                if let tempArray = topicModel.meditations {
                    let sortedArray = tempArray.sorted { (medication1, medication2) -> Bool in
                        return (medication1.playCount ?? 0) > (medication2.playCount ?? 0)
                    }
                    self?.medications.append(contentsOf: sortedArray)
                }
                self?.filterMedicationForTopic()
            case .failure(let error):
                self?.networkRequestHandler?(error)
            }
        }
    }
    
    private func filterMedicationForTopic() {
        let filtered = self.medications.filter { (medication) -> Bool in
            return topic?.meditations?.contains(medication.uuid ?? "") ?? false
        }
        
        subTopics?.forEach({ (subTopic) in
            let subTopicMeditation = self.medications.filter { (meditaton) -> Bool in
                return subTopic.meditations?.contains(meditaton.uuid ?? "") ?? false
            }
            self.filteredMedications.append(subTopicMeditation)
        })
// Add remaining medications
        self.filteredMedications.append(filtered)
        self.networkRequestHandler?(nil)
    }
}


extension MeditationViewModel {
    
    func getNumberOfSection() -> Int {
        return filteredMedications.count
    }
    
    func heightForHeader(section: Int) -> CGFloat {
        if filteredMedications[section].count > 0 {
            return 40
        }
        return 0
    }
    
    func headerTitle(section: Int) -> String? {
        if (subTopics?.count ?? 0) > section {
            return  subTopics?[section].title
        }
        return "Meditations"
    }
    
    func getNumberOfMedication(section: Int) -> Int {
        return filteredMedications[section].count
    }
    
    func getMedication(indexPath: IndexPath) -> Meditation {
        print("indexPath: \(indexPath.section) \(indexPath.row)")
        return filteredMedications[indexPath.section][indexPath.row]
    }
}
