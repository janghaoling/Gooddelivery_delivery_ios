//
//  TermsConditionViewController.swift
//  Project
//
//  Created by CSS on 02/02/19.
//  Copyright © 2019 css. All rights reserved.
//

import UIKit
import WebKit
class TermsConditionViewController: UIViewController,WKNavigationDelegate {

    @IBOutlet var termsWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initalLoads()
    }
    private func initalLoads(){
        setNavigationcontroller()
        callwebView()
    }
    // navigation
    private func setNavigationcontroller(){
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: ImageString.imageValue.backicon), for: .normal)
        backBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        backBtn.addTarget(self, action: #selector(OrderHistoryViewController.onbackAction), for: .touchUpInside)
        let backBtnItem = UIBarButtonItem(customView: backBtn)
        
        let termsBtn = UIButton(type: .custom)
        termsBtn.setTitle(APPLocalize.localizestring.termsconditionNavTitle.localize(), for: .normal)
        termsBtn.titleLabel?.font = UIFont.semibold(size: 18)
        termsBtn.setTitleColor(UIColor.black, for: .normal)
        termsBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let termsBtnItem = UIBarButtonItem(customView: termsBtn)
        
        self.navigationItem.setLeftBarButtonItems([backBtnItem,termsBtnItem], animated: true)
    }
    //back Button Action
    @objc func onbackAction(){
        self.navigationController?.popViewController(animated: true)
    }
    
    private func callwebView(){
        let myURLString = termsUrl
        let url = NSURL(string: myURLString)
        let request = NSURLRequest(url: url! as URL)
        termsWebView.navigationDelegate = self
        termsWebView.load(request as URLRequest)
    }
    private func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        print(error.localizedDescription)
    }
    private func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
    }
    private func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        print("finish to load")
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
