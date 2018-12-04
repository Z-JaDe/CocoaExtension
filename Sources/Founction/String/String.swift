//
//  String.swift
//  AppExtension
//
//  Created by 郑军铎 on 2018/10/18.
//  Copyright © 2018 ZJaDe. All rights reserved.
//

import Foundation

extension String {
    /// ZJaDe: 根据下标返回字符
    public subscript(integerIndex: Int) -> Character {
        return self[index(startIndex, offsetBy: integerIndex)]
    }
    /// ZJaDe: substring的个数
    public func count(_ substring: String) -> Int {
        return components(separatedBy: substring).count - 1
    }

    /// ZJaDe: 首字母大写
    public var capitalizeFirst: String {
        var result = self
        result.replaceSubrange(startIndex...startIndex, with: String(self[startIndex]).capitalized)
        return result
    }
    /// ZJaDe: 是否只有空格和转行符
    public func isOnlyEmptySpacesAndNewLine() -> Bool {
        return self.trimmed.isEmpty
    }
    /// ZJaDe: 去除空格和转行符
    public var trimmed: String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
}
