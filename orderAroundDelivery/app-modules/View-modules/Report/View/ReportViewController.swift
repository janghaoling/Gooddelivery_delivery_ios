//
//  ReportViewController.swift
//  Project
//
//  Created by CSS on 02/02/19.
//  Copyright © 2019 css. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController {

    @IBOutlet weak var reportTableView: UITableView!
    
    var ReportArr = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ReportArr = ["Item delayed from restaurant","Item delayed on packaging","Item updation late","Others"]
        let reportnib = UINib(nibName: XIB.Names.ReportTableViewCell, bundle: nil)
        reportTableView.register(reportnib, forCellReuseIdentifier: XIB.Names.ReportTableViewCell)
        reportTableView.delegate = self
        reportTableView.dataSource = self
        reportTableView.reloadData()
        setNavigationController()
    }
    
    func setNavigationController(){
        
        let backBtn = UIButton(type: .custom)

        backBtn.setImage(UIImage(named: ImageString.imageValue.backicon), for: .normal)
        backBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        backBtn.addTarget(self, action: #selector(ReportViewController.onClickBackAction), for: .touchUpInside)
        let backBtnItem = UIBarButtonItem(customView: backBtn)
        
        
        
        let reportBtn = UIButton(type: .custom)
        reportBtn.setTitle("REPORT", for: .normal)
        reportBtn.titleLabel?.font = UIFont.semibold(size: 18)
        reportBtn.setTitleColor(UIColor.black, for: .normal)
        reportBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let reportItem = UIBarButtonItem(customView: reportBtn)
        
        self.navigationItem.setLeftBarButtonItems([backBtnItem,reportItem], animated: true)
        
    }
    
    @objc func onClickBackAction()
    {
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

extension ReportViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ReportArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.ReportTableViewCell, for: indexPath) as! ReportTableViewCell
        
        cell.titleLabel.text = self.ReportArr[indexPath.row]

            return cell
    }
    
    
}
