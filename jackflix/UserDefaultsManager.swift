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
}

extension UserDefaultsManager {
    func saveLoginStatus() {
        standard.set(true, forKey: Constants.UserDefaultsKey.isLogin.rawValue)
    }

    func checkIsLogin() -> Bool {
        return standard.bool(forKey: Constants.UserDefaultsKey.isLogin.rawValue)
    }

    func terminateApp() {
        standard.set(false, forKey: Constants.UserDefaultsKey.isLogin.rawValue)
    }
}
