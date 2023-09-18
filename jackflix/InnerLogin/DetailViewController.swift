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

    private let userDefaultsManager = UserDefaultsManager.shared
    private let viewModel = DetailViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureData()
        bindViewModel()
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
            viewModel.email.value = text
            print("아이디는 \(text) 입니다.")
        case .password:
            viewModel.password.value = text
            print("비밀번호는 \(text) 입니다")
        case .nickname:
            viewModel.nickname.value = text
            print("닉네임은 \(text) 입니다")
        case .location:
            viewModel.location.value = text
            print("위치는 \(text) 입니다")
        case .code:
            viewModel.code.value = text
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
        viewModel.email.value = UserDefaults.standard.string(forKey: "email")
        viewModel.password.value = UserDefaults.standard.string(forKey: "password")
        viewModel.nickname.value = UserDefaults.standard.string(forKey: "name")
        viewModel.saveResult.value = "\(UserDefaults.standard.integer(forKey: "save"))"
    }

    func bindViewModel() {
        viewModel.email.bind { [weak self] email in
            guard let self else { return }
            emailTextField.text = email
        }

        viewModel.password.bind { [weak self] password in
            guard let self else { return }
            passwordTextField.text = password
        }

        viewModel.nickname.bind { [weak self] nickname in
            guard let self else { return }
            nicknameTextField.text = nickname
        }

        viewModel.location.bind { [weak self] location in
            guard let self else { return }
            locationTextField.text = location
        }

        viewModel.code.bind { [weak self] code in
            guard let self else { return }
            codeTextField.text = code
        }

        viewModel.saveResult.bind { [weak self] result in
            guard let self else { return }
            saveResultLabel.text = result
        }

        viewModel.alertSuccess.bind { [weak self] title, message in
            guard let self, let title, let message else { return }
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

            let confirm = UIAlertAction(title: "확인", style: .default)
            let cancel = UIAlertAction(title: "취소", style: .cancel)

            [ confirm, cancel ].forEach { alert.addAction($0) }

            present(alert, animated: true)
        }

        viewModel.alertFailure.bind { [weak self] title, message in
            guard let self, let title, let message else { return }
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

            let confirm = UIAlertAction(title: "확인", style: .default)

            alert.addAction(confirm)

            present(alert, animated: true)
        }
    }

    func checkSignInInformation() {
        let alert = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .alert
        )
        let confirmAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(confirmAction)

        viewModel.checkInButtonDidTouched()
    }

    func saveSignInInformation() {
        userDefaultsManager.email = emailTextField.text!
        userDefaultsManager.password = passwordTextField.text!
        userDefaultsManager.nickname = nicknameTextField.text!

        // 저장 버튼 클릭 횟수 저장 기능
        // 1. 저장된 횟수 가지고 오기
        // 2. 저장된 횟수에 1을 더하기
        // 3. 더한 값을 다시 저장함

        userDefaultsManager.saveCount += 1
        saveResultLabel.text = "\(userDefaultsManager.saveCount)"
    }
}
