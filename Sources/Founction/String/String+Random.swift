//
//  String+Random.swift
//  AppExtension
//
//  Created by 郑军铎 on 2018/10/18.
//  Copyright © 2018 ZJaDe. All rights reserved.
//

import Foundation

extension String {
    public static var uppercaseLetters: String = "ABCDEFGHIGKLMNOPQRSTUVWXYZ"
    public static var lowercaseLetters: String = "abcdefghigklmnopqrstuvwxyz"
    public static var decimalDigits: String = "0123456789"

    public static func random(min: Int, max: Int) -> String {
        guard max > min else {return ""}
        guard min > 0 else {return ""}
        let count = Int.random(min: min, max: max)
        return self.random(count: count)
    }
    /// ZJaDe: 随机数字加字母
    public static func random(count: Int) -> String {
        let source = self.uppercaseLetters + self.lowercaseLetters + self.decimalDigits
        return _random(source: source, count: count)
    }
    /// ZJaDe: 随机数字
    public static func randomNumber(count: Int) -> String {
        let source = self.decimalDigits
        return _random(source: source, count: count)
    }
    private static func _random(source: String, count: Int) -> String {
        var result: String = ""
        (0..<count).forEach { (_) in
            result.append(source[Int(arc4random() % UInt32(source.count))])
        }
        return result
    }

}
