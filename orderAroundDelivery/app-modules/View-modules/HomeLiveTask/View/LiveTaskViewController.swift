    //
    //  HomeViewController.swift
    //  User
    //
    //  Created by CSS on 02/05/18.
    //  Copyright © 2018 Appoets. All rights reserved.
    //
    
    import UIKit
    import Foundation
    
    class LiveTaskViewController: UIViewController {
        
        @IBOutlet weak var loaderIndicator: UIActivityIndicatorView!
        @IBOutlet private weak var viewWating : UIView!
        @IBOutlet private weak var labelWaiting : UILabel!
        @IBOutlet private weak var tableviewTask : UITableView!
        
        private var LiveOrderData = [OrdersEntity]()
        private var CompletedOrderData = [OrdersEntity]()
        var statusStr = ""
        var orderIdStr = ""
        var responseTimeValidateStr = ""
        var responseTimeStr = ""
        var secondsLeft = 0
        var timer: Timer?
        var timerTOCallServer: Timer?
        var devRange = 0
        
        var Livedata: OrdersEntity?
        
        // MARK:- View Life Cycle
        
        // viewDidLoad
        override func viewDidLoad() {
            super.viewDidLoad()
            self.initialLoads()
            NotificationCenter.default.addObserver(self, selector: #selector(self.inValidateTimer(_:)), name: NSNotification.Name(rawValue: "InValidateTimer"), object: nil)

        }
        
        @objc func checkLiveOrderRequestApi(){
            self.presenter?.get(api: .liveOrders, data: nil)
        }
        // ViewWillAppear
        override func viewWillAppear(_ animated: Bool) {
            self.presenter?.get(api: .orderHistory, data: nil)
            self.presenter?.get(api: .liveOrders, data: nil)
        }
        // viewWillDisappear
        override func viewWillDisappear(_ animated: Bool) {
            timerTOCallServer?.invalidate()
        }
        @objc func inValidateTimer(_ notification: NSNotification) {
            timerTOCallServer?.invalidate()

        }
        
    }
 
    // MARK:- Methods
    extension LiveTaskViewController {
        
        private func initialLoads() {
            loaderIndicator.startAnimating()
            loaderIndicator.isHidden = false
            timerTOCallServer =  Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.checkLiveOrderRequestApi), userInfo: nil, repeats: true)
            self.tableviewTask.delegate = self
            self.tableviewTask.dataSource = self
            responseTimeValidateStr = "0"
            self.localize()
            self.setFont()
            self.navigationItem.title = APPLocalize.localizestring.liveTasks.localize().uppercased()
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu_icon"), style: .done, target: self, action: #selector(self.sideMenuAction))
            self.navigationController?.isNavigationBarHidden = false
            self.tableviewTask.register(UINib(nibName: XIB.Names.LiveStatusTableViewCell, bundle: nil), forCellReuseIdentifier: XIB.Names.LiveStatusTableViewCell)
             self.tableviewTask.register(UINib(nibName: "LiveStatusWithoutAcceptTableViewCell", bundle: nil), forCellReuseIdentifier: "LiveStatusWithoutAcceptTableViewCell")
            self.tableviewTask.separatorStyle = .none
            loaderIndicator.color = UIColor.primary
        }
        
        // Localizing
        private func localize() {
         //   self.labelWaiting.text = Constants.string.waitingForTheNewTask.localize().uppercased()
        }
        
        // Setting Font
        private func setFont() {
            Common.setFont(to: self.labelWaiting, size : 18, fontType : .bold)
        }
        
        // MARK:- SideMenu Button Action
        @IBAction private func sideMenuAction(){
            self.drawerController?.openSide(.left)
         }
        
        @objc func updateCounter(_ theTimer: Timer?) {
            secondsLeft = secondsLeft - 1
            
            responseTimeStr = "\(secondsLeft)"
            
            if secondsLeft >= 0 {
                tableviewTask.reloadData()
            } else {
                secondsLeft = 0
                responseTimeValidateStr = "0"
                statusStr = ""
                timer?.invalidate()
               // checkOrderRequest()
              //  getLivetaskArr = [AnyHashable]()
                tableviewTask.reloadData()
            }
        }
        
        func countdownTimer() {
            if timer?.isValid ?? false {
            }
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateCounter(_:)), userInfo: nil, repeats: true)
        }
       
        
    }
    
    // MARK:- TableView
    
    extension LiveTaskViewController : UITableViewDelegate, UITableViewDataSource {
        
        func numberOfSections(in tableView: UITableView) -> Int {
            if (CompletedOrderData.count == 0) {
                
                return 1
                
            }else{
                
                return 2
                
                
            }
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell: UITableViewCell = UITableViewCell()

            if indexPath.section == 0 {
                if statusStr == "SEARCHING" {
                    let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.LiveStatusTableViewCell, for: indexPath) as! LiveStatusTableViewCell
                    cell.delegate = self
                    
                    if self.LiveOrderData.count == 0 {
                        cell.liveRequestView.isHidden = true
                        
                    }else{
                        cell.setLiveData(data: self.LiveOrderData[indexPath.row])
                    }
                    cell.commonFont()
                    return cell
                }else{
                    if LiveOrderData.count == 0 {
                        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.LiveStatusTableViewCell, for: indexPath) as! LiveStatusTableViewCell
                        cell.waitingView.isHidden = false
                        cell.waitingLabel.text = APPLocalize.localizestring.waitingNewTask.localize()
                        cell.liveRequestView.isHidden = true
                        return cell
                    }
                   
                    else if LiveOrderData.count != 0 {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "LiveStatusWithoutAcceptTableViewCell", for: indexPath) as! LiveStatusWithoutAcceptTableViewCell
                       
                     
                        cell.SetLiveData(data: self.LiveOrderData[indexPath.row])
                        return cell
                    }
                    else if CompletedOrderData.count != 0 {
                        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.LiveStatusTableViewCell, for: indexPath) as! LiveStatusTableViewCell
                        cell.setValueLiveOrderData(values: self.CompletedOrderData[indexPath.row])
                        return cell
                    }
                    
                }
                
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "LiveStatusWithoutAcceptTableViewCell", for: indexPath) as! LiveStatusWithoutAcceptTableViewCell
                
                    cell.SetCompletedData(data: self.CompletedOrderData[indexPath.row])


                
                    return cell
                }
            return cell
            
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           var count = 0
            if section == 0 {
                count = 1
            }
            else if section == 1 {
                count = CompletedOrderData.count
            }
            print(count)

            return count
        }
        
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            
            if section == 0 {
                return APPLocalize.localizestring.newTask.localize()
            }
            else if section == 1 {
                return APPLocalize.localizestring.completedTask.localize()
            }
            
            return "Hello"
        }
           func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            var height = 0
            if indexPath.section == 0 {
                if statusStr == "SEARCHING" {
                    height = 225
                }else{
                    if LiveOrderData.count == 0 {
                        height = 225
                    }else{
                        height = 175
                    }
                }
            }else {
                height = 175
            }
         
            return CGFloat(height)
        }
        
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.white
            
            let headerLabel = UILabel(frame: CGRect(x: 20, y: 0, width:
                tableView.bounds.size.width, height: tableView.bounds.size.height))
            headerLabel.font = UIFont.bold(size: 18)
            headerLabel.textColor = UIColor.black
            headerLabel.text = self.tableView(self.tableviewTask, titleForHeaderInSection: section)
            headerLabel.sizeToFit()
            headerView.addSubview(headerLabel)
            
            return headerView
        }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return CGFloat(30)
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if indexPath.section == 0 {
                
                if (LiveOrderData.count != 0) {
                    if statusStr == "SEARCHING" {
                        
                        //                UIAlertController *actionSheet =
                        //
                        //                [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
                        //
                        //                [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                        //
                        //                    // Cancel button tappped.
                        //                    [self dismissViewControllerAnimated:YES completion:^{
                        //
                        //                    }];
                        //                }]];
                        //
                        //                [actionSheet addAction:[UIAlertAction actionWithTitle:@"Accept" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        //                    [self acceptRejectTask :@"ACCEPT"];
                        //                }]];
                        //
                        //                [actionSheet addAction:[UIAlertAction actionWithTitle:@"Reject" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        //                    [self acceptRejectTask :@"REJECT"];
                        //                }]];
                        //                // Present action sheet.
                        //                [self presentViewController:actionSheet animated:YES completion:nil];
                        
                    }
                    else{

                        let orderDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LiveDetailTaskViewController") as! LiveDetailTaskViewController
                        orderDetailVC.Data = self.LiveOrderData[indexPath.row]
                        self.navigationController?.pushViewController(orderDetailVC, animated: true)
                        timerTOCallServer?.invalidate()
                    }
                    
                }
                
            }else{
                
                let orderDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OrderDetailViewController") as! OrderDetailViewController
                orderDetailVC.Data = self.CompletedOrderData[indexPath.row]
                self.navigationController?.pushViewController(orderDetailVC, animated: true)
            }
        }
        
        
    }
    
    
    // MARK:- PostViewProtocol
    
    extension LiveTaskViewController : PostViewProtocol {
        
        func onError(api: Base, message: String, statusCode code: Int) {
            loaderIndicator.stopAnimating()
            loaderIndicator.isHidden = true

            DispatchQueue.main.async {
                showAlert(message: message, okHandler: nil, fromView: self)
            }
        }
        
        func getAcceptReject(api: Base, entity: AcceptRejectModel?) {
            
        }
        
    // get live request
        func getLiveOrderRequest(api: Base, entity: [OrdersEntity]) {
            
            
            if (entity.count == 0) {
                statusStr = ""
                LiveOrderData = entity

            }
            else
            {
                
                statusStr = entity[0].status ?? ""
                if let object = entity[0].id {
                    self.orderIdStr = "\(object)"
                }
                if (statusStr == "SEARCHING") {
                    
                    if (responseTimeValidateStr == "0") {
                        responseTimeValidateStr = "1"
                        if let object = entity[0].response_time {
                            responseTimeStr = "\(object)"
                        }
                        secondsLeft = Int(responseTimeStr) ?? 0
                        
                        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateCounter(_:)), userInfo: nil, repeats: true)
                    }
                }
                self.viewWating.isHidden = true
                self.tableviewTask.isHidden = false
                Livedata = entity[0]
                LiveOrderData = entity

                print("Live onProcess response",entity)
                tableviewTask.reloadInMainThread()
            }
        }
        
    // get order history
        
        func getOrderHistory(api: Base, entity: [OrdersEntity]) {
            loaderIndicator.stopAnimating()
            loaderIndicator.isHidden = true
            if (entity.count != 0) {
                self.viewWating.isHidden = true
                self.tableviewTask.isHidden = false
                for i in 0..<entity.count {
                    Livedata = entity[i]

                }
                CompletedOrderData = entity

            }
            tableviewTask.reloadInMainThread()
        }
    }
    
    
    extension LiveTaskViewController: LiveStatusTableViewCellDelegate {
        func onCallAcceptReject(requestStatus: String) {
                var acceptRejectRequest = AcceptRejectModel()
                acceptRejectRequest.status = "PROCESSING"
                acceptRejectRequest.request_status = requestStatus
                acceptRejectRequest.order_id = orderIdStr
                self.presenter?.post(api: .AcceptReject, data: acceptRejectRequest.toData())
        }
        
        
        
    }
    
