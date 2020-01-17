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
        let attr: AttributedString = """
        Hello \("username", .color(.red)), isn't this \("cool", .color(.blue), .oblique, .underline(.purple, .single))?
        
        \(wrap: """
        \(" Merry Xmas! ", .font(.systemFont(ofSize: 36)), .color(.red), .bgColor(.yellow))
        \(image: UIImage.animatedGIF(withName: "timg")!)
        """, .alignment(.center))
        
        Go there to \("learn more about String Interpolation", .link("https://github.com/apple/swift-evolution/blob/master/proposals/0228-fix-expressiblebystringinterpolation.md"), .underline(.blue, .single))!
        """
        label.attributedText = attr.finalize()
        label.numberOfLines = 0
    }


}

