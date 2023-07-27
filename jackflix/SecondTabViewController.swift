//
//  SecondTabViewController.swift
//  jackflix
//
//  Created by 박태현 on 2023/07/27.
//

import UIKit

class SecondTabViewController: UIViewController {

    @IBOutlet var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let count = UserDefaults.standard.integer(forKey: Constants.UserDefaults.save.key)
        resultLabel.text = "\(count)"
    }
}
