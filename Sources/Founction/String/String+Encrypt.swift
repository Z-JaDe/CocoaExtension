//
//  String+Encrypt.swift
//  AppExtension
//
//  Created by ZJaDe on 2018/10/18.
//  Copyright © 2018 ZJaDe. All rights reserved.
//

import Foundation

extension String {
    public func encrypt(preFixLen: Int = 3, suffixLen: Int = 4) -> String {
        return "\(self.prefix(preFixLen))***\(self.suffix(suffixLen))"
    }
}
