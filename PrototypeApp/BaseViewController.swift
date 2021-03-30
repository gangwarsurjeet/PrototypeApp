//
//  BaseViewController.swift
//  PrototypeApp
//
//  Created by Surjeet on 30/03/21.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showLoader() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }

    func hideLoader() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
}
