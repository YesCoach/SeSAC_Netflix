//
//  String+.swift
//  jackflix
//
//  Created by 박태현 on 2023/09/18.
//

import Foundation
import RegexBuilder

extension String {

    /// 정규식을 활용한 email 유효성 검증
    func validateEmailForm() -> Bool {
        // 왜 안되는거신가
        /*
            if #available(iOS 16.0, *) {
                let regex = /[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\\\.[A-Za-z]{2,20}/
                let result = self.firstMatch(of: regex)?.output
                print(result)
                return result != nil
            } else {
                 정규식의 시작: ^, 끝: $
            }
         */
            let pattern = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}$"
            let regex = try? NSRegularExpression(pattern: pattern)
            let result = regex?.firstMatch(
                in: self,
                options: [],
                range: NSRange(location: 0, length: self.count)
            )
            return result != nil
    }

    /// 패스워드 유효성 검증
    func validatePasswordForm() -> Bool {
        if #available(iOS 16.0, *) {
            let regex = /(.){6,10}/
            let result = try? regex.wholeMatch(in: self)?.output
            return result != nil
        } else {
            let pattern = "^(.){6,10}$"
            let regex = try? NSRegularExpression(pattern: pattern)
            let result = regex?.firstMatch(
                in: self,
                options: [],
                range: NSRange(location: 0, length: self.count)
            )
            return result != nil
        }
    }

    /// 추천인 코드 유효성 검증
    func validateSuggestCodeForm() -> Bool {
        if #available(iOS 16.0, *) {
            let regex = /[0-9]{6}/
            let result = try? regex.wholeMatch(in: self)?.output
            return result != nil
        } else {
            let pattern = "^[0-9]{6}$"
            let regex = try? NSRegularExpression(pattern: pattern)
            let result = regex?.firstMatch(
                in: self,
                options: [],
                range: NSRange(location: 0, length: self.count)
            )
            return result != nil
        }
    }
}
