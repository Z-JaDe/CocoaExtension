//
//  Array.swift
//  ZiWoYou
//
//  Created by ZJaDe on 16/10/13.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import Foundation

extension Array {
    public mutating func countIsEqual(
        _ count: Int,
        append appendClosure: (Int) -> Element,
        remove removeClosure: (Element) -> Void
        ) {
        var result = self
        if result.count < count {
            for offset in result.count..<count {
                result.append(appendClosure(offset))
            }
        } else {
            while result.count > count {
                removeClosure(result.removeLast())
            }
        }
        if result.count != self.count {
            self = result
        }
    }

    public mutating func countIsEqual<T>(
        _ otherArray: [T],
        bind bindClosure: (Element, T) -> Void,
        append appendClosure: (T) -> Element,
        remove removeClosure: (Element) -> Void
        ) {

        self.countIsEqual(otherArray.count, append: {appendClosure(otherArray[$0])}, remove: removeClosure)
        self.enumerated().forEach { (offset, element) in
            bindClosure(element, otherArray[offset])
        }
    }
}
extension Array {
    public func indexCanBound(_ index: Int) -> Bool {
        return index < self.endIndex && index >= self.startIndex
    }
    public func indexCanInsert(_ index: Int) -> Bool {
        return index <= self.endIndex && index >= self.startIndex
    }
}

extension Array where Element: Equatable {
    @discardableResult
    public mutating func remove(_ element: Element) -> Int? {
        if let index = self.index(of: element) {
            self.remove(at: index)
            return index
        } else {
            return nil
        }
    }
}
