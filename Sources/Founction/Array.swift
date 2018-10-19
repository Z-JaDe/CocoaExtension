//
//  Array.swift
//  ZiWoYou
//
//  Created by ZJaDe on 16/10/13.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import Foundation
extension Sequence where SubSequence: Sequence, SubSequence.Iterator.Element == Iterator.Element {

    public typealias Pair = (Element, Element)

    // you can do zip(self, self.dropFirst), but this slightly
    // more complex version will work for single pass sequences as well
    public func eachPair() -> AnySequence<Pair> {
        var iterator = self.makeIterator()
        guard var previous = iterator.next() else { return AnySequence([]) }
        return AnySequence({ () -> AnyIterator<Pair> in
            return AnyIterator({
                guard let next = iterator.next() else { return nil }
                defer { previous = next }
                return (previous, next)
            })
        })
    }
}

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
//    public func split(columnCount: Int, allCountIsEqual: Bool = false, _ appendMethod: (()-> Element)? = nil) -> [[Element]] {
//        guard columnCount > 0 else {
//            return [self]
//        }
//        var result: [[Element]] = []
//        var tempArr: [Element] = []
//        for element in self {
//            if tempArr.count < columnCount {
//                tempArr.append(element)
//            }
//            if tempArr.count == columnCount {
//                result.append(tempArr)
//                tempArr = []
//            }
//        }
//        if tempArr.count > 0 {
//            result.append(tempArr)
//            tempArr = []
//        }
//        if allCountIsEqual {
//            if var last = result.popLast() {
//                last.countIsEqual(columnCount, appendMethod!)
//                result.append(last)
//            }
//        }
//        return result
//    }
}
extension Array {
    public func indexCanBound(_ index: Int) -> Bool {
        return index < self.endIndex && index >= self.startIndex
    }
    public func indexCanInsert(_ index: Int) -> Bool {
        return index <= self.endIndex && index >= self.startIndex
    }
}
extension Array where Element == Bool {
    public func isTrue() -> Bool {
        return first(where: {$0 == false}) == nil
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
