//
//  DetailViewController.swift
//  jackflix
//
//  Created by 박태현 on 2023/07/19.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var codeTextField: UITextField!
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var infoSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        [
            emailTextField, passwordTextField, nicknameTextField, locationTextField, codeTextField
        ].forEach {
            guard let textField = $0 else { return }
            textField.textColor = .white
            textField.backgroundColor = .darkGray
            textField.borderStyle = .roundedRect
            textField.textAlignment = .left
            textField.attributedPlaceholder = NSAttributedString(
                string: textField.placeholder ?? "",
                attributes: [NSAttributedString.Key.foregroundColor : UIColor.white]
            )
        }
        passwordTextField.isSecureTextEntry = true

        signInButton.layer.cornerRadius = 8
        signInButton.setTitle("가입하기", for: .normal)
        signInButton.setTitleColor(.black, for: .normal)
        signInButton.backgroundColor = .green

        infoSwitch.setOn(false, animated: true)
        infoSwitch.onTintColor = .green
        infoSwitch.thumbTintColor = .white
    }

    @IBAction func didSignInButtonTouched(_ sender: UIButton) {
        view.endEditing(true)
        guard emailTextField.text! != "" && passwordTextField.text! != "" && nicknameTextField.text! != ""
        else {
            let alert = UIAlertController(
                title: "회원정보가 부족해요!",
                message: "정보를 마저 입력해주세요",
                preferredStyle: .alert
            )
            let confirmAction = UIAlertAction(title: "확인", style: .default)
            alert.addAction(confirmAction)
            present(alert, animated: true)
            return
        }
        let alert = UIAlertController(
            title: "회원가입 하시겠어요?",
            message: "\(nicknameTextField.text!)님의 ID: \(emailTextField.text!)",
            preferredStyle: .alert
        )
        let confirmAction = UIAlertAction(title: "확인", style: .default)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)

        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }

    @IBAction func didBackgroundViewTouched(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
