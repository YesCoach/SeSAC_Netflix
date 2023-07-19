//
//  MovieViewController.swift
//  jackflix
//
//  Created by 박태현 on 2023/07/19.
//

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet var firstImageView: UIImageView!
    @IBOutlet var secondImageView: UIImageView!
    @IBOutlet var thirdImageView: UIImageView!

    @IBOutlet var posterImageView: UIImageView!

    // 사용자에게 화면이 보이기직전에 실행되는 부분
    // 모서리 둥글기, 그림자 등 스토리보드에서 설정할 수 없는 UI를 설정할 때 주로 사용
    // 뷰컨트롤러 생명주기
    override func viewDidLoad() {
        super.viewDidLoad()

        firstImageView.image = UIImage(named: "부산행")
        configureUI()
    }

    private func configureUI() {
        [
            firstImageView, secondImageView, thirdImageView
        ].forEach {
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = 50.0
            $0.layer.borderWidth = 5.0
            $0.layer.borderColor = UIColor.gray.cgColor
        }
    }
}
