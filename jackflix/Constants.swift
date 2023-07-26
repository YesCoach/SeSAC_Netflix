//
//  Constants.swift
//  jackflix
//
//  Created by 박태현 on 2023/07/26.
//

import Foundation

enum Constants {
    case email
    case password
    case nickname
    case isLogin
}

extension Constants {
    var userDefaultsKey: String {
        switch self {
        case .email: return "email"
        case .password: return "password"
        case .nickname: return "nickname"
        case .isLogin: return "isLogin"
        }
    }
}
