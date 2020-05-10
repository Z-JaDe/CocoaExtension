//
//  Bool.swift
//  ZiWoYou
//
//  Created by ZJaDe on 16/10/13.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

public extension Optional where Wrapped == Bool {
    var isNilOrTrue: Bool {
        switch self {
        case .none:
            return true
        case .some(let value):
            return value
        }
    }
    var isNilOrFalse: Bool {
        switch self {
        case .none:
            return true
        case .some(let value):
            return value == false
        }
    }
}
