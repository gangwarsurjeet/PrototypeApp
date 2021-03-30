//
//  WebConstants.swift
//  SwimApp
//
//  Created by Surjeet Singh on 29/11/18.
//  Copyright © 2018 Surjeet Singh. All rights reserved.
//

import Foundation


public struct ServerErrors {

    public static let serviceUnavailable = "The server is temporarily unable to service your request due to maintenance downtime or capacity problems. Please try again later."

}

enum Config {
    
    static let serverUrl = "https://api.hopalong.co.in" //"http://192.168.43.186:3000" //
    static let baseUrl   =  serverUrl + "/v1/" // "http://api.hopalong.co.in/v1/"
    static let socketUrl =  serverUrl
    
    static let autoCompleteUrl = "https://places.cit.api.here.com/places/v1/autosuggest?at=%@&q=%@&app_id=unVvDp9aFvnU6cBEmozj&app_code=SYIpjP_Sc73UoZf6NCh88w"
    
    
    // All end points will be here
    static let USER             = "user"
    
    static let login            = "login"
    static let register         = "register"
    static let socialLogin      = login + "/social"
    static let socialRegister   = login + "/social/register"
    static let logout           = USER + "/logout"
    static let forgotPassword   = USER + "/requestotp/forgotpassword"
    static let resetPassword    = USER + "/validateotp/forgotpassword"

    static let requestOTP       = USER + "/requestotp/sms"
    static let validateOTP      = USER + "/validateotp/sms"
    
    static let requestOTPEmail  = USER + "/requestotp/email"
    static let validateOTPEmail = USER + "/validateotp/email"
    
    static let changePassword   = USER + "/changepassword"
    
    static let updateFCMToken   = USER + "/deviceId/ios"
    static let profile          = USER
    static let uploadProfileImage = USER + "/profileimage"
    
    static let dashboardData   = USER + "/dashboard"
    static let makeOffer       = USER + "/rides/offer"
    static let searchOffers    = USER + "/rides/request"
    static let nearByRides     = USER + "/nearbyrides/"
    
    static let userRides       = USER + "/rides"
    static let bookRide        = USER + "/bookride/"
    static let showInterest    = USER + "/showinterest/"
    static let updateSocketId  = USER + "/socketId_update"
    
    static let cancelInterest  = "cancel/"
    static let cancelBooking   = "cancelbooking/"
    static let deleteRide      = "delete/"
}


enum Keys : String{
    
    //login module
    
    case email = "email"
    case password = "password"
    case name = "name"
    
    static let login : [Keys] = [.email , .password]
    static let register : [Keys] = [.name, .email , .password]

    case fbId = "id"
    static let socialLogin : [Keys] = [.fbId]
    static let socialRegister : [Keys] = [.fbId, .email, .name]
   
    case otp = "otp"
    static let forgotPassword : [Keys] = [.email]
    static let resetPassword : [Keys] = [.email, .password, .otp]

    case oldPassword = "oldPassword"
    static let changePassword : [Keys] = [.oldPassword, .password]

    case phone = "phone"
    case gender = "gender"
    static let updateProfile:[Keys] = [.name, .email, .phone, .gender]
    
    static let requestOTP:[Keys] = [.phone]
    static let validateOTP:[Keys] = [.otp]

    case deviceId = "deviceId"
    static let updateFCMToken:[Keys] = [.deviceId]

    
    case fromAddress = "fromAddress"
    case fromCity = "fromCity"
    case fromLatLong = "fromLatLng"
    case toAddress = "toAddress"
    case toCity = "toCity"
    case toLatLong = "toLatLng"
    case time = "time"
    case price = "price"
    case occupancy = "occupancy"
    
    case vehicleId     = "vehicleId"
    
    static let offerRide:[Keys] = [.fromAddress, .fromCity, .fromLatLong, .toAddress, .toCity, .toLatLong, .time, .price, .occupancy, .vehicleId]
   
    case seats = "peopleTravelling"
    static let searchOffers:[Keys] = [.fromAddress, .fromCity, .fromLatLong, .toAddress, .toCity, .toLatLong, .time, .seats]

    case car = "car"
    static let addUpdateCar:[Keys] = [.name, .email, .car]
    
    case vehicleNumber = "vehicleNumber"
    case vehicleType   = "vehicleType"
    case vehicleModel  = "vehicleModel"
    case id = "_id"
    static let carDetails:[Keys] = [.vehicleModel, .vehicleType, .vehicleNumber, .id]

    case socketID = "socketId"
    static let socketId:[Keys] = [.socketID]
    
    case toUser = "to_userId"
    case fromUser = "from_userId"
    case message = "msg"
    case read = "read"
//    case time = "time"
    static let sendMessage:[Keys] = [.toUser, .fromUser, .message, .read, .time]
    
    static let historyParams:[Keys] = [.fromUser, .toUser]
}
