//
//  String+Hex.swift
//  Alamofire
//
//  Created by Apple on 2019/5/28.
//

import Foundation

extension String {
    public init?(hex: String) {
        self.init(bytes: [UInt8](hex: hex), encoding: .utf8)
    }
    public var bytes: [UInt8] {
        return data(using: .utf8, allowLossyConversion: true)?.bytes ?? Array(utf8)
    }
    public var hexString: String {
        return bytes.hexString
    }
}
extension Data {
    public init(hex: String) {
        self.init([UInt8](hex: hex))
    }
    public var bytes: [UInt8] {
        return Array(self)
    }
    public var hexString: String {
        return bytes.hexString
    }
}
extension Array where Element == UInt8 {
    public init(hex: String) {
        self.init()
        self.reserveCapacity(hex.unicodeScalars.lazy.underestimatedCount)
        var buffer: UInt8?
        var skip = hex.hasPrefix("0x") ? 2 : 0
        for char in hex.unicodeScalars.lazy {
            guard skip == 0 else {
                skip -= 1
                continue
            }
            guard char.value >= 48 && char.value <= 102 else {
                removeAll()
                return
            }
            let v: UInt8
            let c: UInt8 = UInt8(char.value)
            switch c {
            case let c where c <= 57:
                v = c - 48
            case let c where c >= 65 && c <= 70:
                v = c - 55
            case let c where c >= 97:
                v = c - 87
            default:
                removeAll()
                return
            }
            if let b = buffer {
                append(b << 4 | v)
                buffer = nil
            } else {
                buffer = v
            }
        }
        if let b = buffer {
            append(b)
        }
    }
    public var hexString: String {
        return lazy.reduce(into: "") {
            var s = String.init($1, radix: 16)
            if s.count == 1 {
                s = "0" + s
            }
            $0 += s
        }
    }
}
