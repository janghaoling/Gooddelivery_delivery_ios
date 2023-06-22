//
//  Common.swift
//  User
//
//  Created by imac on 1/1/18.
//  Copyright © 2018 Appoets. All rights reserved.
//

import UIKit
import MessageUI
import KWDrawerController

class Common {
    
    class func isValid(email : String)->Bool{
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@","[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
        return emailTest.evaluate(with: email)
        
    }
    
    class func getBackButton()->UIBarButtonItem{
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        return backItem// This will show in the next view controller being pushed
    }
    
//    class func GMSAutoComplete(fromView : GMSAutocompleteViewControllerDelegate?)->GMSAutocompleteViewController{
//
//    let gmsAutoCompleteFilter = GMSAutocompleteFilter()
//    gmsAutoCompleteFilter.country =  GMSCountryCode
//    gmsAutoCompleteFilter.type = .city
//    let gmsAutoComplete = GMSAutocompleteViewController()
//    gmsAutoComplete.delegate = fromView
//    gmsAutoComplete.autocompleteFilter = gmsAutoCompleteFilter
//    return gmsAutoComplete
//    }
    
    
    class func getCurrentCode()->String?{
        
       return (Locale.current as NSLocale).object(forKey:  NSLocale.Key.countryCode) as? String
  
    }
    
    
    
    //MARK:- Get Countries from JSON
    
    class func getCountries()->[Country]{
        
        var source = [Country]()
        
        if let data = NSData(contentsOfFile: Bundle.main.path(forResource: "countryCodes", ofType: "json") ?? "") as Data? {
            do{
                source = try JSONDecoder().decode([Country].self, from: data)
                
            } catch let err {
                print(err.localizedDescription)
            }
        }
        return source
    }
    
    class func open(url urlString: String) {
        if let  url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    class func getRefreshControl(intableView tableView : UITableView, tintcolorId  : Int = Color.primary.rawValue, attributedText text : NSAttributedString? = nil)->UIRefreshControl{
       
        let rc = UIRefreshControl()
        rc.tintColorId = tintcolorId
        rc.attributedTitle = text
        tableView.addSubview(rc)
        return rc
        
    }
    
    // MARK:- Set Font
    
    class func setFont(to field :Any,isTitle : Bool = false, size : CGFloat = 0, fontType : FontCustom = .meduim) {
        
        let customSize = size > 0 ? size : (isTitle ? 16 : 14)
        let font = UIFont(name: fontType.rawValue, size: customSize)
        
        switch (field.self) {
        case is UITextField:
            (field as? UITextField)?.font = font
        case is UILabel:
            (field as? UILabel)?.font = font
        case is UIButton:
            (field as? UIButton)?.titleLabel?.font = font
        case is UITextView:
            (field as? UITextView)?.font = font
        default:
            break
        }
    }
    
    
    // MARK:- Make Call
    class func call(to number : String?) {
        
        if let providerNumber = number, let url = URL(string: "tel://\(providerNumber)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIScreen.main.focusedView?.make(toast: APPLocalize.localizestring.cannotMakeCallAtThisMoment.localize())
        }
        
    }
    
    // MARK:- Send Email
    class func sendEmail(to mailId : [String], from view : UIViewController & MFMailComposeViewControllerDelegate) {
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = view
            mail.setToRecipients(mailId)
            view.present(mail, animated: true)
        } else {
            UIScreen.main.focusedView?.make(toast: APPLocalize.localizestring.couldnotOpenEmailAttheMoment.localize())
        }
        
    }
    
    // MARK:- Send Message
    
    class func sendMessage(to numbers : [String], text : String, from view : UIViewController & MFMessageComposeViewControllerDelegate) {
        
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = text
            controller.recipients = numbers
            controller.messageComposeDelegate = view
            view.present(controller, animated: true, completion: nil)
        }
    }
    
    // MARK:- Bussiness Image Url
    class func getImageUrl (for urlString : String?)->String {
        
        return baseUrl+"/storage/"+String.removeNil(urlString)
    }
    
    //MARK:- Set Drawer Controller
    class func setDrawerController()->UIViewController {
        
        let drawerController =  DrawerController()
        drawerController.modalPresentationStyle = .fullScreen
        if let sideBarController = Router.main.instantiateViewController(withIdentifier: Storyboard.Ids.SideBarTableViewController) as? SideBarTableViewController  {
            //let drawerSide : DrawerSide = selectedLanguage == .arabic ? .right : .left
            let mainController = Router.main.instantiateViewController(withIdentifier: Storyboard.Ids.navigationController)
            drawerController.setViewController(sideBarController, for: .left)
            drawerController.setViewController(mainController, for: .none)
            drawerController.getSideOption(for: .left)?.isGesture = false
            drawerController.getSideOption(for: .right)?.isGesture = false
        }
        return drawerController
    }
    
    
    class func setProfile(detail : Profile) {
        User.main.id = detail.id
        User.main.name = detail.name
        User.main.email = detail.email
        User.main.currency = detail.currency
        User.main.phone = detail.phone
        //User.main.settlementStatus = detail.status?.rawValue
         User.main.settlementStatus = detail.status
        User.main.avatar = detail.avatar
    }
    
    // Get Full Screen Label
    class func getLabel(with text : String?)->UILabel {
        
        let label = Label(frame: UIScreen.main.bounds)
        label.numberOfLines = 0
        Common.setFont(to: label, isTitle: true)
        label.center = UIApplication.shared.keyWindow?.center ?? .zero
        label.backgroundColor = .clear
        label.textColorId = 1
        label.textAlignment = .center
        label.text = text
        return label
    }
    
}
