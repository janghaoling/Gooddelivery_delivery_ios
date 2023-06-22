//
//  SideBarTableViewController.swift
//  User
//
//  Created by CSS on 02/05/18.
//  Copyright © 2018 Appoets. All rights reserved.
//

import UIKit
import KWDrawerController
import SafariServices

class SideBarTableViewController: UITableViewController {
    
    @IBOutlet private var imageViewProfile : UIImageView!
    @IBOutlet private var labelName : UILabel!
    @IBOutlet private var labelEmail : UILabel!
    @IBOutlet private var viewShadow : UIView!
    @IBOutlet private weak var profileImageCenterContraint : NSLayoutConstraint!
    
    private let profileId = 0
    private let shiftStatusId = 1
    private let noticeBoardId = 2
    private let orderHistoryId = 3
    private let termsId = 4
    private let logoutId = 5

    
    private lazy var sideBarList : [(id : Int,image:UIImage, title : String)] = {
       return [(profileId,#imageLiteral(resourceName: "user"),APPLocalize.localizestring.profile.localize()),(shiftStatusId,#imageLiteral(resourceName: "shop"),APPLocalize.localizestring.shiftStatus.localize()), (noticeBoardId,#imageLiteral(resourceName: "note"),APPLocalize.localizestring.noticeBoard.localize()),(orderHistoryId,#imageLiteral(resourceName: "history"),APPLocalize.localizestring.orderHistory.localize()), (termsId,#imageLiteral(resourceName: "book"),APPLocalize.localizestring.termsAndConditions.localize())]
    }()
    
    private let cellId = "cellId"
    
    private lazy var loader : UIView = {
        
        return createActivityIndicator(self.view)
        
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialLoads()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.localize()
        setLogout()
        self.setValues()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.setLayers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false

    }
    
}

// MARK:- Methods

extension SideBarTableViewController {
    
    private func setLogout(){
        if userDefaults.shiftStatus == "end" {
            sideBarList = [(profileId,#imageLiteral(resourceName: "user"),APPLocalize.localizestring.profile.localize()),(shiftStatusId,#imageLiteral(resourceName: "shop"),APPLocalize.localizestring.shiftStatus.localize()), (noticeBoardId,#imageLiteral(resourceName: "note"),APPLocalize.localizestring.noticeBoard.localize()),(orderHistoryId,#imageLiteral(resourceName: "history"),APPLocalize.localizestring.orderHistory.localize()), (termsId,#imageLiteral(resourceName: "book"),APPLocalize.localizestring.termsAndConditions.localize()),(id: logoutId, image: UIImage(named: ImageString.imageValue.logout)!, title: APPLocalize.localizestring.logout.localize())]
            tableView.reloadData()
        }
    }
    
    private func initialLoads() {
        self.drawerController?.shadowOpacity = 0.2
        let fadeWidth = self.view.frame.width*(0.2)
        self.profileImageCenterContraint.constant = 0
        self.drawerController?.drawerWidth = Float(self.view.frame.width - fadeWidth)
        self.viewShadow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageViewAction)))
        self.setDesigns()
    }
    
    // MARK:- Set Designs
    
    private func setLayers(){
        
        self.imageViewProfile.makeRoundedCorner()
        
    }
    
    
    // MARK:- Set Designs
    private func setDesigns () {
        
        Common.setFont(to: labelName, size : 16, fontType : .extraBold)
        Common.setFont(to: labelEmail, size : 14)
    }
    
    
    //MARK:- SetValues
    
    private func setValues(){
        Cache.image(forUrl:User.main.avatar) { (image) in
            DispatchQueue.main.async {
                self.imageViewProfile.image = image == nil ? #imageLiteral(resourceName: "userPlaceholder") : image
            }
        }
        self.labelName.text = User.main.name
        self.labelEmail.text = User.main.email
    }
    
    
    
    // MARK:- Localize
    private func localize(){
        
        self.tableView.reloadData()
        
    }
    
    // MARK:- ImageView Action
    
    @IBAction private func imageViewAction() {
   
       let homeVC = Router.main.instantiateViewController(withIdentifier: Storyboard.Ids.ProfileViewController)
        (self.drawerController?.getViewController(for: .none) as? UINavigationController)?.pushViewController(homeVC, animated: true)
        self.drawerController?.closeSide()
        
    }
    
    
    // MARK:- Selection Action For TableView
    
    private func select(at indexPath : IndexPath) {
        self.drawerController?.closeSide()
        guard self.sideBarList.count > indexPath.row else {return}
        
        switch (self.sideBarList[indexPath.row].id) {
            
        case profileId:
            self.push(to: Storyboard.Ids.ProfileViewController)
        case shiftStatusId:
            self.push(to: Storyboard.Ids.ShiftStatusViewController)
        case noticeBoardId:
            self.push(to: Storyboard.Ids.NoticeBoardTableViewController)
        case orderHistoryId:
            self.push(to: Storyboard.Ids.OrderHistoryViewController)
            let OrderHistoryModue = OrderHistoryRouter.createModule()
            navigationController?.pushViewController(OrderHistoryModue,animated: true)
            break
        case termsId:
            self.push(to: Storyboard.Ids.TermsConditionViewController)
        case logoutId:
            logout()
        default:
            break
        }
        
    }
    
    private func push(to identifier : String) {
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: identifier)
        (self.drawerController?.getViewController(for: .none) as? UINavigationController)?.pushViewController(viewController, animated: true)
        
    }
    
    
    // MARK:- Logout
    
    private func logout() {
        
        let alert = UIAlertController(title: nil, message: APPLocalize.localizestring.areYouSureWantToLogout.localize(), preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: APPLocalize.localizestring.logout.localize(), style: .destructive) { (_) in
            self.loader.isHidden = false
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "InValidateTimer"), object: nil)
            self.presenter?.get(api: .logout, data: nil)
        }
        

        
        let cancelAction = UIAlertAction(title: APPLocalize.localizestring.Cancel.localize(), style: .cancel, handler: nil)
        
        alert.view.tintColor = .primary
        alert.addAction(logoutAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
}




// MARK:- TableView

extension SideBarTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SideBarTableViewCell
        if self.sideBarList.count>indexPath.row {
            tableCell.set(text: self.sideBarList[indexPath.row].title.localize(), image: self.sideBarList[indexPath.row].image)
        }
        tableCell.selectionStyle = .none
        return tableCell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideBarList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.select(at: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}


// MARK:- PostViewProtocol

extension SideBarTableViewController : PostViewProtocol {
    
    func onError(api: Base, message: String, statusCode code: Int) {
        
        DispatchQueue.main.async {
            self.loader.isHidden = true
            showAlert(message: message, okHandler: nil, fromView: self)
        }
    }
    func getLogoutEntity(api: Base, entity: LogoutEntity?) {
        DispatchQueue.main.async {
            self.loader.isHidden = true
            forceLogout()
        }
    }
}

//MARK:- SFSafariViewControllerDelegate

extension SideBarTableViewController : SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.popOrDismiss(animation: true)
    }
}
