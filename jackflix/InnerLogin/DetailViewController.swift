//
//  DetailViewController.swift
//  jackflix
//
//  Created by 박태현 on 2023/07/19.
//

import UIKit

enum TextFieldType: Int, CaseIterable {
    case email
    case password
    case nickname
    case location
    case code

    var next: TextFieldType {
        guard let nextType = TextFieldType(rawValue: self.rawValue + 1) else {
            return self
        }
        return nextType
    }
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
        bindViewModel()
    }

    @IBAction func didSignInButtonTouched(_ sender: UIButton) {
        view.endEditing(true)
        viewModel.checkInButtonDidTouched()
    }

    @IBAction func didBackgroundViewTouched(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    @IBAction func didSaveButtonTouched(_ sender: UIButton) {
        print("클릭했습니다.")
        viewModel.saveSignInInfoButtonTouched()
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

        [ emailTextField, passwordTextField, nicknameTextField, locationTextField, codeTextField ]
            .forEach { $0?.delegate = self }
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
        viewModel.checkInButtonDidTouched()
    }

}

extension DetailViewController: UITextFieldDelegate {

    /// 텍스트필드의 입력이 끝나면, 뷰모델에 해당 값을 바로 저장합니다.
    /// 열거형과 텍스트필드의 태그값을 통해 입력 항목을 구분합니다.
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text,
              let value = TextFieldType(rawValue: textField.tag)
        else {
            print("오류가 발생했습니다")
            return
        }

        switch value {
        case .email:
            viewModel.email.value = text
        case .password:
            viewModel.password.value = text
        case .nickname:
            viewModel.nickname.value = text
        case .location:
            viewModel.location.value = text
        case .code:
            viewModel.code.value = text
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let value = TextFieldType(rawValue: textField.tag)
        else {
            print("오류가 발생했습니다")
            return true
        }
        textField.resignFirstResponder()
        let targetValue: TextFieldType = value.next

        if targetValue != value {
            view.viewWithTag(targetValue.rawValue)?.becomeFirstResponder()
        }
        return true
    }
}
