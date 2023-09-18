//
//  CustomObservable.swift
//  jackflix
//
//  Created by 박태현 on 2023/09/18.
//

import Foundation

final class CustomObservable<T> {

    typealias Listner = (T) -> Void
    var listener: Listner?

    var value: T {
        // 값이 변하면 클로저 실행
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(listener: Listner?) {
        self.listener = listener
        listener?(value)
    }
}
