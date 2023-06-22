
//
//  ShiftStatusViewController.swift
//  Project
//
//  Created by CSS on 09/10/18.
//  Copyright © 2018 css. All rights reserved.
//

import UIKit

class ShiftStatusViewController: UIViewController {

    @IBOutlet private var tableViewShift : UITableView!
    @IBOutlet private var buttonShift : UIButton!
    @IBOutlet private var labelShiftMessage : UILabel!
    @IBOutlet private var viewTableViewBackground : UIView!
    private var shiftStatusHeader : ShiftStatusHeader?
    private var viewEndShift : TotalPaymentView?
    private var viewVehicleList : VehicleListView?
    private var shiftFooterView : ShiftStatusTableViewCell?
    private var shiftStatusDatasource : ShiftDetail?
    private var pickerView : PickerView?
    private var vehicleListArray = [VehicleEntity]()

    private var currentBreakId = 0 { // Current Shift Break Id
        didSet {
            self.switchBreak.isOn = !(currentBreakId == 0)
            self.updateSwitchUI()
        }
    }
    
    private var currentShiftId = 0  // Current Shift Id
    
    private var shiftStatus : ShiftStatus = .none {
        didSet {
            self.navigationItem.rightBarButtonItem = shiftStatus == .started ? UIBarButtonItem(customView: self.switchBreak) : nil
            self.buttonShift.setTitle( shiftStatus.shiftString.localize().uppercased(), for: .normal)
            self.buttonShift.isHidden = (shiftStatus == .ended)
        }
    }
    
    
    
   
    private lazy var switchBreak : UISwitch = {
        let switchUI = UISwitch()
        switchUI.onTintColor = .primary
        switchUI.tintColor = .lightGray
       // switchUI.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)

        switchUI.addTarget(self, action: #selector(self.switchBreakAction(sender:)), for: .valueChanged)
        return switchUI
    }()
    
    private lazy var loader : UIView = {
        return createLottieLoader(in: UIApplication.shared.keyWindow ?? self.view)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initalLoads()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        enableKeyboardHandling()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        disableKeyboardHandling()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.layouts()
    }
    
}

// MARK:- UIViewStructure
extension ShiftStatusViewController : UIViewStructure {
    
    func initalLoads() {
        self.initUI()
        self.localize()
        self.design()
        self.shiftStatus = .none
        setnavigation()
        registerTableView()
        settingServiceCall()
        self.loadAPIData()
    }
    
    private func registerTableView(){
        self.tableViewShift.register(UINib(nibName: XIB.Names.ShiftStatusTableViewCell, bundle: nil), forCellReuseIdentifier: XIB.Names.ShiftStatusTableViewCell)
        self.tableViewShift.dataSource = self
        self.tableViewShift.delegate = self
        self.shiftStatusHeader = Bundle.main.loadNibNamed(XIB.Names.ShiftStatusHeader, owner: self, options: [:])?.first as? ShiftStatusHeader
        self.shiftFooterView = Bundle.main.loadNibNamed(XIB.Names.ShiftStatusTableViewCell, owner: self, options: [:])?.first as? ShiftStatusTableViewCell
        self.tableViewShift.separatorStyle = .none
        self.tableViewShift.allowsSelection = false
    }
    
    private func setnavigation(){
        self.navigationItem.title = APPLocalize.localizestring.shiftStatus.localize().uppercased()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: ImageString.imageValue.backicon), style: .plain, target: self, action: #selector(self.buttonBackAction))
        self.buttonShift.addTarget(self, action: #selector(self.buttonShiftAction(sender:)), for: .touchUpInside)
    }
    
    func localize() {
        self.labelShiftMessage.text = APPLocalize.localizestring.turnOnShift.localize()
    }
    
    func design() {
        Common.setFont(to: self.buttonShift, isTitle: true, size: 18, fontType: .extraBold)
        Common.setFont(to: self.labelShiftMessage, size : 16)
    }
    
    func layouts() {
        
    }
    func settingServiceCall() {
        self.presenter?.get(api: .settings, data: nil)
    }
    
}

// MARK:- UIInitialization

extension ShiftStatusViewController {
    
    private func initUI() {
        
    }
}



// MARK:- Methods

extension ShiftStatusViewController {
  
    // Break switch action
    @IBAction private func switchBreakAction(sender : UISwitch) {
        if !sender.isOn {
            if currentBreakId != 0 {
                self.presenter?.delete(api: .breakTime, url: Base.breakTime.rawValue+"/\(currentBreakId)", data: nil)
            }
        } else {
            self.presenter?.post(api: .breakTime, data: nil)
        }
        self.updateSwitchUI()

    }
    
    // Update Switch and Shift Button if user is on Break
    private func updateSwitchUI() {
        
        self.buttonShift.isEnabled = !self.switchBreak.isOn
        self.buttonShift.backgroundColor = self.switchBreak.isOn ? .black : .primary
        self.buttonShift.alpha = self.switchBreak.isOn ? 0.2 : 1
        
    }
    
    // Button Shift Action
    @IBAction private func buttonShiftAction(sender : UIButton) {
       // self.isShiftStarted = !self.isShiftStarted
       // self.present(Common.setDrawerController(), animated: true, completion: nil)
        //self.showEndTripView()
        
        if self.shiftStatus == .none {
                self.showVehicleListView()
        } else {
            self.showEndTripView()
        }
    }
    
    // Button Back Action
    
    @IBAction private func buttonBackAction() {
        if Int.val(val: self.navigationController?.viewControllers.count) > 1 {
            self.popOrDismiss(animation: true)
        }else {
            self.present(Common.setDrawerController(), animated: true , completion: nil)
        }
    }
    
    // MARK:- Show ViewAmountToBePaid
    
    private func showEndTripView() {
        if viewEndShift == nil {
             self.view.addBlurview(on: {
                vibrate(sound: .pop)
             }, tapGesture: UITapGestureRecognizer(target: self, action: #selector(self.removeEndTripView)))
             self.viewEndShift = Bundle.main.loadNibNamed(XIB.Names.TotalPaymentView, owner: self, options: [:])?.first as? TotalPaymentView
             self.view.addSubview(self.viewEndShift!)
             self.viewEndShift?.translatesAutoresizingMaskIntoConstraints = false
             self.viewEndShift?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
             self.viewEndShift?.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
             self.viewEndShift?.heightAnchor.constraint(equalToConstant: self.viewEndShift!.bounds.height).isActive = true
             self.viewEndShift?.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
             self.viewEndShift?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
             UIView.animate(withDuration: 0.2, animations: {
                self.viewEndShift?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
             }) { (_) in
                UIView.animate(withDuration: 0.1, animations: {
                    self.viewEndShift?.transform = .identity
                })
              }
            
            
            if self.shiftStatusDatasource?.end_time != nil {
                self.viewEndShift?.buttonEndShift.isHidden = true
            }else{
                self.viewEndShift?.buttonEndShift.isHidden = false
            }
            self.viewEndShift?.onclickEndShift = { [weak self] in
                self?.removeEndTripView()
                self?.changeShiftStatus()
                if !self!.switchBreak.isOn {
                    userDefaults.shiftStatus = "end"
                }
            }
        }
        self.viewEndShift?.setValue(amount: Formatter.shared.limit(string: "\(self.shiftStatusDatasource?.total_amount_pay ?? 0)", maximumDecimal: currencyDecimalLimit), shiftstatus : shiftStatus)
    }
    
    // MARK:- Show Vehicle List
    
    private func showVehicleListView() {
        if viewVehicleList == nil {
            self.view.addBlurview(on: {
                vibrate(sound: .pop)
            }, tapGesture: UITapGestureRecognizer(target: self, action: #selector(self.removeVehicleListView)))
            self.viewVehicleList = Bundle.main.loadNibNamed(XIB.Names.VehicleList, owner: self, options: [:])?.first as? VehicleListView
            self.view.addSubview(self.viewVehicleList!)
            self.viewVehicleList?.translatesAutoresizingMaskIntoConstraints = false
            self.viewVehicleList?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            self.viewVehicleList?.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            self.viewVehicleList?.heightAnchor.constraint(equalToConstant: self.view.bounds.height*0.7).isActive = true
            self.viewVehicleList?.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
            self.viewVehicleList?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            UIView.animate(withDuration: 0.2, animations: {
                self.viewVehicleList?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            }) { (_) in
                UIView.animate(withDuration: 0.1, animations: {
                    self.viewVehicleList?.transform = .identity
                })
            }
            if self.vehicleListArray.count != 0 {
                self.viewVehicleList?.buttonList.setTitle(APPLocalize.localizestring.selectVehicleNumber.localize() , for: .normal)

            }else{
                self.viewVehicleList?.buttonList.setTitle(APPLocalize.localizestring.novehicleList.localize() , for: .normal)

            }
            self.viewVehicleList?.onclickContinue = { [weak self] vehicleNumber in
                self?.removeVehicleListView()
                self?.changeShiftStatus(with: vehicleNumber)
                
            }
            self.viewVehicleList?.onclickList = { [weak self] completion in
                self?.view.endEditingForce()
                if self?.vehicleListArray.count != 0 {
                self?.showPickerList(on: { [weak self] (selectedIndex) in
                    guard let self = self else {return}
                    
                    completion(self.vehicleListArray.count > selectedIndex ? self.vehicleListArray[selectedIndex].vehicle_no : nil)
                })
                } else {

                    self?.showAlertMessage(message: "No Vehicle List to show")
                }
            }
        }
      //  self.viewVehicleList?.setValue(amount: Formatter.shared.limit(string: "\(self.shiftStatusDatasource?.total_amount_pay ?? 0)", maximumDecimal: currencyDecimalLimit))
    }
    
    // MARK:- Remove ViewAmountTobePaid
    
    @IBAction private func removeEndTripView() {
        self.view.removeBlurView()
        UIView.animate(withDuration: 0.2, animations: {
            self.viewEndShift?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }) { (_) in
            self.viewEndShift?.removeFromSuperview()
            self.viewEndShift = nil
        }
    }
    
    // MARK:- Remove Vehicle List
    
    @IBAction private func removeVehicleListView() {
        self.view.removeBlurView()
        UIView.animate(withDuration: 0.3, animations: {
            self.viewVehicleList?.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            self.viewVehicleList?.alpha = 0 
        }) { (_) in
            self.viewVehicleList?.removeFromSuperview()
            self.viewVehicleList = nil
        }
    }
    
    // MARK:- Show Pickerview
    
    private func showPickerList(on completion : @escaping ((Int)->Void)) {
        if self.pickerView == nil {
            let height : CGFloat = 150
            self.pickerView = Bundle.main.loadNibNamed(XIB.Names.PickerView, owner: self, options: [:])?.first as? PickerView
            self.view.addSubview(self.pickerView!)
            self.pickerView?.translatesAutoresizingMaskIntoConstraints = false
            self.pickerView?.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.99).isActive = true
            self.pickerView?.heightAnchor.constraint(equalToConstant: height).isActive = true
            self.pickerView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
            self.pickerView?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
            self.pickerView?.transform = CGAffineTransform(translationX: 0, y: height)
            UIView.animate(withDuration: 0.2) {
                self.pickerView?.transform = .identity
            }
            self.pickerView?.onClickDone = { [weak self] selectedIndex in
                completion(selectedIndex)
                self?.removePickerView()
            }
            self.pickerView?.onClickCancel = { [weak self] in
                self?.removePickerView()
            }
        }
        self.pickerView?.setValues(data: self.vehicleListArray.map({ $0.vehicle_no ?? .Empty}))
    }
    
    // MARK:- Remove Pickerview
    
    private func removePickerView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.pickerView?.transform = CGAffineTransform(translationX: 0, y: 200)
        }) { (_) in
            self.pickerView?.removeFromSuperview()
            self.pickerView = nil
        }
    }
    
    
    // MARK:- Load Shift Details
    
    private func loadShift(details : [ShiftDetail]) {
        
        self.shiftStatusDatasource = details.first
        self.currentShiftId = Int.val(val: self.shiftStatusDatasource?.id)
        self.currentBreakId = { // If the delivery is on break start time will be available and endtime will be nil
            if let lastObject = self.shiftStatusDatasource?.shiftbreaktimes?.last,
                lastObject.start_time != nil,
                lastObject.end_time == nil {
                return Int.val(val: lastObject.id)
                
            }
            return 0
        }()
        self.shiftStatus = {
            if self.shiftStatusDatasource?.end_time != nil {
                self.showEndTripView()
                return .ended
            } else if self.shiftStatusDatasource?.start_time != nil {
                return .started
            } else {
                return .none
            }
        }()
        let dataObject = Formatter.shared.getDate(from: self.shiftStatusDatasource?.start_time, format: DateFormat.list.yyyy_mm_dd_HH_MM_ss)
        let timeString = Formatter.shared.getString(from: dataObject, format: DateFormat.list.hh_mm_a)
      self.shiftStatusHeader?.set(amount: self.shiftStatusDatasource?.total_amount ?? 0, time: timeString)
        self.tableViewShift.reloadInMainThread()
        self.tableViewShift.tableFooterView = self.shiftStatus == .ended ? self.shiftFooterView : nil
        self.tableViewShift.tableHeaderView = self.shiftStatus != .none ? self.shiftStatusHeader : nil
        self.tableViewShift.backgroundView = self.shiftStatusDatasource != nil ? nil : viewTableViewBackground
        if shiftStatusDatasource != nil {
        self.shiftFooterView?.set(value: self.shiftStatusDatasource!,
                                      orderCount: Int.val(val: self.shiftStatusDatasource?.total_order)-Int.val(val: self.shiftStatusDatasource?.shiftbreaktimes?.reduce(into: 0, { (res, detail) in
                                               res+=Int.val(val: detail.order_count)
                                           })),
                                      breakCount: APPLocalize.localizestring.endShift.localize(),
                                      isShifEnded: true)
        }
        
        
        
    }
    
    // MARK:- Load Api Details
    
    private func loadAPIData() {
        tableViewShift.backgroundView = nil
        self.loader.isHidden = false
        self.presenter?.get(api: .profile, data: nil)
        if User.main.settlementStatus != nil {
            self.presenter?.get(api: .shift, data: nil)
        }
    }
    
    
    // MARK:- Start Shift
    
    private func changeShiftStatus(with vehicleNumber : String? = nil) {
        tableViewShift.backgroundView = nil
        self.loader.isHidden = false
        if self.shiftStatus == .none {
            guard vehicleNumber != nil else {return}
            var request = Profile()
            request.vehicle_no = vehicleNumber
            self.presenter?.post(api: Base.startShift, data: request.toData())
        } else if shiftStatus == .started {
            guard currentShiftId != 0 else {return}
            print(Base.startShift.rawValue+"\(currentShiftId)")
            let url = Base.startShift.rawValue + "/" + String(currentShiftId)
            self.presenter?.delete(api: .startShift, url: url, data: nil)
        }else if shiftStatus == .ended {
            print("shift Ended")
        }
    }
    
    
}

// MARK:- Table View Delegate
extension ShiftStatusViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.shiftStatusDatasource?.shiftbreaktimes ?? []).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return self.getCell(for: indexPath, in: tableView)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    private func getCell(for indexPath : IndexPath, in tableView : UITableView)->UITableViewCell {
        
        if let tableCell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.ShiftStatusTableViewCell, for: indexPath) as? ShiftStatusTableViewCell {
            if Int.val(val: self.shiftStatusDatasource?.shiftbreaktimes?.count) > indexPath.row, let datasource = self.shiftStatusDatasource?.shiftbreaktimes?[indexPath.row] {
                tableCell.set(value: datasource, orderCount: Int.val(val: datasource.order_count), breakCount: "\(APPLocalize.localizestring.breakString.localize()) \(indexPath.row+1)")
            }
            return tableCell
        }
        return UITableViewCell()
    }
    
    
}

// MARK:- PostViewProtocol

extension ShiftStatusViewController : PostViewProtocol {
    
    func onError(api: Base, message: String, statusCode code: Int) {
        self.loader.isHidden = true
        self.loader.isHideInMainThread(true)
        print(api)
        print(message)
        print(code)
        UIApplication.shared.keyWindow?.make(toast: message)
        if api == .breakTime
        {
            if switchBreak.isOn {
               switchBreak.isOn = false
            }else{
                switchBreak.isOn = true

            }
            
        }
    }
    
    func getSettingsData(api: Base, data: SettingsEntity?) {
   
        print("check",data?.ios_api_key ?? "")
        googleMapKey = data?.ios_api_key ?? ""
        appSecretKey = data?.client_secret ?? ""
       
    }
    
    func getProfile(api: Base, entity: Profile?) {
        self.loader.isHidden = true
        self.loader.isHideInMainThread(true)
        if entity != nil {
           
            Common.setProfile(detail: entity!)
            storeInUserDefaults()
            if entity?.status == "unsettle" {
                userDefaults.shiftStatus = "end"
            }
        }
        self.loader.isHideInMainThread(false)
        self.presenter?.get(api: .shift, data: nil)
        
    }
  
    func getShiftStatusArray(api: Base, entity: [ShiftDetail]) {
        self.loader.isHidden = true
        self.loader.isHideInMainThread(true)
        self.loadShift(details: entity)
        print(api)
        print(entity)
        if entity.count == 0 {
            tableViewShift.backgroundView = viewTableViewBackground
            self.presenter?.get(api: .vehicleList, data: nil)

        }else{
            tableViewShift.backgroundView = nil

        }
       
        print(User.main.settlementStatus)
        print(shiftStatus)
        if shiftStatus == .started {
            userDefaults.shiftStatus = "start"
        }else if shiftStatus == .ended {
            userDefaults.shiftStatus = "end"
        }
        tableViewShift.reloadData()
        if api == .startShift {
            self.present(Common.setDrawerController(), animated: true , completion: nil)
        }
        print(entity)
    }
    
    func getVehicleEntityList(api: Base, entity: [VehicleEntity]) {
        self.loader.isHidden = true
        self.loader.isHideInMainThread(true)
        print("-->>",entity.count)
        self.vehicleListArray = entity
        
       
    }
  
}
