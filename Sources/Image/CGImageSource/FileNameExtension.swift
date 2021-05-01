//
//  FileNameExtension.swift
//  CocoaExtension
//
//  Created by Apple on 2020/1/17.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation

/// 获取文件名称和扩展
struct FileNameExtension {
    let name: String
    let exten: String
    init(name: String, defaultExten: String) {
        if let point = name.lastIndex(of: ".") {
            let exten = String(name.suffix(from: name.index(after: point)))
            self.exten = exten.isEmpty ? defaultExten : exten
            self.name = String(name.prefix(upTo: point))
        } else {
            self.exten = defaultExten
            self.name = name
        }
    }
    func getData(_ path: String?) -> Data? {
        guard let path = path else { return nil }
        return try? Data(contentsOf: URL(fileURLWithPath: path))
    }
    func getPath() -> String? {
        _getPath(name: name)
    }
    func getImagePath() -> String? {
        let scale = UIScreen.main.scale
        if scale > 1.0 {
            if let path = _getPath(name: "\(name)@2x") {
                return path
            } else if let path = _getPath(name: "\(name)@3x") {
                return path
            }
        }
        return _getPath(name: name)
    }
    private func _getPath(name: String) -> String? {
        Bundle.main.path(forResource: name, ofType: exten)
    }
}
