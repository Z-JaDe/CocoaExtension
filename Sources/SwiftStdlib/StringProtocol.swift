//
//  StringProtocol.swift
//  CocoaExtension
//
//  Created by 郑军铎 on 2020/5/10.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation

public extension StringProtocol {
    func commonSuffix<T: StringProtocol>(with aString: T, options: String.CompareOptions = []) -> String {
        guard !isEmpty && !aString.isEmpty else { return "" }

        var idx = endIndex
        var strIdx = aString.endIndex

        repeat {
            formIndex(before: &idx)
            aString.formIndex(before: &strIdx)

            guard String(self[idx]).compare(String(aString[strIdx]), options: options) == .orderedSame else {
                formIndex(after: &idx)
                break
            }

        } while idx > startIndex && strIdx > aString.startIndex

        return String(self[idx...])
    }

}
