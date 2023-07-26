//
//  DetailViewController.swift
//  jackflix
//
//  Created by 박태현 on 2023/07/19.
//

import UIKit

enum TextFieldType: Int {
    case email = 100
    case password = 200
    case nickname = 300
    case location = 400
    case code = 500
}

final class DetailViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var codeTextField: UITextField!
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var infoSwitch: UISwitch!

    @IBOutlet var saveResultLabel: UILabel!
    @IBOutlet var testTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureData()
    }

    @IBAction func didTextFieldEntered(_ sender: UITextField) {
        print("키보드 리턴키 클릭: \(sender.tag)")

        guard let text = sender.text,
              let value = TextFieldType(rawValue: sender.tag)
        else {
            print("오류가 발생했습니다")
            return
        }

        switch value {
        case .email:
            print("아이디는 \(text) 입니다.")
        case .password:
            print("비밀번호는 \(text) 입니다")
        case .nickname:
            print("닉네임은 \(text) 입니다")
        case .location:
            print("위치는 \(text) 입니다")
        case .code:
            print("추천인 코드는 \(text) 입니다")
        }
    }

    @IBAction func didSignInButtonTouched(_ sender: UIButton) {
        view.endEditing(true)
        checkSignInInformation()
    }

    @IBAction func didBackgroundViewTouched(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    @IBAction func didSaveButtonTouched(_ sender: UIButton) {
        print("클릭했습니다.")
        saveSignInInformation()
    }
}

private extension DetailViewController {
    func configureUI() {
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

        // tag 설정

        emailTextField.tag = TextFieldType.email.rawValue
        passwordTextField.tag = TextFieldType.password.rawValue
        nicknameTextField.tag = TextFieldType.nickname.rawValue
        locationTextField.tag = TextFieldType.location.rawValue
        codeTextField.tag = TextFieldType.code.rawValue
    }

    func configureData() {
        let email = UserDefaults.standard.string(forKey: "email")
        let password = UserDefaults.standard.string(forKey: "password")
        let nickname = UserDefaults.standard.string(forKey: "name")

        if let email {
            emailTextField.text = email
        }

        if let password {
            passwordTextField.text = password
        }

        if let nickname {
            nicknameTextField.text = nickname
        }

        saveResultLabel.text =  "\(UserDefaults.standard.integer(forKey: "save"))"
    }

    func checkSignInInformation() {
        let alert = UIAlertController(
            title: nil,
            message: nil,
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

    func saveSignInInformation() {
        UserDefaultsManager.shared.saveUserInformation(
            email: emailTextField.text!,
            password: passwordTextField.text!,
            nickname: nicknameTextField.text!
        )

        // 저장 버튼 클릭 횟수 저장 기능
        // 1. 저장된 횟수 가지고 오기
        // 2. 저장된 횟수에 1을 더하기
        // 3. 더한 값을 다시 저장함

        UserDefaultsManager.shared.saveSavingCount()
        saveResultLabel.text = "\(UserDefaultsManager.shared.loadSavingCount())"
    }
}
