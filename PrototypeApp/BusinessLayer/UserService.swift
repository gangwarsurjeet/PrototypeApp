//
//  LoginAPIManager.swift
//  iOSArchitecture
//
//  Created by Amit on 23/02/18.
//  Copyright © 2018 smartData. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

enum VerificationType {
    case email, phone
}

public class UserService:APIService {
    
    func doLogin(with values:[String], target:BaseViewController? = nil, complition:@escaping (Any?) -> Void) {
        let param = Keys.login.map(values: values)

        super.startService(with: .POST, path: Config.login, parameters: param, files: []) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .Success(let response):
                    // #parse response here
                    if let dict = response as? Dictionary<String,Any> {
                        let token = dict["token"] as? String ?? ""
                        Utilities.setUserToken(token)
                        
                        complition(token)
                    } else {
                        complition(nil)
                    }
                    
                case .Error(let error):
                    
                    UIAlertController.showAlert(withTitle: "", message: error)
                    complition(nil)
                }
            }
        }
    }
    
    
    func doRegister(with values:[Any], target:BaseViewController? = nil, complition:@escaping (Any?) -> Void) {
        let param = Keys.register.map(values: values)
        
        super.startService(with: .POST, path: Config.register, parameters: param, files: []) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .Success(let response):
                    // #parse response here
                    if let dict = response as? Dictionary<String,Any> {
                        let token = dict["token"] as? String ?? ""
                        Utilities.setUserToken(token)
                        complition(token)
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
    
    func doSocialLogin(with values:[Any], target:BaseViewController? = nil, complition:@escaping (Any?) -> Void) {
        let param = Keys.socialLogin.map(values: values)
        
        super.startService(with: .POST, path: Config.socialLogin, parameters: param, files: []) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .Success(let response):
                    // #parse response here
                    if let dict = response as? Dictionary<String,Any> {
                        let token = dict["token"] as? String ?? ""
                        Utilities.setUserToken(token)
                        
                        complition(token)
                    } else {
                        complition(nil)
                    }
                    
                case .Error(_):
                    // #display error message here
//                    UIAlertController.showAlert(withTitle: "", message: error)
                    complition(nil)
                }
            }
        }
    }
    
    func doSocialRegister(with values:[Any], target:BaseViewController? = nil, complition:@escaping (Any?) -> Void) {
        let param = Keys.socialRegister.map(values: values)
        
        super.startService(with: .POST, path: Config.socialRegister, parameters: param, files: []) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .Success(let response):
                    // #parse response here
                    if let dict = response as? Dictionary<String,Any> {
                        let token = dict["token"] as? String ?? ""
                        Utilities.setUserToken(token)
                        complition(token)
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
    
    
    func doForgotPassword(with values:[Any], target:BaseViewController? = nil, complition:@escaping (Any?) -> Void) {
        let param = Keys.forgotPassword.map(values: values)
        
        super.startService(with: .POST, path: Config.forgotPassword, parameters: param, files: []) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .Success(let response):
                    // #parse response here
                    if let dict = response as? Dictionary<String,Any> {
                        complition("")
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
    
    
    func doResetPassword(with values:[Any], target:BaseViewController? = nil, complition:@escaping (Any?) -> Void) {
        let param = Keys.resetPassword.map(values: values)
        
        super.startService(with: .POST, path: Config.resetPassword, parameters: param, files: []) { (result) in
            
            DispatchQueue.main.async {
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
    
    
    func doChangePassword(with values:[Any], target:BaseViewController? = nil, complition:@escaping (Any?) -> Void) {
        let param = Keys.changePassword.map(values: values)
        
        super.startService(with: .PUT, path: Config.changePassword, parameters: param, files: []) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .Success(let response):
                    // #parse response here
                    if let dict = response as? Dictionary<String,Any> {
                        let msg = dict["msg"] as? String ?? "Password changed successfully"
                        complition(msg)
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
    
    
    func viewUserProfile(with values:[Any], target:BaseViewController? = nil, complition:@escaping (Any?) -> Void) {
        
        super.startService(with: .GET, path: Config.profile, parameters: nil, files: []) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .Success(let response):
                    // #parse response here
                    if let dict = response as? Dictionary<String,Any> {
                        let user = User.init(data: dict)
                        AppInstance.shared.user = user
                        complition(user)
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
    
    func updateImage(_ image: UIImage, target:BaseViewController? = nil, complition:@escaping (Any?) -> Void) {
        if let data = image.jpegData(compressionQuality: 0.3) {
            target?.showLoader()
            
            var headers:[String: String] = [:]
            if let token = Utilities.getUserToken() {
                headers["Authorization"] = "Bearer \(token)"
            }
            
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                multipartFormData.append(data, withName: "filename",fileName: "file.jpg", mimeType: "image/jpg")
            }, to: (Config.baseUrl + Config.uploadProfileImage), method: .put, headers: headers) { (result) in
                DispatchQueue.main.async {
                    target?.hideLoader()
                    switch result {
                    case .success(let upload, _, _):
                        
                        upload.responseJSON { response in
                            if let dict = response.result.value as? Dictionary<String,Any> {
                                let msg = dict["msg"] as? String ?? "Image uploaded successfully"
                                complition(msg)
                            } else {
                                complition(nil)
                            }
                        }
                        
                    case .failure(let encodingError):
                        UIAlertController.showAlert(withTitle: "", message: encodingError.localizedDescription)
                        complition(nil)
                    }
                }
            }
        }
    }
    
    func updateProfile(with values:[Any], target:BaseViewController? = nil, complition:@escaping (Any?) -> Void) {
        let param = Keys.updateProfile.map(values: values)
        
        super.startService(with: .PUT, path: Config.profile, parameters: param, files: []) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .Success(let response):
                    // #parse response here
                    if let dict = response as? Dictionary<String,Any> {
                        let msg = dict["msg"] as? String ?? "Profile updated successfully"
                        if let data = dict["data"] as? Dictionary<String,Any> {
                            let user = User.init(data: data)
                            AppInstance.shared.user = user
                        }
                        complition(msg)
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
    
    func addUpdateCarModel(with values:[Any], target:BaseViewController? = nil, complition:@escaping (Any?) -> Void) {
        let param = Keys.addUpdateCar.map(values: values)
        
        super.startService(with: .PUT, path: Config.profile, parameters: param, files: []) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .Success(let response):
                    // #parse response here
                    if let dict = response as? Dictionary<String,Any> {
                        let msg = dict["msg"] as? String ?? "Records Updated"
                        if let data = dict["data"] as? Dictionary<String,Any> {
                            let user = User.init(data: data)
                            AppInstance.shared.user = user
                        }
                        complition(msg)
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
    
    func requestOTP(with type:VerificationType, target:BaseViewController? = nil, complition:@escaping (Any?) -> Void) {
        
        var urlPath = Config.requestOTPEmail
        if type == .phone {
            urlPath = Config.requestOTP
        }
        target?.showLoader()
        super.startService(with: .GET, path: urlPath, parameters: nil, files: []) { (result) in
            DispatchQueue.main.async {
                target?.hideLoader()
                switch result {
                case .Success(let response):
                    // #parse response here
                    if let dict = response as? Dictionary<String,Any> {
                        let msg = dict["msg"] as? String ?? "SMS sent successfully"
                        complition(msg)
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
 
    func updateFCMToken(with values:[Any], target:BaseViewController? = nil, complition:@escaping (Any?) -> Void) {
        let param = Keys.updateFCMToken.map(values: values)
        
        super.startService(with: .PUT, path: Config.updateFCMToken, parameters: param, files: []) { (result) in
        }
    }
    
    func validateOTP(with values:[Any], type:VerificationType, target:BaseViewController? = nil, complition:@escaping (Any?) -> Void) {
        let param = Keys.validateOTP.map(values: values)
        
        var urlPath = Config.validateOTPEmail
        if type == .phone {
            urlPath = Config.validateOTP
        }
        target?.showLoader()
        super.startService(with: .POST, path: urlPath, parameters: param, files: []) { (result) in
            
            DispatchQueue.main.async {
                target?.hideLoader()
                switch result {
                case .Success(let response):
                    // #parse response here
                    if let dict = response as? Dictionary<String,Any> {
                        let msg = dict["msg"] as? String ?? "Verification successfully"
                        complition(msg)
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

    
    func updateSocketId(with values:[Any], target:BaseViewController? = nil, complition:@escaping (Any?) -> Void) {
        let param = Keys.socketId.map(values: values)
        
        super.startService(with: .POST, path: Config.updateSocketId, parameters: param, files: []) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .Success(let response):
                    // #parse response here
                    if let dict = response as? Dictionary<String,Any> {
                        let msg = dict["msg"] as? String ?? "Verification successfully"
                        complition(msg)
                    } else {
                        complition(nil)
                    }
                    
                case .Error(_):
                    // #display error message here
                
                    complition(nil)
                }
            }
        }
    }
    
    
    func getDashboardData(with target:BaseViewController? = nil, complition:@escaping (Any?) -> Void) {
        
        super.startService(with: .GET, path: Config.dashboardData, parameters: nil, files: []) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .Success(let response):
                    // #parse response here
                    if let dict = response as? Dictionary<String,Any> {
                        print(dict)
                        complition(dict)
                    } else {
                        complition(nil)
                    }
                    
                case .Error(_):
                    // #display error message here
                    
                    complition(nil)
                }
            }
        }
    }

    func logoutUser(with target:BaseViewController? = nil, complition:@escaping (Any?) -> Void) {
        // v1/user/logout/:type/:deviceId"
        let urlPath = Config.logout + "/ios/" + (AppInstance.shared.firebaseToken ?? "")
        super.startService(with: .GET, path: urlPath, parameters: nil, files: []) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                case .Success(let response):
                    // #parse response here
                    if let dict = response as? Dictionary<String,Any> {
                        complition(dict)
                    } else {
                        complition(nil)
                    }
                    
                case .Error(_):
                    // #display error message here
                    complition(nil)
                }
            }
        }
    }
    
}

