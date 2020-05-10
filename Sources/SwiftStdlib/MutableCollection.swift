//
//  MutableCollection.swift
//  CocoaExtension
//
//  Created by 郑军铎 on 2020/5/10.
//  Copyright © 2020 zjade. All rights reserved.
//

import Foundation

public extension MutableCollection where Self: RandomAccessCollection {
    mutating func sort<T>(by keyPath: KeyPath<Element, T>, with compare: (T, T) -> Bool) {
        sort { compare($0[keyPath: keyPath], $1[keyPath: keyPath]) }
    }
    mutating func sort<T: Comparable>(by keyPath: KeyPath<Element, T>) {
        sort { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }
    mutating func sort<T: Comparable, U: Comparable>(by keyPath1: KeyPath<Element, T>,
                                                     and keyPath2: KeyPath<Element, U>) {
        sort {
            if $0[keyPath: keyPath1] != $1[keyPath: keyPath1] {
                return $0[keyPath: keyPath1] < $1[keyPath: keyPath1]
            }
            return $0[keyPath: keyPath2] < $1[keyPath: keyPath2]
        }
    }
    mutating func sort<T: Comparable, U: Comparable, V: Comparable>(by keyPath1: KeyPath<Element, T>,
                                                                    and keyPath2: KeyPath<Element, U>,
                                                                    and keyPath3: KeyPath<Element, V>) {
        sort {
            if $0[keyPath: keyPath1] != $1[keyPath: keyPath1] {
                return $0[keyPath: keyPath1] < $1[keyPath: keyPath1]
            }
            if $0[keyPath: keyPath2] != $1[keyPath: keyPath2] {
                return $0[keyPath: keyPath2] < $1[keyPath: keyPath2]
            }
            return $0[keyPath: keyPath3] < $1[keyPath: keyPath3]
        }
    }
}

public extension MutableCollection {
    mutating func assignToAll<Value>(value: Value, by keyPath: WritableKeyPath<Element, Value>) {
        guard !isEmpty else { return }

        var idx = startIndex
        while idx != endIndex {
            self[idx][keyPath: keyPath] = value
            idx = index(after: idx)
        }
    }
}
