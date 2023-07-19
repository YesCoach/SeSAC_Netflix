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

    @IBOutlet var testTextField: UITextField!

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
        let alert = UIAlertController(
            title: "",
            message: "",
            preferredStyle: .alert
        )
        let confirmAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(confirmAction)

        guard !emailTextField.text!.isEmpty && !passwordTextField.text!.isEmpty && !nicknameTextField.text!.isEmpty
        else {
            alert.title = "회원정보가 부족해요!"
            alert.message = "정보를 마저 입력해주세요"
            present(alert, animated: true)
            return
        }
        if passwordTextField.text!.count < 6 {
            alert.message = "비밀번호는 6자 이상으로 입력해주세요!"
        } else {
            alert.title = "회원가입 하시겠어요?"
            alert.message = "\(nicknameTextField.text!)님의 ID: \(emailTextField.text!)"
            let cancelAction = UIAlertAction(title: "취소", style: .cancel)
            alert.addAction(cancelAction)
        }
        present(alert, animated: true)
    }

    @IBAction func didBackgroundViewTouched(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
