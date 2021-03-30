//
//  LocationService.swift
//  HopAlong
//
//  Created by Surjeet on 23/01/19.
//  Copyright © 2019 Surjeet. All rights reserved.
//

import UIKit

class LocationService: APIService {

    func getPlaces(_ searchText: String, target:BaseViewController? = nil, complition:@escaping (Any?) -> Void) {
    // https://places.cit.api.here.com/places/v1/autosuggest?at=30.704649,76.717873&q=smartdata%20enterprises&app_id=g7iJxeb2BqEqY2hkckw3&app_code=B4EqjSM2sTcLY8yr7ydzkQ

        let latitude = LocationManager.shared.lastKnownLatitudeAsString ?? "30.704649"
        let longitude = LocationManager.shared.lastKnownLongitudeAsString ?? "76.717873"
        
        let path = "https://places.cit.api.here.com/places/v1/autosuggest?at=\(latitude),\(longitude)&q=\(searchText)&app_id=g7iJxeb2BqEqY2hkckw3&app_code=B4EqjSM2sTcLY8yr7ydzkQ".replacingOccurrences(of: " ", with: "%20")
        
        super.searchAutoComplete(with: .GET, path: path) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .Success(let response):
                    var placesArray = [Place]()
                    if let dict = response as? Dictionary<String, Any> {
                        if let tempArray = dict["results"] as? [Dictionary<String, Any>] {
                            for obj in tempArray {
                                let place = Place(data: obj)
                                placesArray.append(place)
                            }
                        }
                    }
                    complition(placesArray)
                    
                case .Error(let error):
                    print(error)
                }
            }
        }
    }
    
}
