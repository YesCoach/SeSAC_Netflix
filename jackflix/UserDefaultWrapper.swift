//
//  UserDefaultWrapper.swift
//  jackflix
//
//  Created by 박태현 on 2023/07/28.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {

    let key: String
    let defaultValue: T

    var wrappedValue: T {
        get { UserDefaults.standard.object(forKey: key) as? T ?? self.defaultValue }
        set {
            UserDefaults.standard.set(newValue, forKey: self.key)
            print("\(newValue)가 \(key)에 저장되었습니다")
        }
    }
}
