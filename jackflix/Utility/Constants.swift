//
//  Constants.swift
//  jackflix
//
//  Created by 박태현 on 2023/07/26.
//

import Foundation

struct Constants {
    enum UserDefaults: String {
        case email
        case password
        case nickname
        case isLoggedIn
        case save

        var key: String {
            return self.rawValue
        }
    }

    enum Segue: String {
        case signInSegue = "SignInSegue"

        var key: String {
            return self.rawValue
        }
    }
}
