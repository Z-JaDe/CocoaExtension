//
//  ViewController.swift
//  CocoaExtension
//
//  Created by 郑军铎 on 2018/10/19.
//  Copyright © 2018 zjade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            label.leftAnchor.constraint(equalTo: self.view.leftAnchor),
        ])
//        let center: AttributedString = AttributedString.build {
//            "".attr.color(UIColor.black).font(UIFont.systemFont(ofSize: 23))
//            "".attr.color(UIColor.black).font(UIFont.systemFont(ofSize: 23))
////            AttributedStringClass()
////            " Merry Xmas! ".mergeStyle(.font(.systemFont(ofSize: 36)), .color(.red), .bgColor(.yellow))
////            " Merry Xmas! ".mergeStyle(.font(.systemFont(ofSize: 36)), .color(.red), .bgColor(.yellow))
////            "\(image: UIImage.animatedGIF(withName: "timg")!)".mergeStyle(.oblique)
//        }
//        label.attributedText = NSAttributedString {
//            "".foregroundColor(.black).font(UIFont.systemFont(ofSize: 23))
//            "".foregroundColor(UIColor.black).font(UIFont.systemFont(ofSize: 23))
//        }
//        label.attributedText = NSAttributedString.build {
//            AttributedString {
//                "Hello \("username", .color(.red)), isn't this \("cool", .color(.blue), .oblique, .underline(.purple, .single))?"
//            }
//            AttributedString()
//            AttributedString()
//        }
        label.numberOfLines = 0

//        """
//        \(wrap: center.mergeStyle(.alignment(.center)))
//
//        Go there to \("learn more about String Interpolation", .link("https://github.com/apple/swift-evolution/blob/master/proposals/0228-fix-expressiblebystringinterpolation.md"), .underline(.blue, .single))!
//        """
        // TODO: 出错
//        label.makeAttrStr {
//            //            "Hello \("username", .color(.red)), isn't this \("cool", .color(.blue), .oblique, .underline(.purple, .single))?" as AttributedString
//            AttributedString().mergeStyle(.color(.red))
//            AttributedString().mergeStyle(.color(.red))
//            //            """
//            //            \(" Merry Xmas! ", .font(.systemFont(ofSize: 36)), .color(.red), .bgColor(.yellow))
//            //            \(image: UIImage.animatedGIF(withName: "timg")!)
//            //                """.mergeStyle(.alignment(.center))
//            //            "Go there to \("learn more about String Interpolation", .link("https://github.com/apple/swift-evolution/blob/master/proposals/0228-fix-expressiblebystringinterpolation.md"), .underline(.blue, .single))!"
//        }
    }


}

