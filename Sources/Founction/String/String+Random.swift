//
//  String+Random.swift
//  AppExtension
//
//  Created by ZJaDe on 2018/10/18.
//  Copyright © 2018 ZJaDe. All rights reserved.
//

import Foundation

extension String {
    public static let uppercaseLetters: String = "ABCDEFGHIGKLMNOPQRSTUVWXYZ"
    public static let lowercaseLetters: String = "abcdefghigklmnopqrstuvwxyz"
    public static let decimalDigits: String = "0123456789"

    public static func random(min: Int, max: Int) -> String {
        guard max >= min && min >= 0 else {return ""}
        let count = Int.random(in: min...max)
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
        return (0..<count).reduce(into: "") { (result, _) in
            result.append(source.randomElement()!)
        }
    }

}
