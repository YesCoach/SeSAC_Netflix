//
//  UserDefaultsManager.swift
//  jackflix
//
//  Created by 박태현 on 2023/07/26.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()

    private let standard = UserDefaults.standard

    private init() {}

    @UserDefault(key: Constants.UserDefaults.isLoggedIn.key, defaultValue: false)
    var isLoggedIn: Bool

    @UserDefault(key: Constants.UserDefaults.email.key, defaultValue: "")
    var email: String

    @UserDefault(key: Constants.UserDefaults.password.key, defaultValue: "")
    var password: String

    @UserDefault(key: Constants.UserDefaults.nickname.key, defaultValue: "")
    var nickname: String

    @UserDefault(key: Constants.UserDefaults.save.key, defaultValue: 0)
    var saveCount: Int
}

extension UserDefaultsManager {
    /// 로그인 여부 정보를 초기화합니다
    /// 앱이 종료될 때 호출하세요
    func terminateApp() {
        isLoggedIn = false
    }
}
