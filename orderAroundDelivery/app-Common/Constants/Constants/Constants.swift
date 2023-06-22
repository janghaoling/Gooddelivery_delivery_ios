//
//  Constants.swift
//  Centros_Camprios
//
//  Created by imac on 12/18/17.
//  Copyright © 2017 Appoets. All rights reserved.
//

import UIKit

typealias ViewController = (UIViewController & PostViewProtocol)
var presenterObject : PostPresenterInputProtocol?


//MARK:- Constant Strings

struct APPLocalize {
    
    static let localizestring = APPLocalize()
    
    // changeLanguage
    let English = "localize.English"
    let Arabic = "localize.Arabic"
    let Japanese = "localize.Japanese"
    let Spanish = "localize.Spanish"

    let startedTowardsRestaurant = "localize.startedTowardsRestaurant"
    let disputeTitle = "localize.disputeTitle"
    let dispute = "localize.dispute"
    let cancel = "localize.Cancel"
    let total = "localize.total"
    let reachedRestaurent = "localize.reachedRestaurent"
    let orderPickedUp = "localize.orderPickedUp"
    let orderDelivered = "localize.orderDelivered"
    let completed = "localize.completed"
    let sumbit = "localize.sumbit"
    let newOrderRequest = "localize.newOrderRequest"
    let waitingNewTask = "localize.waitingNewTask"
    let cash = "localize.cash"
    let wallet = "localize.wallet"
    let paymentMode = "localize.paymentMode"
    let orderDeliveredSucess = "localize.orderDeliveredSucess"
    let orderCancelled = "localize.orderCancelled"
    let home = "localize.home"
    let ongoingRequest = "localize.ongoingRequest"
    let liveTasks = "localize.liveTasks"

    let Done = "localize.Done"
    let Back = "localize.Back"
   
    let noDevice = "localize.noDevice"
    let Currency = "localize.Currency"
    let manual = "localize.manual"
    let OK = "localize.OK"
    let Cancel = "localize.Cancel"
    let NA = "localize.NA"
    let MobileNumber = "localize.MobileNumber"
    let next = "localize.next"
    let selectSource = "localize.selectSource"
    let camera = "localize.camera"
    let photoLibrary = "localize.photoLibrary"
    let cannotMakeCallAtThisMoment = "localize.cannotMakeCallAtThisMoment"
    let couldnotOpenEmailAttheMoment = "localize.couldnotOpenEmailAttheMoment"
    let areYouSureWantToLogout = "localize.areYouSureWantToLogout"
    let continueText = "localize.continueText"
    let enterMobileNumber = "localize.enterMobileNumber"
    let inValidPhoneNumber = "localize.inValidPhoneNumber"
    let enterOtp = "localize.enterOtp"
    let verficationCode = "localize.verficationCode"
    let verficationSentText = "localize.verficationSentText"
    let turnOnShift = "localize.turnOnShift"
    let shiftStatus = "localize.shiftStatus"
    let startShift = "localize.startShift"
    let endShift = "localize.endShift"
    let youOwned = "localize.youOwned"
    let profile = "localize.Profile"
    let noticeBoard = "localize.noticeBoard"
    let orderHistory = "localize.orderHistory"
    let termsAndConditions = "localize.termsAndConditions"
    let logout = "localize.logout"
  //  let liveTasks = "localize.liveTasks"
    let waitingForTheNewTask = "localize.waitingForTheNewTask"
  //  let newOrderRequest = "localize.newOrderRequest"
    let accept = "localize.accept"
    let newTask = "localize.newTask"
    let completedTask = "localize.completedTask"
    let selectCountryCode = "localize.selectCountryCode"
    let otpIncorrect = "localize.otpIncorrect"
    let couldNotReachTheHost = "localize.couldNotReachTheHost"
    let amountTobePaid = "localize.amountTobePaid"
    let handovertheAmount = "localize.handovertheAmount"
    let orders = "localize.orders"
    let order = "localize.order"
    let noOrders = "localize.noOrders"
    let breakString = "localize.breakString"
    let selectVehicle = "localize.selectVehicle"
    let novehicleList = "localize.novehicleList"
    let chooseVehicle = "localize.chooseVehicle"
    let selectVehicleNumber = "localize.selectVehicleNumber"
    let enterTheVehicleNumber = "localize.enterTheVehicleNumber"
    let or = "localize.or"
  //  let home = "localize.home"
    let noNotices = "localize.noNotices"
    let userId = "localize.userId"
    let userName = "localize.userName"
    let email = "localize.email"
    let phoneNumber = "localize.phoneNumber"
    let update = "localize.update"
    let enterName = "localize.enterName"
    let enterEmail = "localize.enterEmail"
    let updatedSuccessfully = "localize.updatedSuccessfully"
    let NavigationshiftStatus = "localize.NavigationshiftStatus"
    let todayCompletedTasks = "localize.todayCompletedTasks"
    let noResultFound = "localize.noResult"
    let orderHistoryNavTitle = "localize.orderHistoryNavTitle"
    let termsconditionNavTitle = "localize.termsandconditionNavTitle"
    let shiftStatusValue = ""
}

//Defaults Keys

struct Keys {
    
    static let list = Keys()
    let userData = "userData"
    
    let id = "id"
    let name = "name"
    let accessToken = "access_token"
    let latitude = "latitude"
    let lontitude = "lontitude"
    let coOrdinates = "coOrdinates"
    let firstName = "firstName"
    let lastName = "lastName"
    let avatar = "avatar"
    let email = "email"
    let phone = "phone"
    let language = "language"
    let currency = "currency"
    let settlementStatus = "settlementStatus"
}

struct ImageString {
    static let imageValue = ImageString()
    let process_1 = "process_1"
    let process_2 = "process_2"
    let process_3 = "process_3"
    let process_4 = "process_4"
    let process_5 = "process_5"
    let next_process_1 = "next_process_1"
    let next_process_2 = "next_process_2"
    let next_process_3 = "next_process_3"
    let next_process_4 = "next_process_4"
    let next_process_5 = "next_process_5"
    let backicon = "back-icon"
    let checked = "checked"
    let ordercancelled = "ordercancelled"
    let hourglass = "hour-glass"
    let handOverCash = "handOverCash"
    let purchase = "purchase"
    let logout = "logout"
    let menu = "menu"
}

// Date Formats

struct DateFormat {
    
    static let list = DateFormat()
    let yyyy_mm_dd_HH_MM_ss = "yyyy-MM-dd HH:mm:ss"
    let MMM_dd_yyyy_hh_mm_ss_a = "MMM dd, yyyy hh:mm:ss a"
    let hh_mm_a = "hh:mm a"
    let MMM_dd_yyyy = "MMM dd, yyyy"
}


struct userDefaults {
    
    static var shiftStatus: String {
        get {
            return UserDefaults.standard.string(forKey: APPLocalize.localizestring.shiftStatusValue) ?? String.Empty
        }
        set {
            UserDefaults.standard.set(newValue, forKey: APPLocalize.localizestring.shiftStatusValue)
        }
    }
    
    
    static func clearAll() {
        shiftStatus = String.Empty
    }
}



// Devices

enum DeviceType : String, Codable {
    
    case ios = "ios"
    case android = "android"
    
}

struct Constants {
    
    static let string = Constants()
    
    let empty = ""
    let noDevice = "no device"
    let English = "English"
    let Arabic = "Arabic"
    let Spanish = "Spanish"
    let uploadFileName = "avatar"
    let addZero = ".00"
    let Japanese = "Japanese"
    
    
}

//enum Language : String {
//    
//    case english = "en"
//    case spanish = "es"
//    
//}



enum defaultSystemSound : Float {
    case peek = 1519
    case pop = 1520
    case cancelled = 1521
    case tryAgain = 1102
    case Failed = 1107
}


enum SettlementStatus : String, Codable {
    case online = "online"
    case offline = "offline"
    case settled = "settled"
    case unsettled = "unsettled"
}




// MARK: - Font
enum NunitoText: String {
    case nunitoTextbold = "Nunito-Bold"
    case nunitoTextBlack = "Nunito-Black"
    case nunitoTextExtraBold = "Nunito-ExtraBold"
    case nunitoTextExtraLight = "Nunito-ExtraLight"
    case nunitoTextregular = "Nunito-Regular"
    case nunitoTextmedium = "Nunito-Medium"
    case nunitoTextlight = "Nunito-Light"
    case nunitoTextsemibold = "Nunito-SemiBold"
}

// MARK: - Gobal Colors
struct GlobalColorConstants {
    static let whiteColor: UIColor = UIColor.white
    static let blackColor: UIColor = UIColor.black
    static let redColor: UIColor = UIColor(red: 235/255.0, green: 50/255.0, blue: 35/255.0, alpha: 1.0)
    static let orangeColor: UIColor = UIColor(red: 242/255.0, green: 150/255.0, blue: 82/255.0, alpha: 1.0)
}

enum ShiftStatus : String {
    case none
    case started
    case ended
    
    var shiftString : String {
        switch self {
        case .none:
            return APPLocalize.localizestring.startShift.localize()
        case .started:
            return APPLocalize.localizestring.endShift.localize()
        case .ended:
            return APPLocalize.localizestring.NA.localize()
        }
    }
}


