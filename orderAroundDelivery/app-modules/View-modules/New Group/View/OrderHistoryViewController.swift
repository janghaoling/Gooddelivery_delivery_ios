//
//  OrderHistoryViewController.swift
//  Project
//
//  Created by CSS on 24/01/19.
//  Copyright © 2019 css. All rights reserved.
//

import UIKit

class OrderHistoryViewController: UIViewController,CustomPickerViewControllerDelegate {
    // A variable to tableView
    @IBOutlet weak var orderHistoryTableView: UITableView!
    @IBOutlet weak var showDateWiseOrdersView: UIView!

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet var errorView: UIView!
    @IBOutlet weak var orderHistoryView: UIView!
    @IBOutlet weak var showDateLabel: UILabel!
    var presentor:ViewToPresenterProtocol?
    var OrderHistoryArrayList:Array<OrdersEntity> = Array()
    private lazy var loader : UIView = {
        return createLottieLoader(in: UIApplication.shared.keyWindow ?? self.view)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initialSetup()
    }

    @IBAction func onClickDateWiseAction(_ sender: Any) {
        let sideTransitioningDelegate = BottomUpTransitionDelegate()

        let vc = self.storyboard?.instantiateViewController(withIdentifier: Storyboard.Ids.CustomPickerViewController)as! CustomPickerViewController

        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = sideTransitioningDelegate
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    

    /*
   Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: - Methods
extension OrderHistoryViewController {
    // MARK: - Initial Setup
    private func initialSetup() {
        commonValues()
        setNavigationcontroller()
        registerTableView()
        callOrderHistoryApiMethod()
    }
    // navigation
    private func setNavigationcontroller(){
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: ImageString.imageValue.backicon), for: .normal)
        backBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        backBtn.addTarget(self, action: #selector(OrderHistoryViewController.onbackAction), for: .touchUpInside)
        let backBtnItem = UIBarButtonItem(customView: backBtn)
        
        let orderHistoryBtn = UIButton(type: .custom)
        orderHistoryBtn.setTitle(APPLocalize.localizestring.orderHistoryNavTitle.localize(), for: .normal)
        orderHistoryBtn.titleLabel?.font = UIFont.semibold(size: 18)
        orderHistoryBtn.setTitleColor(UIColor.black, for: .normal)
        orderHistoryBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let orderHistoryBtnItem = UIBarButtonItem(customView: orderHistoryBtn)
        
        self.navigationItem.setLeftBarButtonItems([backBtnItem,orderHistoryBtnItem], animated: true)
    }
    //back Button Action
    @objc func onbackAction(){
        self.navigationController?.popViewController(animated: true)
    }
    // Call API
    private func callOrderHistoryApiMethod(){
        self.loader.isHidden = false
        orderHistoryTableView.backgroundView = nil

        presentor = OrderHistoryPresenter(view: self)
        self.presentor?.startFetchingOrderHistory(type: "today")
    }
    // Common Values
    private func commonValues(){
        showDateLabel.font = UIFont.bold(size: 15)
        showDateLabel.text = "Today"
    }
    // register TableView
    private func registerTableView(){
        let nib = UINib(nibName: XIB.Names.orderHistoryTableViewCell, bundle: nil)
        orderHistoryTableView.register(nib, forCellReuseIdentifier: XIB.Names.orderHistoryTableViewCell)
        orderHistoryTableView.delegate = self
        orderHistoryTableView.dataSource = self
        

    }
    // set DateWise Values
    func setValueShowDateLabel(DateLabelValue: String){
        self.loader.isHidden = false
        var typeStr = ""
        
        if DateLabelValue == "TODAY" {
            showDateLabel.text = "Today"
            typeStr = "today"
        }else if DateLabelValue == "THIS MONTH" {
            showDateLabel.text = "This Month"
            typeStr = "monthly"
            
        }else if DateLabelValue == "THIS WEEK" {
            showDateLabel.text = "This Week"
            typeStr = "weekly"
            
        }
        orderHistoryTableView.backgroundView = nil

        self.presentor?.startFetchingOrderHistory(type: typeStr)
    }
    
}
// MARK: - TableView DataSource & Delegate
extension OrderHistoryViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OrderHistoryArrayList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orderDetailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Storyboard.Ids.OrderDetailViewController) as! OrderDetailViewController
        orderDetailVC.Data = self.OrderHistoryArrayList[indexPath.row]
        self.navigationController?.pushViewController(orderDetailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.orderHistoryTableViewCell, for: indexPath) as! OrderHistoryTableViewCell
        cell.setupData(data: self.OrderHistoryArrayList[indexPath.row])

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
}

// MARK: - OrderHistory Presenter
extension OrderHistoryViewController: PresenterToViewProtocol{
    func showOrderHistory(orderHistoryArray: Array<OrdersEntity>) {
        self.loader.isHidden = true
        self.loader.isHideInMainThread(true)

        if orderHistoryArray.count == 0 {
            self.errorLabel.text = APPLocalize.localizestring.noResultFound.localize()
            orderHistoryTableView.backgroundView = errorView
        }else{
            orderHistoryTableView.backgroundView = nil
        }
//        print(orderHistoryArray)
        self.OrderHistoryArrayList = orderHistoryArray
        print(self.OrderHistoryArrayList.count)
        self.orderHistoryTableView.reloadData()
        
    }
    
    func showError() {
        self.loader.isHidden = true
        self.loader.isHideInMainThread(true)
       
        
    }
}


