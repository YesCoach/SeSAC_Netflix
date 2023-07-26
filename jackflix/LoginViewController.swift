//
//  ViewController.swift
//  jackflix
//
//  Created by 박태현 on 2023/07/18.
//

import UIKit

final class LoginViewController: UIViewController {

    @IBOutlet var enterWithoutLoginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    // Any
    @IBAction func keyboardDismiss(_ sender: Any) {
        view.endEditing(true)
    }
}

private extension LoginViewController {
    func configureUI() {
        var config = UIButton.Configuration.filled() // apple system button
        config.title = "SeSAC 영등포캠퍼스"
        config.subtitle = "로그인 없이 둘러보기"
        config.image = .init(systemName: "house")
        config.cornerStyle = .capsule
        config.titlePadding = 5.0
        config.imagePadding = 5.0

        config.baseForegroundColor = .white
        config.baseBackgroundColor = .systemMint
        config.imagePlacement = .leading
        config.titleAlignment = .leading

        enterWithoutLoginButton.configuration = config
    }
}
