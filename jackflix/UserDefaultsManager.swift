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

    /// 로그인 상태를 저장합니다
    func saveLoginStatus() {
        standard.set(true, forKey: Constants.UserDefaults.isLogin.key)
    }

    /// 현재 로그인 상태 여부를 반환합니다
    /// - Returns: 로그인 여부
    func checkIsLogin() -> Bool {
        return standard.bool(forKey: Constants.UserDefaults.isLogin.key)
    }

    /// 로그인 여부 정보를 초기화합니다
    /// 앱이 종료될 때 호출하세요
    func terminateApp() {
        standard.set(false, forKey: Constants.UserDefaults.isLogin.key)
    }

    /// 유저 가입 정보를 저장합니다
    /// - Parameters:
    ///   - email: 이메일 주소
    ///   - password: 비밀번호
    ///   - nickname: 닉네임
    func saveUserInformation(email: String, password: String, nickname: String) {
        standard.set(email, forKey: Constants.UserDefaults.email.key)
        standard.set(password, forKey: Constants.UserDefaults.password.key)
        standard.set(nickname, forKey: Constants.UserDefaults.nickname.key)
    }


    /// 저장 버튼을 누른 횟수를 저장합니다
    func saveSavingCount() {
        // 저장 버튼 클릭 횟수 저장 기능
        // 1. 저장된 횟수 가지고 오기
        // 2. 저장된 횟수에 1을 더하기
        // 3. 더한 값을 다시 저장함

        let count = standard.integer(forKey: Constants.UserDefaults.save.key)
        standard.set(count + 1, forKey: Constants.UserDefaults.save.key)
    }


    /// 저장 횟수를 불러옵니다
    /// - Returns: 저장 버튼을 누른 횟수
    func loadSavingCount() -> Int {
        return standard.integer(forKey: Constants.UserDefaults.save.key)
    }

}
