//
//  UIImage+vImage.swift
//  Alamofire
//
//  Created by ZJaDe on 2018/6/20.
//

import Foundation

extension UIImage {
    func erode(withIterations iterations: Int32) -> UIImage {
        return (0..<iterations).reduce(self, { (image, _) -> UIImage in
            return image.erode()
        })
    }
    func dilate(withIterations iterations: Int32) -> UIImage {
        return (0..<iterations).reduce(self, { (image, _) -> UIImage in
            return image.dilate()
        })
    }
}
extension UIImage {
    func gradient(withIterations iterations: Int32) -> UIImage {
        let dilated: UIImage = self.dilate(withIterations: iterations)
        let eroded: UIImage = self.erode(withIterations: iterations)
        return dilated.blend(eroded, cropPoint: CGPoint.zero, .difference, 1)
    }
    func tophat(withIterations iterations: Int32) -> UIImage {
        let dilated: UIImage = self.dilate(withIterations: iterations)
        return self.blend(dilated, cropPoint: CGPoint.zero, .difference, 1)
    }
    func blackhat(withIterations iterations: Int32) -> UIImage {
        let eroded: UIImage = self.erode(withIterations: iterations)
        return eroded.blend(self, cropPoint: CGPoint.zero, .difference, 1)
    }

}
