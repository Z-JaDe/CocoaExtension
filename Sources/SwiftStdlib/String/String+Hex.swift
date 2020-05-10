//
//  String+Hex.swift
//  Alamofire
//
//  Created by Apple on 2019/5/28.
//

import Foundation

public extension String {
    init?(hex: String) {
        self.init(bytes: [UInt8](hex: hex), encoding: .utf8)
    }
    var bytes: [UInt8] {
        data(using: .utf8, allowLossyConversion: true)?.bytes ?? Array(utf8)
    }
    var hexString: String {
        bytes.hexString
    }
}
