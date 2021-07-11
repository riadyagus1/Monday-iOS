//
//  SupportRestoViewController.swift
//  Monday
//
//  Created by Agus Riady on 11/07/21.
//

import UIKit

class SupportRestoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    //MARK: Back Button
    @IBAction func backBtn(_ sender: UIButton) {
        if let navController = self.navigationController {
          navController.popViewController(animated: true)
        }
        self.dismiss(animated: true, completion: nil)
    }
    // Back Button (End)

}
