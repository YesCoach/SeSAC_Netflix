//
//  MovieViewController.swift
//  jackflix
//
//  Created by 박태현 on 2023/07/19.
//

import UIKit

final class MovieViewController: UIViewController {

    @IBOutlet var previewFirstImageView: UIImageView!
    @IBOutlet var secondImageView: UIImageView!
    @IBOutlet var thirdImageView: UIImageView!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var randomPlayButon: UIButton!
    @IBOutlet var netflixLabel: UILabel!

    let random = ["부산행", "도둑들", "명량", "암살", "베테랑", "알라딘", "왕의남자"]

    // 사용자에게 화면이 보이기직전에 실행되는 부분
    // 모서리 둥글기, 그림자 등 스토리보드에서 설정할 수 없는 UI를 설정할 때 주로 사용
    // 뷰컨트롤러 생명주기

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    @IBAction func didFavoriteButtonTouched(_ sender: UIButton) {
        if !UserDefaultsManager.shared.checkIsLogin() {
            performSegue(withIdentifier: Constants.Identifier.signInSegue.rawValue, sender: nil)
        } else {
            print("내가 찜한 콘텐츠로 이동")
        }
    }

    @IBAction func didInformationButtonTouched(_ sender: UIButton) {
        if !UserDefaultsManager.shared.checkIsLogin() {
            performSegue(withIdentifier: Constants.Identifier.signInSegue.rawValue, sender: nil)
        } else {
            print("정보로 이동")
        }
    }

    @IBAction func playButtonClicked(_ sender: UIButton) {
        [
            posterImageView, previewFirstImageView, secondImageView, thirdImageView
        ].forEach {
            $0.image = pickRandomImage()
        }
    }
}

private extension MovieViewController {
    func configureUI() {
        configureButton()
        configureLabel(previewFirstImageView, .red)
        configureLabel(secondImageView, .green)
        configureLabel(thirdImageView, .blue)
        previewFirstImageView.image = pickRandomImage()
    }

    func configureButton() {
        let normal = UIImage(named: "play_normal")
        let highlight = UIImage(named: "play_highlighted")
        randomPlayButon.setTitleColor(.blue, for: .normal)
        randomPlayButon.setTitleColor(.red, for: .highlighted)
        randomPlayButon.setImage(normal, for: .normal)
        randomPlayButon.setImage(highlight, for: .highlighted)
        randomPlayButon.layer.cornerRadius = 10.0
        randomPlayButon.layer.borderColor = UIColor.red.cgColor
        randomPlayButon.layer.borderWidth = 4.0
    }

    // 매개변수: Parameter - 전달인자를 받을 변수
    // 전달인자: Argument - 함수를 호출할 때 전달하는 값(시시각각 변동)
    func configureLabel(_ name: UIImageView, _ borderColor: UIColor) {
        name.contentMode = .scaleAspectFill
        name.layer.cornerRadius = 50.0
        name.layer.borderWidth = 5.0
        name.layer.borderColor = borderColor.cgColor
    }

    func pickRandomImage() -> UIImage? {
        let randomResult = random[Int.random(in: 0..<random.count)]
        return UIImage(named: randomResult)
    }
}
