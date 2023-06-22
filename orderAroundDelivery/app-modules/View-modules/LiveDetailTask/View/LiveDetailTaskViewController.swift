//
//  LiveDetailTaskViewController.swift
//  Project
//
//  Created by CSS on 29/01/19.
//  Copyright © 2019 css. All rights reserved.
//

import UIKit
import CoreLocation

class LiveDetailTaskViewController: UIViewController {

    @IBOutlet weak var OverView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var timeLeftValueLabel: UILabel!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantAddressLabel: UILabel!
    @IBOutlet weak var phoneCallButton: UIButton!
    @IBOutlet weak var orderIdLabel: UILabel!
    @IBOutlet weak var orderTimeLabel: UILabel!
    @IBOutlet weak var orderStatusLabel: UILabel!
    @IBOutlet weak var swipeView: UIView!
    @IBOutlet weak var itemTableView: UITableView!
    @IBOutlet weak var mapDirectionButton: UIButton!
    @IBOutlet weak var trackingView: UIStackView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var itemTotalLabel: UILabel!
    @IBOutlet weak var walletDeductionLabel: UILabel!
    @IBOutlet weak var walletDeductionValueLabel: UILabel!
    @IBOutlet weak var discountValueLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var serviceTaxValueLabel: UILabel!
    @IBOutlet weak var serviceTaxLabel: UILabel!
    @IBOutlet weak var itemTotalValueLabel: UILabel!
    @IBOutlet weak var deliveryChargesValueLabel: UILabel!
    @IBOutlet weak var deliveryChargesLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var orderItemHeight: NSLayoutConstraint!
    @IBOutlet weak var startedToRestaurantImageView: UIImageView!
    @IBOutlet weak var paymentProcessImageView: UIImageView!
    @IBOutlet weak var reachedRestaurantImageView: UIImageView!
    @IBOutlet weak var orderPickedUpImageView: UIImageView!
    @IBOutlet weak var orderDeliveredImageView: UIImageView!
    @IBOutlet weak var processSlider: UISlider!
    @IBOutlet weak var startedToRestaurantView: UIView!
    @IBOutlet weak var paymentProcessView: UIView!
    @IBOutlet weak var reachedRestaurantView: UIView!
    @IBOutlet weak var orderPickedUpView: UIView!
    @IBOutlet weak var orderDeliveredView: UIView!
    
    var timerTOCallServer: Timer?
    var checkString = ""
    var timerDic = NSDictionary()
    var processImageView:UIImage!
    var phoneNumberStr = ""
    var destinationLat:Double = 0
    var destinationLong:Double = 0
    var loopCount = 0
    var checkTrackingString = ""
    var order_otp = ""
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    var currentLat = ""
    var currentLong = ""
    let sideMenuBtn = UIButton(type: .custom)
    var orderProcessingStatus = ""
    var Data: OrdersEntity?
    var balanceAmtStr = ""
    var enterAmtStr = ""
    private lazy var loader : UIView = {
        return createLottieLoader(in: UIApplication.shared.keyWindow ?? self.view)
    }()

    //MARK: - View Life Cycle

    // ViewWillAppear
    override func viewDidAppear(_ animated: Bool) {
        loopCount = 1
        checkLiveOrderRequestApi()
        checkString = "Yes"
        
        
    }
    // ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.presenter?.get(api: .liveOrders, data: nil)
    }
    // viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        if (timerTOCallServer != nil) {
            
            timerTOCallServer?.invalidate()
            timerTOCallServer = nil
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initalLoad()
    }
    
    // viewDidLayoutSubviews menthod
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        circleviewDesignwithShadow(self.startedToRestaurantView)
        circleviewDesignwithShadow(self.reachedRestaurantView)
        circleviewDesignwithShadow(self.orderPickedUpView)
        circleviewDesignwithShadow(self.orderDeliveredView)
        circleviewDesignwithShadow(self.paymentProcessView)
        
    }

    //MARK: - Button Actions

    
    //map direction Button Action
    @IBAction func mapDirectionAction(_ sender: Any) {
        
        print("\(currentLat), \(currentLong), \(Data?.address?.latitude ?? 0), \(Data?.address?.longitude ?? 0)")
        
        let googleMapurl = URL(string: "comgooglemaps://?saddr=\(currentLat),\(currentLong)&daddr=\(Data?.shop?.latitude ?? 0),\(Data?.shop?.longitude ?? 0)&dirflg=r")
        

        if let url = URL(string: "comgooglemaps://?") {
            if UIApplication.shared.canOpenURL(googleMapurl!) {
                UIApplication.shared.open(googleMapurl!, options: [
                        UIApplication.OpenExternalURLOptionsKey(rawValue: ""): ""
                        ], completionHandler: nil)
            } else {
                //        [Utilities showAlert:@"Please install Google maps to Navigate"];
                print("Can't use comgooglemaps://")
            }
        }
    }
    //phone button Action
    @IBAction func onPhoneCallAction(_ sender: Any) {
        let phoneNumber = "tel://" + ("\(phoneNumberStr)")
        if let url = URL(string: phoneNumber) {
            UIApplication.shared.open(url, options: [
                UIApplication.OpenExternalURLOptionsKey(rawValue: ""): ""
                ], completionHandler: nil)
        }
    }
    
    
   
    // accept Button Action
    @IBAction func onAcceptButtonAction(_ sender: Any) {
        self.loader.isHidden = false
        if checkTrackingString == "Order Received" {
            timeView.isHidden = true
            trackingView.isHidden = false
            acceptButton.setTitle("REACHED RESTAURANT", for: .normal)
            checkTrackingString = "REACHED RESTAURANT"
            self.orderProcessing(orderStatus: "PROCESSING")
//            self.metersAwayLbl.hidden = YES;

        }else if checkTrackingString == "REACHED RESTAURANT" {
            self.timeView.isHidden = true
            self.trackingView.isHidden = false
            self.orderProcessing(orderStatus: "REACHED")
            checkTrackingString = "ORDER PICKED UP"
            acceptButton.setTitle("ORDER PICKED UP", for: .normal)
            reachedRestaurantView.backgroundColor = UIColor.UpcomingColor
            reachedRestaurantImageView.setImageColor(color: UIColor.white)
            orderPickedUpView.backgroundColor = UIColor.baseColor
           
            
        }else if checkTrackingString == "ORDER PICKED UP" {
            self.timeView.isHidden = true
            self.trackingView.isHidden = false
            self.orderProcessing(orderStatus: "PICKEDUP")
            checkTrackingString = "ORDER DELIVERED"
            acceptButton.setTitle("ORDER DELIVERED", for: .normal)
            reachedRestaurantView.backgroundColor = UIColor.baseColor
            orderDeliveredImageView.setImageColor(color: UIColor.white)
            orderDeliveredView.backgroundColor = UIColor.UpcomingColor

            Cache.image(forUrl: Data?.user?.avatar) { (image) in
                DispatchQueue.main.async {
                    self.restaurantImageView.image = image == nil ? #imageLiteral(resourceName: "userPlaceholder") : image
                }
            }
            restaurantNameLabel.text = Data?.user?.name?.uppercased()
            restaurantAddressLabel.text = Data!.address?.map_address
            destinationLat = (Data?.address?.latitude)!
            destinationLong = (Data?.address?.latitude)!
            phoneNumberStr = (Data?.user?.phone)!

        }else if checkTrackingString == "ORDER DELIVERED" {
            self.timeView.isHidden = true
            self.trackingView.isHidden = false
            self.orderProcessing(orderStatus: "ARRIVED")
            
            orderDeliveredView.backgroundColor = UIColor.baseColor
            paymentProcessView.backgroundColor = UIColor.UpcomingColor
            paymentProcessImageView.setImageColor(color: UIColor.white)
            
            if(Data?.safe_delivery == 0){
                 showAmountPaidAppears()
            }
            else{
                self.orderProcessing(orderStatus: "COMPLETED")
            }
           
            
        }else if checkTrackingString == "COMPLETED" {
            nextScreenVC()

        }
    }
    
    
    
    
    // process Slider Touch In Action
    @IBAction func ontouchUpInSlider(_ sender: UISlider) {
        
       // DispatchQueue.main.async {
            print("slider value \(sender.value)")
            sender.setThumbImage(UIImage(named: ImageString.imageValue.next_process_1), for: .normal)
            if sender.value > 0.5 {
                sender.setThumbImage(UIImage(named: ImageString.imageValue.process_1), for: .normal)
                sender.value = 0.0
            } else {
                sender.value = 0.0
            }
       // }
        

        
    }
    func sliderImage(){
        if (checkTrackingString == "ASSIGNED") {
            print(processSlider.value)
            if processSlider.value >= 0.5 {
                
                processImageView  = UIImage(named: ImageString.imageValue.next_process_1)
                processSlider.setThumbImage(processImageView, for: .normal)
            } else {
                
                self.processImageView = UIImage(named:  ImageString.imageValue.process_1)
                self.processSlider.setThumbImage(self.processImageView, for: .normal)
                
            }
        } else if (checkTrackingString == "PROCESSING") {
            
            
            if processSlider.value >= 0.5 {
                
                processImageView = UIImage(named: ImageString.imageValue.next_process_2)
                processSlider.setThumbImage(processImageView, for: .normal)
            } else {
                
                self.processImageView = UIImage(named: ImageString.imageValue.process_2)
                self.processSlider.setThumbImage(self.processImageView, for: .normal)
                
            }
        }else if (checkTrackingString == "REACHED"){
            if (self.processSlider.value >= 0.5) {
                processImageView = UIImage(named: ImageString.imageValue.next_process_3)
                processSlider.setThumbImage(processImageView, for: .normal)
            }else{
                
                self.processImageView = UIImage(named: ImageString.imageValue.process_3)
                self.processSlider.setThumbImage(self.processImageView, for: .normal)
                
            }
            
        }
        else if (checkTrackingString == "PICKEDUP"){
            if (self.processSlider.value >= 0.5) {
                UIView.animate(withDuration: 0.2) {
                    self.processImageView = UIImage(named: ImageString.imageValue.next_process_4)
                    self.processSlider.setThumbImage(self.processImageView, for: .normal)
                }
                
                
            }else{
                
                UIView.animate(withDuration: 0.2) {
                    self.processImageView = UIImage(named: ImageString.imageValue.process_4)
                    self.processSlider.setThumbImage(self.processImageView, for: .normal)
                }
                
                
            }
            
        }
        else if (checkTrackingString == "ARRIVED"){
            if (self.processSlider.value >= 0.5) {
                processImageView = UIImage(named: ImageString.imageValue.next_process_5)
                processSlider.setThumbImage(processImageView, for: .normal)
            }else{
                
                self.processImageView = UIImage(named: ImageString.imageValue.process_5)
                self.processSlider.setThumbImage(self.processImageView, for: .normal)
                
            }
            
        }
    }
    
    
    @objc func handleTouchDown(sender:UISlider) {
        print(sender.value)
        
//        if sender.value > 0.5 {
//            sender.value = 0
//        } else {
//            sender.value = 0
//        }
        
        
//        if processSlider.value == 1 {
//            self.loader.isHidden = false
//            processSlider.value = 0
//
//            if (checkTrackingString == "ASSIGNED") {
//
//                orderProcessing(orderStatus: "PROCESSING")
//            } else if (checkTrackingString == "PROCESSING") {
//
//                orderProcessing(orderStatus: "REACHED")
//            } else if (checkTrackingString == "REACHED") {
//
//                orderProcessing(orderStatus: "PICKEDUP")
//            } else if (checkTrackingString == "PICKEDUP") {
//
//                orderProcessing(orderStatus: "ARRIVED")
//            } else if (checkTrackingString == "COMPLETED") {
//            }
//
//            sliderImage()
//            orderStatusLabel.alpha = 1.0
//        } else {
//            processSlider.value = 0
//            sliderImage()
//        }
        
        sender.setThumbImage(nil, for: UIControl.State.normal)
        if (checkTrackingString == "ASSIGNED") {
            print(sender.value)
            if sender.value >= 0.9 {
                self.loader.isHidden = false
                processImageView  = UIImage(named: ImageString.imageValue.next_process_1)
                sender.setThumbImage(processImageView, for: .normal)
                orderProcessing(orderStatus: "PROCESSING")
                sender.value = 0

            } else {
                sender.value = 0

                self.processImageView = UIImage(named:  ImageString.imageValue.process_1)
                sender.setThumbImage(self.processImageView, for: .normal)
                
            }
        } else if (checkTrackingString == "PROCESSING") {
            
            
            if sender.value >= 0.9{
                sender.value = 0
                self.loader.isHidden = false
                processImageView = UIImage(named: ImageString.imageValue.next_process_2)
                sender.setThumbImage(processImageView, for: .normal)
                orderProcessing(orderStatus: "REACHED")

            } else {
                sender.value = 0

                self.processImageView = UIImage(named: ImageString.imageValue.process_2)
               sender.setThumbImage(self.processImageView, for: .normal)
                
            }
        }else if (checkTrackingString == "REACHED"){
            if (sender.value >= 0.9) {
                self.loader.isHidden = false
                processImageView = UIImage(named: ImageString.imageValue.next_process_3)
                sender.setThumbImage(processImageView, for: .normal)
                orderProcessing(orderStatus: "PICKEDUP")
                sender.value = 0

            }else{
                sender.value = 0

                self.processImageView = UIImage(named: ImageString.imageValue.process_3)
                sender.setThumbImage(self.processImageView, for: .normal)
                
            }
            
        }
        else if (checkTrackingString == "PICKEDUP"){
            if (sender.value >= 0.9) {
                self.loader.isHidden = false
                    self.processImageView = UIImage(named: ImageString.imageValue.next_process_4)
                   sender.setThumbImage(self.processImageView, for: .normal)
                orderProcessing(orderStatus: "ARRIVED")
                sender.value = 0

                
                
            }else{
                sender.value = 0

                    self.processImageView = UIImage(named: ImageString.imageValue.process_4)
                    sender.setThumbImage(self.processImageView, for: .normal)
                
                
            }
            
        }
        else if (checkTrackingString == "ARRIVED"){
            if (sender.value >= 0.9) {
                sender.value = 0
                self.loader.isHidden = false
                processImageView = UIImage(named: ImageString.imageValue.next_process_5)
                sender.setThumbImage(processImageView, for: .normal)
            }else{
                sender.value = 0

                self.processImageView = UIImage(named: ImageString.imageValue.process_5)
                sender.setThumbImage(self.processImageView, for: .normal)
                
            }
            
        }
    }
    
    // process Slider Value Change
    @IBAction func onsliderValueChanged(_ sender: UISlider) {
       print("slider \(sender.value)")
        // orderStatusLabel.alpha = CGFloat(1.0 - (processSlider.value + 0.2))
       /* processSlider.setThumbImage(nil, for: UIControl.State.normal)
        if (checkTrackingString == "ASSIGNED") {
            print(processSlider.value)
            if processSlider.value >= 0.5 {
                
                processImageView  = UIImage(named: ImageString.imageValue.next_process_1)
                processSlider.setThumbImage(processImageView, for: .normal)
            } else {

                    self.processImageView = UIImage(named:  ImageString.imageValue.process_1)
                    self.processSlider.setThumbImage(self.processImageView, for: .normal)
                
            }
        } else if (checkTrackingString == "PROCESSING") {
            
            
            if processSlider.value >= 0.5 {
                
                processImageView = UIImage(named: ImageString.imageValue.next_process_2)
                processSlider.setThumbImage(processImageView, for: .normal)
            } else {
        
                self.processImageView = UIImage(named: ImageString.imageValue.process_2)
                    self.processSlider.setThumbImage(self.processImageView, for: .normal)
              
            }
        }else if (checkTrackingString == "REACHED"){
            if (self.processSlider.value >= 0.5) {
                processImageView = UIImage(named: ImageString.imageValue.next_process_3)
                processSlider.setThumbImage(processImageView, for: .normal)
            }else{
              
                self.processImageView = UIImage(named: ImageString.imageValue.process_3)
                self.processSlider.setThumbImage(self.processImageView, for: .normal)
               
            }
            
        }
        else if (checkTrackingString == "PICKEDUP"){
            if (self.processSlider.value >= 0.5) {
                UIView.animate(withDuration: 0.2) {
                    self.processImageView = UIImage(named: ImageString.imageValue.next_process_4)
                    self.processSlider.setThumbImage(self.processImageView, for: .normal)
                }
                
                
            }else{
                
                UIView.animate(withDuration: 0.2) {
                    self.processImageView = UIImage(named: ImageString.imageValue.process_4)
                    self.processSlider.setThumbImage(self.processImageView, for: .normal)
                }
                
                
            }
            
        }
        else if (checkTrackingString == "ARRIVED"){
            if (self.processSlider.value >= 0.5) {
                processImageView = UIImage(named: ImageString.imageValue.next_process_5)
                processSlider.setThumbImage(processImageView, for: .normal)
            }else{
               
                self.processImageView = UIImage(named: ImageString.imageValue.process_5)
                self.processSlider.setThumbImage(self.processImageView, for: .normal)
                
            }
            
        }
*/
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: - Methods
extension LiveDetailTaskViewController {
    
    // InitalLoads method
    private func initalLoad(){
        
        initalizeTableView()
        self.hideKeyboardWhenTappedAround()
        setFont()
        setColors()
        customizeAllProperty()
        initalSlideDesign()
        getCurrentLocation()
        setNavigationcontroller()
        processSlider.addTarget(self, action: #selector(handleTouchDown), for: [.touchUpInside, .touchUpOutside, .touchCancel])
    }
    
    
    
    // navigation
    private func setNavigationcontroller(){
        let sidemenuBtn = UIButton(type: .custom)
        sidemenuBtn.setImage(UIImage(named: ImageString.imageValue.menu), for: .normal)
        sidemenuBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        sidemenuBtn.addTarget(self, action: #selector(LiveDetailTaskViewController.onsideMenuTapped), for: .touchUpInside)
        let sidemenuBtnItem = UIBarButtonItem(customView: sidemenuBtn)
        
        let liveTaskBtn = UIButton(type: .custom)
        liveTaskBtn.setTitle(APPLocalize.localizestring.liveTasks.localize(), for: .normal)
        liveTaskBtn.titleLabel?.font = UIFont.semibold(size: 18)
        liveTaskBtn.setTitleColor(UIColor.black, for: .normal)
        liveTaskBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let liveTaskBtnItem = UIBarButtonItem(customView: liveTaskBtn)
        
        self.navigationItem.setLeftBarButtonItems([liveTaskBtnItem], animated: true)
        self.navigationItem.setRightBarButtonItems([sidemenuBtnItem], animated: true)

    }
    // showAmountPaid Alert
    func showAmountPaidAppears(){
        loopCount = 2
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.AmountPopViewViewController)as! AmountPopViewViewController
        vc.Data = Data
        vc.delegate = self
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    // showFeedback Alert
    func showFeedbackViewAppears(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.FeedBackPopViewViewController)as! FeedBackPopViewViewController
        vc.Data = Data
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
   
    
    // get current Location
    private func getCurrentLocation() {
        
        locationManager = CLLocationManager()
       
        // Ask for Authorisation from the User.
        self.locationManager?.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager?.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager?.startUpdatingLocation()
        }
        
        
        
    }
    
    
    //common values setting to data
    private func customizeAllProperty(){
        checkTrackingString = "Order Received"
        trackingView.isHidden = false
        restaurantImageView.layer.cornerRadius = 8
        restaurantImageView.layer.masksToBounds = true
    }
    //register tableview
    private func initalizeTableView(){
        let orderItemnib = UINib(nibName: XIB.Names.itemListTableViewCell, bundle: nil)
        itemTableView.register(orderItemnib, forCellReuseIdentifier: XIB.Names.itemListTableViewCell)
        let addonsnib = UINib(nibName: XIB.Names.ItemWithoutAddOnsTableViewCell, bundle: nil)
        itemTableView.register(addonsnib, forCellReuseIdentifier: XIB.Names.ItemWithoutAddOnsTableViewCell)
        itemTableView.delegate = self
        itemTableView.dataSource = self
    }
  
    
    // Initalize Slider Design
    private func initalSlideDesign(){
        processImageView = UIImage(named: ImageString.imageValue.process_1)
        
        orderStatusLabel.text = APPLocalize.localizestring.startedTowardsRestaurant.localize()
        
        processSlider.setThumbImage(processImageView, for: .normal)
    }
    // update TableView Height
    func updateOrderItemTableHeight(){
        var counts: [String: Int] = [:]
        var itemsArr = [String]()
        for var i in 0..<(Data!.items!.count)
        {
            let Result = Data!.items![i]
            
            let cartaddons = Result.cart_addons?.count
            if cartaddons! > 0 {
                itemsArr.append("withaddonsItems")
            }else{
                itemsArr.append("withoutaddonsItems")
                
            }
            
        }
        
        for item in itemsArr {
            counts[item] = (counts[item] ?? 0) + 1
        }
        
        
        
        var cartaddonCount = 0
        var itemCount = 0
        for (key, value) in counts {
            print("\(key) occurs \(value) time(s)")
            if key == "withoutaddonsItems"{
                itemCount = value
            }else{
                cartaddonCount = value
            }
        }
        
        let itemCountHeight = CGFloat(itemCount * 40)
        let cartaddOns = CGFloat(cartaddonCount * 80)
        self.orderItemHeight.constant = itemCountHeight + cartaddOns
        
        scrollView.contentSize = CGSize(width: self.OverView.frame.size.width, height:  OverView.frame.size.height)
        
        
    
    }
    
    // MARK: - Set Colors
    func setColors() {
        
        orderTimeLabel.textColor = UIColor.descDarkColor
        timeLeftLabel.textColor = UIColor.baseColor
        timeLeftValueLabel.textColor = UIColor.baseColor
        itemTotalLabel.textColor = UIColor.descDarkColor
        itemTotalValueLabel.textColor = UIColor.descDarkColor
        serviceTaxLabel.textColor = UIColor.descDarkColor
        serviceTaxValueLabel.textColor = UIColor.descDarkColor
        deliveryChargesLabel.textColor = UIColor.descDarkColor
        deliveryChargesValueLabel.textColor = UIColor.descDarkColor
        discountLabel.textColor = UIColor.descDarkColor
        discountValueLabel.textColor = UIColor.descDarkColor
        walletDeductionLabel.textColor = UIColor.descDarkColor
        walletDeductionValueLabel.textColor = UIColor.descDarkColor
        orderIdLabel.textColor = UIColor.primary
        orderStatusLabel.textColor = UIColor.descDarkColor
        
        
    }
    func timerSequences() {
        
        timerDic = [
            "TimerStarted": "Yes"
        ]
        
        timerTOCallServer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.checkLiveOrderRequestApi), userInfo: timerDic, repeats: true)
        checkString = "No"
        
        
    }
    // call API for
    @objc func checkLiveOrderRequestApi(){
        self.presenter?.get(api: .liveOrders, data: nil)
    }
    
    // sideMenu Action
    @objc func onsideMenuTapped()
    {
        
        //   MenuOverView.isHidden = false
        
        let actionsheet = UIAlertController(title: APPLocalize.localizestring.disputeTitle.localize(), message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        actionsheet.addAction(UIAlertAction(title: APPLocalize.localizestring.dispute.localize(), style: UIAlertAction.Style.default, handler: { (action) -> Void in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.DisputeViewController)as! DisputeViewController
            vc.Data = self.Data
            vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            self.present(vc, animated: true, completion: nil)
        }))
        
        actionsheet.addAction(UIAlertAction(title: APPLocalize.localizestring.cancel.localize(), style: UIAlertAction.Style.destructive, handler: { (action) -> Void in
            
        }))
        self.present(actionsheet, animated: true, completion: nil)
        
    }
    
    // set Font
    private func setFont(){
        
        totalAmountLabel.font = UIFont.regular(size: 14)
        orderIdLabel.font = UIFont.bold(size: 14)
        orderTimeLabel.font = UIFont.regular(size: 14)
        restaurantNameLabel.font = UIFont.bold(size: 15)
        restaurantAddressLabel.font = UIFont.regular(size: 14)
        totalLabel.font = UIFont.regular(size: 14)
        timeLeftLabel.font = UIFont.bold(size: 14)
        timeLeftValueLabel.font = UIFont.bold(size: 14)
        orderStatusLabel.font = UIFont.bold(size: 11)
        itemTotalLabel.font = UIFont.regular(size: 13)
        itemTotalValueLabel.font = UIFont.regular(size: 13)
        serviceTaxLabel.font = UIFont.regular(size: 13)
        serviceTaxValueLabel.font = UIFont.regular(size: 13)
        deliveryChargesLabel.font = UIFont.regular(size: 13)
        deliveryChargesValueLabel.font = UIFont.regular(size: 13)
        discountLabel.font = UIFont.regular(size: 13)
        discountValueLabel.font = UIFont.regular(size: 13)
        walletDeductionLabel.font = UIFont.regular(size: 13)
        walletDeductionValueLabel.font = UIFont.regular(size: 13)
        
    }
    
    // Set Value for the textFields
    func setData(data: OrdersEntity){
        
        phoneNumberStr = (data.shop?.phone)!
        let serviceTaxStr = "\(data.invoice!.tax!)"
        let deliveryChargesStr = "\(data.invoice!.delivery_charge!)"
        let discountStr = "\(data.invoice!.discount!)"
        let walletDeductionStr = "\(data.invoice!.wallet_amount!)"
        let itemTotalStr = "\(data.invoice!.gross!)"
        let currencyItemTotalStr = APPLocalize.localizestring.Currency.localize() + itemTotalStr
        let currencyServiceTaxStr = APPLocalize.localizestring.Currency.localize() + serviceTaxStr
        let currencyDeliveryChargesStr = APPLocalize.localizestring.Currency.localize() + deliveryChargesStr
        let currencyDiscountStr = APPLocalize.localizestring.Currency.localize() + discountStr
        let currencyWalletDeductionStr = APPLocalize.localizestring.Currency.localize() + walletDeductionStr
        
        itemTotalValueLabel.text = currencyItemTotalStr + ".0"
        serviceTaxValueLabel.text = currencyServiceTaxStr
        deliveryChargesValueLabel.text = currencyDeliveryChargesStr + ".0"
        discountValueLabel.text = currencyDiscountStr
        walletDeductionValueLabel.text = currencyWalletDeductionStr + ".0"
        
        orderTimeLabel.text = data.created_at
        
        Cache.image(forUrl: data.shop?.avatar) { (image) in
            DispatchQueue.main.async {
                self.restaurantImageView.image = image == nil ? #imageLiteral(resourceName: "userPlaceholder") : image
            }
        }
        
        let orderIdStr = "\(data.id!)"
        orderIdLabel.text = "#" + orderIdStr
        
        
        restaurantNameLabel.text = data.shop?.name?.uppercased()
        restaurantAddressLabel.text = data.shop?.address
        
        
        totalLabel.text = APPLocalize.localizestring.total.localize()
        let totalAmtStr: String! = String(describing: data.invoice!.payable!)
        
        totalAmountLabel.text = APPLocalize.localizestring.Currency.localize() + totalAmtStr + ".0"
        
        
        
        itemTableView.reloadData()
        
    }
    
    
    // Order Processing state checking Method
    func processStatus(status: String){
        if status == "ASSIGNED" {
            processImageView = UIImage(named: ImageString.imageValue.process_1)
            orderStatusLabel.text = APPLocalize.localizestring.startedTowardsRestaurant.localize()
            checkTrackingString = status
            processSlider.setThumbImage(processImageView, for: .normal)
            startedToRestaurantView.backgroundColor = UIColor.UpcomingColor
            startedToRestaurantImageView.setImageColor(color: UIColor.white)
        }else if status == "PROCESSING" {
            processImageView = UIImage(named: ImageString.imageValue.process_2)
            orderStatusLabel.text = APPLocalize.localizestring.reachedRestaurent.localize()
            checkTrackingString = status
            processSlider.setThumbImage(processImageView, for: .normal)
            startedToRestaurantView.backgroundColor = UIColor.baseColor
            startedToRestaurantImageView.setImageColor(color: UIColor.white)
            orderPickedUpView.backgroundColor = UIColor.UpcomingColor
            orderPickedUpImageView.setImageColor(color: UIColor.white)
            
        }else if status == "REACHED" {
            processImageView = UIImage(named: ImageString.imageValue.process_3)
            orderStatusLabel.text = APPLocalize.localizestring.orderPickedUp.localize()
            checkTrackingString = status
            processSlider.setThumbImage(processImageView, for: .normal)
            orderPickedUpView.backgroundColor = UIColor.baseColor
            reachedRestaurantView.backgroundColor = UIColor.UpcomingColor
            reachedRestaurantImageView.setImageColor(color: UIColor.white)
            
            
        }else if status == "PICKEDUP" {
            processImageView = UIImage(named: ImageString.imageValue.process_4)
            orderStatusLabel.text = APPLocalize.localizestring.orderDelivered.localize()
            checkTrackingString = status
            processSlider.setThumbImage(processImageView, for: .normal)
            Cache.image(forUrl: Data?.user?.avatar) { (image) in
                DispatchQueue.main.async {
                    self.restaurantImageView.image = image == nil ? #imageLiteral(resourceName: "userPlaceholder") : image
                }
            }
            
            restaurantNameLabel.text = Data?.user?.name
            restaurantAddressLabel.text = Data?.address?.map_address
            destinationLat = (Data?.address?.longitude)!
            destinationLong = (Data?.address?.longitude)!
            self.phoneNumberStr = (Data?.user?.phone)!
            
            reachedRestaurantView.backgroundColor = UIColor.baseColor
            orderDeliveredView.backgroundColor = UIColor.UpcomingColor
            orderDeliveredImageView.setImageColor(color: UIColor.white)
        }else if status == "ARRIVED" {
            self.trackingView.isHidden = false
            self.timeView.isHidden = true
            orderDeliveredView.backgroundColor = UIColor.baseColor
            paymentProcessImageView.setImageColor(color: UIColor.white)
            paymentProcessView.backgroundColor = UIColor.UpcomingColor
            
            if Data?.invoice?.paid == 1 {
                orderProcessing(orderStatus: "COMPLETED")
            }else{
                if loopCount == 1 {
                    if(Data?.safe_delivery == 1)
                    {
                    showAmountPaidAppears()
                }
                    else{
                        orderProcessing(orderStatus: "COMPLETED")
                    }
                }
            }
        }else if status == "COMPLETED"{
            if (timerTOCallServer != nil) {
                
                timerTOCallServer?.invalidate()
                timerTOCallServer = nil
            }
            showFeedbackViewAppears()
            
        }
        self.loader.isHidden = true
        self.loader.isHideInMainThread(true)
        
    }
    // next screen to pop to view controller
    func nextScreenVC() {
        self.navigationController?.popViewController(animated: true)
    }
    // orderProcessing status Function
    func orderProcessing(orderStatus: String) {
       
        orderProcessingStatus = orderStatus
        if orderStatus == "COMPLETED" {
            timerTOCallServer?.invalidate()
            timerTOCallServer = nil
            let balanceStr = balanceAmtStr.replacingOccurrences(of: APPLocalize.localizestring.Currency.localize(), with: "")
            var orderModelEntityRequest = OrderModelEntity()
            orderModelEntityRequest.status = orderStatus
            orderModelEntityRequest.tender_pay = balanceStr
            orderModelEntityRequest.payment_mode = "cash"
            orderModelEntityRequest.payment_status = "success"
            orderModelEntityRequest.total_pay = enterAmtStr
            
            let url = Base.liveOrderparam.rawValue+"/"+"\(Data!.id!)"
            print(url)
            self.presenter!.patch(api: .liveOrderparam, url: url, data: orderModelEntityRequest.toData())
        }else {
            var orderModelEntityRequest = OrderModelEntity()
            orderModelEntityRequest.status = orderStatus
            
            let url = Base.liveOrderparam.rawValue+"/"+"\(Data!.id!)"
            print(url)
            
            self.presenter!.patch(api: .liveOrderparam, url: url, data: orderModelEntityRequest.toData())
        }
        
    }
}
// MARK: - TableView Delegate & DataSoruce
extension LiveDetailTaskViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data?.items?.count ?? 0
    }
    
  

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if Data!.items![indexPath.row].cart_addons!.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.ItemWithoutAddOnsTableViewCell, for: indexPath) as! ItemWithoutAddOnsTableViewCell
            
            let productName = Data?.items?[indexPath.row].product?.name
            let quantityStr = "\(Data!.items![indexPath.row].quantity!)"
            cell.titleLabel.text = productName! + " x " + quantityStr
            let priceStr = "\(Data!.items![indexPath.row].product!.prices!.price!)"
            cell.descriptionLabel.text = priceStr + ".0"
            return cell
            
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.ItemListTableViewCell, for: indexPath) as! ItemListTableViewCell
            
            let productName = Data?.items?[indexPath.row].product?.name
            let quantityStr = "\(Data!.items![indexPath.row].quantity!)"
            cell.titleLabel.text = productName! + " x " + quantityStr
            let priceStr = "\(Data!.items![indexPath.row].product!.prices!.price!)"
            cell.descriptionLabel.text = priceStr + ".0"
            
            var addonsNameArr = [String]()
            addonsNameArr.removeAll()
            
            for var i in 0..<(Data!.items![indexPath.row].cart_addons!.count)
            {
                let Result = Data!.items![indexPath.row].cart_addons![i]
                
                let str = "\(Result.addon_product?.addon?.name! ?? "")"
                
                addonsNameArr.append(str)
                
            }
            
            if Data!.items![indexPath.row].cart_addons!.count == 0 {
                cell.subTitleLabel.isHidden = true
            }else{
                cell.subTitleLabel.isHidden = false
                let addonsstr = addonsNameArr.joined(separator: ", ")
                cell.subTitleLabel.text = addonsstr
            }
            
            
            
            return cell
            
            
        }
    }
    
    
}
// MARK: - Api Protocol Methods
extension LiveDetailTaskViewController: PostViewProtocol {
    func onError(api: Base, message: String, statusCode code: Int) {
        self.loader.isHidden = true
        self.loader.isHideInMainThread(true)
       print(message)
        if api == .liveOrderparam {
        if message == "" {
            
        }else {
            
            }
         showAmountPaidAppears()
        }
    }
    
    func getLiveOrderParam(api: Base, entity: OrderModelEntity) {
        self.loader.isHidden = false
        processStatus(status: (Data?.status)!)

        print(entity)
        if orderProcessingStatus == "COMPLETED" {
            showFeedbackViewAppears()
        }
    }
    
    
    
    
    // get live request
    func getLiveOrderRequest(api: Base, entity: [OrdersEntity]) {
       
        if entity.count == 0 {
            self.loader.isHidden = true
            self.loader.isHideInMainThread(true)
            timerTOCallServer?.invalidate()
            timerTOCallServer = nil
               /*         FCAlertView *alert = [[FCAlertView alloc] init];
            
                        [alert showAlertWithTitle:nil
                        withSubtitle:@"User Cancelled the request"
                        withCustomImage:nil
                        withDoneButtonTitle:@"OK"
                        andButtons:nil];
                        alert.colorScheme = BASECOLOR;
                        alert.doneButtonTitleColor = [UIColor whiteColor];
                        alert.animateAlertOutToBottom = YES;
                        alert.hideSeparatorLineView = NO;
                        alert.animateAlertInFromTop = YES;
                        alert.subtitleFont = [UIFont fontWithName:FONT_REGULAR size:14.0];
            
                        [alert doneActionBlock:^{
                        }];
                        [Utilities showAlert:@"User Cancelled the request"]; */
            
            nextScreenVC()
         
        }else {
            if timerTOCallServer == nil {
                self.timerSequences()
            }
            Data = entity[0]
            setData(data: Data!)
            updateOrderItemTableHeight()
            if Data?.ordertiming?.count != 0 {
                for i in 0..<Data!.ordertiming!.count {
                    
                    let orderObj = Data?.ordertiming?[i]
                    
                    var currentStatus: String? = nil
                    if let status = orderObj?.status {
                        currentStatus = "\(status)"
                    }
                    processStatus(status: currentStatus ?? "")
                }
            }else{
                processStatus(status: Data?.status ?? "")
                
            }
           
        }
     
    }
}
extension LiveDetailTaskViewController: CLLocationManagerDelegate {
    
       // func locationManager(manager: CLLocationManager!, didUpdateLocations locations:  [AnyObject]!)
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation])

        {
            currentLocation = (locations.last as! CLLocation)
        
        if currentLocation != nil {
            
            currentLat = String(format: "%.8f", currentLocation!.coordinate.latitude)
            currentLong = String(format: "%.8f", currentLocation!.coordinate.longitude)
            
            print("The latitude value is - \(String(format: "%.8f", currentLocation!.coordinate.latitude))")
            print("The logitude value is - \(String(format: "%.8f", currentLocation!.coordinate.longitude))")
        }
        
        locationManager?.startUpdatingLocation()
    }
}



extension LiveDetailTaskViewController: AmountPopViewViewControllerDelegate {
    func AmountPaid(balanceAmt: String,enterAmt: String) {
        balanceAmtStr = balanceAmt
        enterAmtStr = enterAmt
        orderProcessing(orderStatus: "COMPLETED")
        timeView.isHidden = true
        trackingView.isHidden = false
        processImageView = UIImage(named: ImageString.imageValue.process_5)
        processSlider.setThumbImage(processImageView, for:.normal)
        checkTrackingString = "COMPLETED"
        orderStatusLabel.text = "COMPLETED"
        orderDeliveredView.backgroundColor = UIColor.baseColor
        paymentProcessView.backgroundColor = UIColor.baseColor
    }
    
    
}
extension LiveDetailTaskViewController: FeedBackPopViewViewControllerDelegate {
    func FeedBackNextScreen() {
//        self.navigationController?.popViewController(animated: true)
        self.present(Common.setDrawerController(), animated: true , completion: nil)


    }
    
    
}
