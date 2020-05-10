//
//  String.swift
//  AppExtension
//
//  Created by ZJaDe on 2018/10/18.
//  Copyright © 2018 ZJaDe. All rights reserved.
//

import Foundation

public extension String {
    /// ZJaDe: 根据下标返回字符
    subscript(integerIndex: Int) -> Character {
        self[index(startIndex, offsetBy: integerIndex)]
    }
    /// ZJaDe: substring的个数
    func count(_ substring: String) -> Int {
        components(separatedBy: substring).count - 1
    }

    /// ZJaDe: 首字母大写
    var capitalizeFirst: String {
        var result = self
        result.replaceSubrange(startIndex...startIndex, with: String(self[startIndex]).capitalized)
        return result
    }
    /// ZJaDe: 是否只有空格和转行符
    func isOnlyEmptySpacesAndNewLine() -> Bool {
        trimmed.isEmpty
    }
    /// ZJaDe: 去除空格和转行符
    var trimmed: String {
        trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
}
