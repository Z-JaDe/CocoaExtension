//
//  Array.swift
//  ZiWoYou
//
//  Created by ZJaDe on 16/10/13.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import Foundation

public extension Array {
    mutating func safeSwap(from index: Index, to otherIndex: Index) {
        guard index != otherIndex else { return }
        guard startIndex..<endIndex ~= index else { return }
        guard startIndex..<endIndex ~= otherIndex else { return }
        swapAt(index, otherIndex)
    }
    mutating func countIsEqual(
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

    mutating func countIsEqual<T, C>(
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
public extension Array {
    func indexCanBound(_ index: Int) -> Bool {
        return (startIndex..<endIndex).contains(index)
    }
    func indexCanInsert(_ index: Int) -> Bool {
        return (startIndex...endIndex).contains(index)
    }
}

public extension Array where Element: Equatable {
    @discardableResult
    mutating func remove(_ element: Element) -> Int? {
        if let index = self.firstIndex(of: element) {
            self.remove(at: index)
            return index
        } else {
            return nil
        }
    }
}
