//
//  Constants.swift
//  jackflix
//
//  Created by 박태현 on 2023/07/26.
//

import Foundation

struct Constants {
    enum UserDefaultsKey: String {
        case email
        case password
        case nickname
        case isLogin
        case save
    }

    enum Identifier: String {
        case signInSegue = "SignInSegue"
    }
}
