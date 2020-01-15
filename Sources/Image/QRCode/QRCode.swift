//
//  QRCode.swift
//  ZiWoYou
//
//  Created by ZJaDe on 16/11/3.
//  Copyright © 2016 Z_JaDe. All rights reserved.
//

import UIKit

public struct QRCode {
    /// ZJaDe: 生成高清二维码图片
    public static func image(qrString: String, imageSize: CGFloat, fillColor: UIColor = UIColor.black, backColor: UIColor = UIColor.white) -> UIImage? {
        guard !qrString.isEmpty && imageSize > 10 else { return nil }
        let stringData = qrString.data(using: .utf8)
        /// ZJaDe: 生成
        let qrImageFilter = CIImageFilter()
        qrImageFilter.addFilter("CIQRCodeGenerator") { (qrFilter) in
            qrFilter.setValue(stringData, forKey: "inputMessage")
            qrFilter.setValue("M", forKey: "inputCorrectionLevel")
        }
        /// ZJaDe: 上色
        qrImageFilter.addFilter("CIFalseColor") { (colorFilter) in
            colorFilter.setValue(CIColor(color: fillColor), forKey: "inputColor0")
            colorFilter.setValue(CIColor(color: backColor), forKey: "inputColor1")
        }
        /// ZJaDe: 绘制
        guard let cgImage = qrImageFilter.createCGImage() else { return nil }
        let imgSize = CGSize(width: imageSize, height: imageSize)
        return UIGraphicsImageRenderer(size: imgSize).image(actions: { (context) in
            let context = context.cgContext
            context.interpolationQuality = .none
            context.scaleBy(x: 1.0, y: -1.0)
            context.draw(cgImage, in: context.boundingBoxOfClipPath)
        })

//        UIGraphicsBeginImageContext(imgSize)
//        guard let context = UIGraphicsGetCurrentContext() else { return nil }
//        let codeImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()

    }
    /// ZJaDe: 从图片中读取二维码
    public static func scan(qrImage: UIImage) -> String? {
        guard let ciImage = qrImage.ciImage else { return nil }
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: CIContext(), options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])
        return ((detector?.features(in: ciImage))?.first as? CIQRCodeFeature)?.messageString
    }
}
