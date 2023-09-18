//
//  DetailViewModel.swift
//  jackflix
//
//  Created by 박태현 on 2023/09/18.
//

import Foundation

class DetailViewModel {

    let email: CustomObservable<String?> = .init(nil)
    let password: CustomObservable<String?> = .init(nil)
    let nickname: CustomObservable<String?> = .init(nil)
    let location: CustomObservable<String?> = .init(nil)
    let code: CustomObservable<String?> = .init(nil)
    let saveResult: CustomObservable<String?> = .init(nil)

    let alertFailure: CustomObservable<(String?, String?)> = .init((nil, nil))
    let alertSuccess: CustomObservable<(String?, String?)> = .init((nil, nil))
    let isSignInButtonEnable: CustomObservable<Bool> = .init(false)

    func checkInButtonDidTouched() {

        guard let email = email.value, email.validateEmailForm() else {
            // 이메일 검증 실패
            alertFailure.value = ("아이디를 확인해주세요", "아이디는 @를 포함, 최대 20자까지 가능해요")
            return
        }

        guard let password = password.value, password.validatePasswordForm() else {
            // 패스워드 검증 실패
            alertFailure.value = ("비밀번호를 확인해주세요", "비밀번호는 6~10자리만 가능해요")
            return
        }

        guard let nickname = nickname.value, !nickname.isEmpty else {
            alertFailure.value = ("닉네임이 비어있어요", "닉네임은 필수로 작성해야해요")
            return
        }

        if let code = code.value, !code.isEmpty, !code.validateSuggestCodeForm() {
            // 추천인 코드 검증 실패
            alertFailure.value = ("추천인 코드를 확인해주세요", "추천인 코드는 6자리를 입력해주세요")
            return
        }

        let successAlertTitle = "회원가입 하시겠어요?"
        let successAlertMessage = "\(nickname)님의 ID: \(email)"
        alertSuccess.value = (successAlertTitle, successAlertMessage)
    }
    
}
