//
//  ViewController.swift
//  jackflix
//
//  Created by 박태현 on 2023/07/18.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet var newButton: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

        var config = UIButton.Configuration.filled() // apple system button
        config.title = "SeSAC 영등포캠퍼스"
        config.subtitle = "로그인 없이 둘러보기"
        config.image = .init(systemName: "star")
        config.cornerStyle = .capsule
        config.titlePadding = 10.0
        config.imagePadding = 10.0

        config.baseForegroundColor = .black
        config.baseBackgroundColor = .green
        config.imagePlacement = .trailing
        config.titleAlignment = .trailing

        newButton.configuration = config
    }

    // Any
    @IBAction func keyboardDismiss(_ sender: Any) {
        view.endEditing(true)
    }

}
