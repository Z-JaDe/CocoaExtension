import UIKit

var str = "Hello, playground"

func createImage() -> UIImage? {
    guard let image1 = UIImage(named: "icon-1024") else {
        return nil
    }
    guard let image2 = UIImage(named: "ic_user_userImage_noLogin") else {
        return nil
    }
    let image1Rect = CGRect(origin: CGPoint.zero, size: image1.size)
    let image2Rect = CGRect(origin: CGPoint(x: 200, y: 200), size: CGSize(width: 200, height: 200))
    let format = UIGraphicsImageRendererFormat()
    format.scale = image1.scale
    format.opaque = false
    let imageRenderer = UIGraphicsImageRenderer(size: image1Rect.size, format: format)
    return imageRenderer.image { (context) in
        UIColor.red.setFill()
        context.fill(image1Rect)
        //    let path = UIBezierPath(roundedRect: image1Rect, cornerRadius: 55)
        //    path.fill()
        image1.draw(in: image1Rect, blendMode: .normal, alpha: 1)
        image2.draw(in: image2Rect, blendMode: .normal, alpha: 1)
        image2.draw(in: image2Rect.offsetBy(dx: 200, dy: 200), blendMode: .destinationIn, alpha: 1)
        
        //    context.translateBy(x: 0, y: image2.size.height)
        //    context.scaleBy(x: 1, y: -1)
        //    context.setBlendMode(.normal)
        //    let rect = CGRect(origin: .zero, size: image2.size)
        //    context.clip(to: rect, mask: image2.cgImage!)
        //    UIColor.red.setFill()
        //    context.fill(rect)
    }
}
let time = clock()
let image = createImage()
let time2 = clock() - time
