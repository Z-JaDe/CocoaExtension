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
        count: Int,
        append appendClosure: (Int) -> Element,
        remove removeClosure: (Element) -> Void
        ) {
        if self.count < count {
            for offset in self.count..<count {
                append(appendClosure(offset))
            }
        } else {
            while self.count > count {
                removeClosure(removeLast())
            }
        }
    }

    public mutating func countIsEqual<T, C>(
        _ otherArray: C,
        bind bindClosure: (Element, T, Int) -> Void,
        append appendClosure: (T) -> Element,
        remove removeClosure: (Element) -> Void
        ) where C: Collection, C.Element == T, C.Index == Int {

        self.countIsEqual(count: otherArray.count, append: {appendClosure(otherArray[$0])}, remove: removeClosure)
        self.lazy.enumerated().forEach { (arg) in
            bindClosure(arg.element, otherArray[arg.offset], arg.offset)
        }
    }
}
extension Array {
    public func indexCanBound(_ index: Int) -> Bool {
        return (startIndex..<endIndex).contains(index)
    }
    public func indexCanInsert(_ index: Int) -> Bool {
        return (startIndex...endIndex).contains(index)
    }
}

extension Array where Element: Equatable {
    @discardableResult
    public mutating func remove(_ element: Element) -> Int? {
        if let index = self.firstIndex(of: element) {
            self.remove(at: index)
            return index
        } else {
            return nil
        }
    }
}
