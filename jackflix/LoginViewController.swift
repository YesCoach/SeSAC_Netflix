//
//  ViewController.swift
//  jackflix
//
//  Created by 박태현 on 2023/07/18.
//

import UIKit

final class LoginViewController: UIViewController {

    @IBOutlet var enterWithoutLoginButton: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailLoginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    @IBAction func dismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }

    @IBAction func didKeyboardReturnEntered(_ sender: UITextField) {

    }

    @IBAction func didEmailLoginButtonTouched(_ sender: UIButton) {
        guard !emailTextField.text!.isEmpty else {
            presentAlert(message: "이메일을 입력해주세요")
            return
        }
        guard !passwordTextField.text!.isEmpty else {
            presentAlert(message: "비밀번호를 입력해주세요")
            return
        }
        UserDefaultsManager.shared.saveLoginStatus()
        let movieViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "MovieViewController")
        movieViewController.modalPresentationStyle = .fullScreen
        present(movieViewController, animated: true)
    }
}

private extension LoginViewController {
    func configureUI() {
        configureButton()
        configureTextField()
    }

    func configureButton() {
        var withoutLoginButtonConfig = UIButton.Configuration.filled() // apple system button
        withoutLoginButtonConfig.title = "SeSAC 영등포캠퍼스"
        withoutLoginButtonConfig.subtitle = "로그인 없이 둘러보기"
        withoutLoginButtonConfig.image = .init(systemName: "house")

        withoutLoginButtonConfig.cornerStyle = .capsule
        withoutLoginButtonConfig.titlePadding = 5.0
        withoutLoginButtonConfig.imagePadding = 5.0
        withoutLoginButtonConfig.baseForegroundColor = .white
        withoutLoginButtonConfig.baseBackgroundColor = .systemMint
        withoutLoginButtonConfig.imagePlacement = .leading
        withoutLoginButtonConfig.titleAlignment = .leading

        enterWithoutLoginButton.configuration = withoutLoginButtonConfig

        var emailLoginButtonConfig = UIButton.Configuration.filled()
        emailLoginButtonConfig.title = "이메일로 로그인하기"

        emailLoginButtonConfig.cornerStyle = .small
        emailLoginButtonConfig.baseForegroundColor = .white
        emailLoginButtonConfig.baseBackgroundColor = .black

        emailLoginButton.configuration = emailLoginButtonConfig
    }

    func configureTextField() {
        emailTextField.keyboardType = .emailAddress
        passwordTextField.isSecureTextEntry = true

        emailTextField.placeholder = "이메일을 입력하세요"
        passwordTextField.placeholder = "비밀번호를 입력하세요"
    }

    func presentAlert(
        title: String = "",
        message: String = "",
        preferredStyle: UIAlertController.Style = .alert
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: preferredStyle
        )

        let action = UIAlertAction(title: "확인", style: .default)
        alert.addAction(action)

        present(alert, animated: true)
    }
}
