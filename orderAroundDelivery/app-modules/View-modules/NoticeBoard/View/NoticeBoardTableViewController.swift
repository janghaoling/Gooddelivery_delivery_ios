//
//  NoticeBoardTableViewController.swift
//  Project
//
//  Created by CSS on 30/10/18.
//  Copyright © 2018 css. All rights reserved.
//

import UIKit

class NoticeBoardTableViewController: UITableViewController {
    
    @IBOutlet var errorView: UIView!
    @IBOutlet weak var errorImage: UIImageView!
    @IBOutlet weak var errorLabel: UILabel!
    private var datasource = [NoticeBoardEntity]()
    private lazy var loader : UIView = {
        return createLottieLoader(in: UIApplication.shared.keyWindow ?? self.view)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initalLoads()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.layouts()
    }

}

extension NoticeBoardTableViewController : UIViewStructure {
    
    func initalLoads() {
        self.localize()
        self.design()
        self.hideKeyboardWhenTappedAround()
       registerTableview()
        callApiMethod()
        setNavigation()
    }
    
    private func setNavigation(){
        self.navigationItem.title = APPLocalize.localizestring.noticeBoard.localize()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: ImageString.imageValue.backicon), style: .done, target: self, action: #selector(self.backButtonClick))
    }
    private func registerTableview(){
        self.tableView.register(UINib(nibName: XIB.Names.NoticeBoardTableViewCell, bundle: nil), forCellReuseIdentifier: XIB.Names.NoticeBoardTableViewCell)
        self.tableView.separatorStyle = .none
    }
    private func callApiMethod(){
        self.loader.isHidden = false
        self.presenter?.get(api: .noticeBoard, data: nil)
    }
    
    func localize() {
        
    }
    
    func design() {
        
    }
    
    func layouts() {
        
    }
    
    private func reload() {
        self.loader.isHideInMainThread(true)
        self.tableView.reloadInMainThread()

    }
    
    // MARK:- Empty View
    
    private func checkEmptyView() {
        
        self.errorLabel.text = APPLocalize.localizestring.noNotices.localize()
        self.tableView.backgroundView = errorView
        
//            = {
//            
//            if self.datasource.count == 0 {
//                return Common.getLabel(with: Constants.string.noNotices.localize())
//            } else {
//                return nil
//            }
//        }()
    }
    
}



// Tableview methods
extension NoticeBoardTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return getCell(for: indexPath, in: tableView)
    }
    
    private func getCell(for indexpath : IndexPath, in tableView : UITableView) -> UITableViewCell {
        
        if let tableCell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.NoticeBoardTableViewCell, for: indexpath) as? NoticeBoardTableViewCell {
            tableCell.selectionStyle = .none
            if self.datasource.count > indexpath.row {
                tableCell.set(value: self.datasource[indexpath.row])
            }
            return tableCell
        }
        
       return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


extension NoticeBoardTableViewController : PostViewProtocol {
    
    func onError(api: Base, message: String, statusCode code: Int) {
        self.loader.isHideInMainThread(true)
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.make(toast: message)
        }
    }
    
    func getNoticeEntityList(api: Base, entity: [NoticeBoardEntity]) {
        self.loader.isHideInMainThread(true)
        self.datasource = entity
        if entity.count == 0 {
            self.checkEmptyView()
        }else{
            self.reload()

        }
    }
    
}
