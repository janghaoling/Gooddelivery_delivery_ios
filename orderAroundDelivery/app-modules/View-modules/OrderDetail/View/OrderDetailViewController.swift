//
//  OrderDetailViewController.swift
//  Project
//
//  Created by CSS on 25/01/19.
//  Copyright © 2019 css. All rights reserved.
//

import UIKit

class OrderDetailViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backImage: UIImageView!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var paymentView: UIView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var LineImageView: UIImageView!
    @IBOutlet weak var verifyImage: UIImageView!
    @IBOutlet weak var orderStatusHeaderLabel: UILabel!
    @IBOutlet var orderIdHeaderLabel: UILabel!
    @IBOutlet weak var btnBackButton: UIButton!
    @IBOutlet weak var paymenttypeLabel: UILabel!
    @IBOutlet weak var paymentModeLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var orderItemTableView: UITableView!
    @IBOutlet weak var orderTimeLabel: UILabel!
    @IBOutlet weak var orderIdLabel: UILabel!
    @IBOutlet weak var deliveryStatusLabel: UILabel!
    @IBOutlet weak var restrauntAddressLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var homeAddressLabel: UILabel!
    @IBOutlet weak var restrauntNameLabel: UILabel!
    @IBOutlet weak var homeImageView: UIImageView!
    @IBOutlet weak var verticalImageView: UIImageView!
    @IBOutlet weak var pinImageView: UIImageView!
    @IBOutlet weak var OverView: UIView!
    @IBOutlet weak var itemTotalLabel: UILabel!
    
    @IBOutlet weak var returnedValueLabel: UILabel!
    @IBOutlet weak var returnedLabel: UILabel!
    @IBOutlet weak var deliveryChargesValueLabel: UILabel!
    @IBOutlet weak var deliveryChargesLabel: UILabel!
    @IBOutlet weak var billAmountValueLabel: UILabel!
    
    @IBOutlet weak var billPaidValueLabel: UILabel!
    @IBOutlet weak var billPaidLabel: UILabel!
    @IBOutlet weak var billAmountLabel: UILabel!
    @IBOutlet weak var noOfItemLabel: UILabel!
    @IBOutlet weak var noOfItemValueLabel: UILabel!

    @IBOutlet weak var walletDeductionLabel: UILabel!
    @IBOutlet weak var walletDeductionValueLabel: UILabel!
    @IBOutlet weak var discountValueLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var serviceTaxValueLabel: UILabel!
    @IBOutlet weak var serviceTaxLabel: UILabel!
    @IBOutlet weak var itemTotalValueLabel: UILabel!
    
    //Height Contraints For TableView
    @IBOutlet weak var orderItemHeight: NSLayoutConstraint!
  
    var Data: OrdersEntity?

// MARK: - View Life cycle
    
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initalLoad()
    }
    
    
    // viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
     //viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false

    }
    
    // MARK: -  Button Action
    
    // back button Action
    @IBAction func backbtnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
extension OrderDetailViewController {
    
    // InitalLoads method
    func initalLoad(){
        setData(data: Data!)
        setFont()
        setColors()
        updateOrderItemTableHeight()
        registerTableview()
        
        
    }
    // Register TableView
    private func registerTableview(){
        let orderItemnib = UINib(nibName: XIB.Names.itemListTableViewCell, bundle: nil)
        orderItemTableView.register(orderItemnib, forCellReuseIdentifier: XIB.Names.itemListTableViewCell)
        let addonsnib = UINib(nibName: XIB.Names.ItemWithoutAddOnsTableViewCell, bundle: nil)
        orderItemTableView.register(addonsnib, forCellReuseIdentifier: XIB.Names.ItemWithoutAddOnsTableViewCell)
        orderItemTableView.delegate = self
        orderItemTableView.dataSource = self
    }
    
    // set Font
    private func setFont(){
        paymenttypeLabel.font = UIFont.regular(size: 14)
        paymentModeLabel.font = UIFont.regular(size: 14)
        totalAmountLabel.font = UIFont.regular(size: 14)
        totalLabel.font = UIFont.regular(size: 14)
        orderIdLabel.font = UIFont.bold(size: 14)
        orderTimeLabel.font = UIFont.regular(size: 14)
        deliveryStatusLabel.font = UIFont.regular(size: 15)
        restrauntNameLabel.font = UIFont.bold(size: 14)
        restrauntAddressLabel.font = UIFont.regular(size: 14)
        homeLabel.font = UIFont.bold(size: 14)
        homeAddressLabel.font = UIFont.regular(size: 14)
        orderIdHeaderLabel.font = UIFont.bold(size: 16)
        orderStatusHeaderLabel.font = UIFont.regular(size: 12)
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
        noOfItemLabel.font = UIFont.regular(size: 13)
        noOfItemValueLabel.font = UIFont.regular(size: 13)
        billPaidLabel.font = UIFont.regular(size: 13)
        billAmountLabel.font = UIFont.regular(size: 13)
        billPaidValueLabel.font = UIFont.regular(size: 13)
        billAmountValueLabel.font = UIFont.regular(size: 13)
        returnedLabel.font = UIFont.regular(size: 13)
        returnedValueLabel.font = UIFont.regular(size: 13)
    }
    
    //  update TableView Height
    private func updateOrderItemTableHeight(){
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
    

    // Set Value for the textFields
    func setData(data: OrdersEntity){
        
        let itemCountStr = "\(data.items!.count)"
        let billAmountStr = "\(data.invoice!.net!)"
        let billPaidStr = "\(data.invoice!.total_pay!)"
        let returnAmountStr = "\(data.invoice!.tender_pay!)"
        
        let currencyBillAmtStr = APPLocalize.localizestring.Currency.localize() + billAmountStr
        let currencyBillPaidStr = APPLocalize.localizestring.Currency.localize() + billPaidStr
        let currencyReturnAmountStr = APPLocalize.localizestring.Currency.localize() + returnAmountStr
        
        noOfItemValueLabel.text = itemCountStr
        billAmountValueLabel.text = currencyBillAmtStr + ".0"
        billPaidValueLabel.text = currencyBillPaidStr + ".0"
        returnedValueLabel.text = currencyReturnAmountStr + ".0"
        
        let itemTotalStr = "\(data.invoice!.gross!)"
        let serviceTaxStr = "\(data.invoice!.tax!)"
        let deliveryChargesStr = "\(data.invoice!.delivery_charge!)"
        let discountStr = "\(data.invoice!.discount!)"
        let walletDeductionStr = "\(data.invoice!.wallet_amount!)"
        
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
        homeLabel.text = APPLocalize.localizestring.home.localize()
        
        let orderIdStr = "\(data.id!)"
        
        orderIdHeaderLabel.text = "ORDER #" + orderIdStr
        orderIdLabel.text = "#" + orderIdStr
        
        restrauntNameLabel.text = data.shop?.name?.uppercased()
        restrauntAddressLabel.text = data.shop?.address
        homeAddressLabel.text = data.address?.map_address
        let orderStr = data.status
        orderStatusHeaderLabel.text = orderStr! + " | " + itemCountStr + "Item ,$" + billAmountStr
        
        if data.status == "COMPLETED" {
            deliveryStatusLabel.text = APPLocalize.localizestring.orderDeliveredSucess.localize()
            verifyImage.image = UIImage(named: ImageString.imageValue.checked)
        }else{
            deliveryStatusLabel.text = APPLocalize.localizestring.orderCancelled.localize()
            verifyImage.image = UIImage(named: ImageString.imageValue.ordercancelled)
            
        }
        
        totalLabel.text = APPLocalize.localizestring.total.localize()
        let totalAmtStr = "\(data.invoice!.payable!)"
        
        totalAmountLabel.text = APPLocalize.localizestring.Currency.localize() + totalAmtStr + ".0"
        
        paymentModeLabel.text = APPLocalize.localizestring.paymentMode.localize()
        if data.invoice?.payment_mode == "stripe" || data.invoice?.payment_mode == "braintree" {
            paymenttypeLabel.text = APPLocalize.localizestring.wallet.localize()
        }else if data.invoice?.payment_mode == "cash" {
            paymenttypeLabel.text = APPLocalize.localizestring.cash.localize()
        }
        
        orderItemTableView.reloadData()
        
    }
    
    // Set Colors
    private func setColors() {
        paymenttypeLabel.textColor = UIColor.primary
        orderIdHeaderLabel.textColor = UIColor.baseColor
        orderTimeLabel.textColor = UIColor.descDarkColor
        deliveryStatusLabel.textColor = UIColor.orderStatusSuccessColor
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
        noOfItemLabel.textColor = UIColor.descDarkColor
        noOfItemValueLabel.textColor = UIColor.descDarkColor
        billPaidLabel.textColor = UIColor.descDarkColor
        billAmountLabel.textColor = UIColor.descDarkColor
        billPaidValueLabel.textColor = UIColor.descDarkColor
        billAmountValueLabel.textColor = UIColor.descDarkColor
        returnedLabel.textColor = UIColor.primary
        returnedValueLabel.textColor = UIColor.primary
        orderIdLabel.textColor = UIColor.primary
    }

    
}
// MARK: - TableView Delegate & DataSoruce
extension OrderDetailViewController: UITableViewDelegate,UITableViewDataSource {
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
