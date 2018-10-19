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
    public var trimmed:String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }

    ///将空格分隔符插入现在的mobile中
    public var mobileHyphenText: String {
        //处理后的结果字符串
        var result = ""
        //遍历每一个字符
        for i in 0  ..< self.count {
            //如果当前到了第4个、第8个数字，则先添加个分隔符
            if i == 3 || i == 7 {
                result.append(" ")
                //如果添加分隔符位置在光标前面，光标则需向后移动一位
            }
            result.append(self[i])
        }
        return result
    }
    ///将空格分隔符插入现在的银行卡号中
    public var bankCodeHyphenText: String {
        //处理后的结果字符串
        var result = ""
        //遍历每一个字符
        for i in 0  ..< self.count {
            //如果当前到了第4个、第8个数字，则先添加个分隔符
            if i == 4 || i == 8 || i == 12 {
                result.append("   ")
                //如果添加分隔符位置在光标前面，光标则需向后移动一位
            }
            result.append(self[i])
        }
        return result
    }
}
