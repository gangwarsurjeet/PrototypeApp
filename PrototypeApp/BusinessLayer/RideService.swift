//
//  RideService.swift
//  HopAlong
//
//  Created by Surjeet on 26/01/19.
//  Copyright © 2019 Surjeet. All rights reserved.
//

import UIKit

class RideService: APIService {

    func makeOffer(with values:[Any], target:BaseViewController? = nil, complition:@escaping (Any?) -> Void) {
        let param = Keys.offerRide.map(values: values)
        target?.showLoader()
        super.startService(with: .POST, path: Config.makeOffer, parameters: param, files: []) { (result) in
            
            DispatchQueue.main.async {
                target?.hideLoader()
                switch result {
                case .Success(let response):
                    // #parse response here
                    if let dict = response as? Dictionary<String,Any> {
//                        let message = dict["msg"] as? String ?? ""
                        complition(dict)
                    } else {
                        complition(nil)
                    }
                    
                case .Error(let error):
                    // #display error message here
                    UIAlertController.showAlert(withTitle: "", message: error)
                    complition(nil)
                }
            }
        }
    }

    
    func searchOffers(with values:[Any], target:BaseViewController? = nil, complition:@escaping (Any?) -> Void) {
        let param = Keys.searchOffers.map(values: values)
        target?.showLoader()
        super.startService(with: .POST, path: Config.searchOffers, parameters: param, files: []) { (result) in
            
            DispatchQueue.main.async {
                target?.hideLoader()
                switch result {
                case .Success(let response):
                    // #parse response here
                    if let dict = response as? Dictionary<String,Any> {
                        complition(dict)
                    } else {
                        complition(nil)
                    }
                    
                case .Error(let error):
                    // #display error message here
                    UIAlertController.showAlert(withTitle: "", message: error)
                    complition(nil)
                }
            }
        }
    }

    func searchNearByRiders(with type: String, requestId: String, target:BaseViewController? = nil, complition:@escaping (Any?) -> Void) {
        target?.showLoader()
        let urlPath = Config.nearByRides + "\(type)/" + "\(requestId)"
        super.startService(with: .GET, path: urlPath, parameters: nil, files: []) { (result) in
            
            DispatchQueue.main.async {
                target?.hideLoader()
                switch result {
                case .Success(let response):
                    // #parse response here
                    if let tempArray = response as? [Dictionary<String,Any>] {
                        var newArray = [NearByRides]()
                        for dict in tempArray {
                            let rides = NearByRides(dict)
                            newArray.append(rides)
                          }
                        complition(newArray)
                    } else {
                        complition(nil)
                    }
                    
                case .Error(let error):
                    // #display error message here
//                    UIAlertController.showAlert(withTitle: "", message: error)
                    complition(nil)
                }
            }
        }
    }
 
    
    func userRides(with target:BaseViewController? = nil, complition:@escaping (Any?) -> Void) {
        target?.showLoader()
        let urlPath = Config.userRides
        super.startService(with: .GET, path: urlPath, parameters: nil, files: []) { (result) in
            
            DispatchQueue.main.async {
                target?.hideLoader()
                switch result {
                case .Success(let response):
                    if let tempArray = response as? [Dictionary<String,Any>] {
                        var rides = [Rides]()
                        for obj in tempArray {
                            let ride = Rides(obj)
                            rides.append(ride)
                        }
                        complition(rides)
                    } else {
                        complition(nil)
                    }
                    
                case .Error(let error):
                    // #display error message here
//                    UIAlertController.showAlert(withTitle: "", message: error)
                    complition(nil)
                }
            }
        }
    }
    
    func showInterest(with type: String, reqId:String, rideId:String, target:BaseViewController? = nil, complition:@escaping (Any?) -> Void) {
        target?.showLoader()
        let urlPath = Config.showInterest + "\(type)/" + "\(reqId)/" + "\(rideId)"
        print(urlPath)
        super.startService(with: .GET, path: urlPath, parameters: nil, files: []) { (result) in
            DispatchQueue.main.async {
                target?.hideLoader()
                switch result {
                case .Success(let response):
                    if let dict = response as? Dictionary<String,Any> {
                        let message = dict["msg"] as? String ?? ""
                        complition(message)
                    } else {
                        complition(nil)
                    }

                case .Error(let error):
                    // #display error message here
                    UIAlertController.showAlert(withTitle: "", message: error)
                    complition(nil)
                }
            }
        }
    }

    func bookRide(with type: String, reqId:String, rideId:String, target:BaseViewController? = nil, complition:@escaping (Any?) -> Void) {
        target?.showLoader()
        let urlPath = Config.bookRide + type + "/\(reqId)" + "/\(rideId)"
        
        super.startService(with: .GET, path: urlPath, parameters: nil, files: []) { (result) in
            
            DispatchQueue.main.async {
                target?.hideLoader()
                switch result {
                case .Success(let response):
                    if let dict = response as? Dictionary<String,Any> {
                        let message = dict["msg"] as? String ?? ""
                        complition(message)
                    } else {
                        complition(nil)
                    }
                    
                case .Error(let error):
                    // #display error message here
                    UIAlertController.showAlert(withTitle: "", message: error)
                    complition(nil)
                }
            }
        }
    }
    
    
    func cancelInterest(with type: String, reqId:String, rideId:String, target:BaseViewController? = nil, complition:@escaping (Any?) -> Void) {
        target?.showLoader()
        let urlPath = Config.cancelInterest + type + "/\(rideId)" + "/\(reqId)"
        
        super.startService(with: .GET, path: urlPath, parameters: nil, files: []) { (result) in
            
            DispatchQueue.main.async {
                target?.hideLoader()
                switch result {
                case .Success(let response):
                    if let dict = response as? Dictionary<String,Any> {
                        let message = dict["msg"] as? String ?? ""
                        complition(message)
                    } else {
                        complition(nil)
                    }
                    
                case .Error(let error):
                    // #display error message here
                    UIAlertController.showAlert(withTitle: "", message: error)
                    complition(nil)
                }
            }
        }
    }
    
    func cancelBooking(with type: String, reqId:String, rideId:String, target:BaseViewController? = nil, complition:@escaping (Any?) -> Void) {
        target?.showLoader()
        let urlPath = Config.cancelBooking + type + "/\(rideId)" + "/\(reqId)"
        
        super.startService(with: .GET, path: urlPath, parameters: nil, files: []) { (result) in
            
            DispatchQueue.main.async {
                target?.hideLoader()
                switch result {
                case .Success(let response):
                    if let dict = response as? Dictionary<String,Any> {
                        let message = dict["msg"] as? String ?? ""
                        complition(message)
                    } else {
                        complition(nil)
                    }
                    
                case .Error(let error):
                    // #display error message here
                    UIAlertController.showAlert(withTitle: "", message: error)
                    complition(nil)
                }
            }
        }
    }

    func deleteBooking(with type: String, reqId:String, target:BaseViewController? = nil, complition:@escaping (Any?) -> Void) {
        target?.showLoader()
        let urlPath = Config.deleteRide + type + "/\(reqId)"
        
        super.startService(with: .DELETE, path: urlPath, parameters: nil, files: []) { (result) in
            
            DispatchQueue.main.async {
                target?.hideLoader()
                switch result {
                case .Success(let response):
                    if let dict = response as? Dictionary<String,Any> {
                        let message = dict["msg"] as? String ?? ""
                        complition(message)
                    } else {
                        complition(nil)
                    }
                    
                case .Error(let error):
                    // #display error message here
                    UIAlertController.showAlert(withTitle: "", message: error)
                    complition(nil)
                }
            }
        }
    }
    
}
