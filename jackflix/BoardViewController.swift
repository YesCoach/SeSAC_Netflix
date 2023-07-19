//
//  BoardViewController.swift
//  jackflix
//
//  Created by 박태현 on 2023/07/19.
//

import UIKit

class BoardViewController: UIViewController {

    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var boardTextField: UITextField!
    @IBOutlet var testLabel: [UILabel]!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    @IBAction func didButtonTouched(_ sender: UIButton) {
        resultLabel.text = boardTextField.text
        boardTextField.text = nil
    }

    @IBAction func didBackGroundTouched(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    func configureUI() {
        configureResultLabel()
        configureBoardTextField()
        for item in testLabel {
            item.textColor = .red
            item.font = .boldSystemFont(ofSize: 15)
        }
    }

    func configureResultLabel() {
        resultLabel.textAlignment = .center
        resultLabel.text = "안녕하세요"
        resultLabel.font = .boldSystemFont(ofSize: 20)
        resultLabel.textColor = .purple
        resultLabel.numberOfLines = 0
    }

    func configureBoardTextField() {
        boardTextField.placeholder = "내용을 입력해주세요"
        boardTextField.textColor = .brown
        boardTextField.keyboardType = .emailAddress
        boardTextField.borderStyle = .line
    }
}
