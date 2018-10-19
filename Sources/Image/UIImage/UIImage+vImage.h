//
//  UIImage+vImage.h
//  Alamofire
//
//  Created by 郑军铎 on 2018/6/20.
//

#import <UIKit/UIKit.h>

@interface UIImage (vImage)

// Convolution Oprations
- (UIImage *)gaussianBlur;
- (UIImage *)edgeDetection;
- (UIImage *)emboss;
- (UIImage *)sharpen;
- (UIImage *)unsharpen;

// Geometric Operations
- (UIImage *)rotateInRadians:(float)radians;

// Morphological Operations
- (UIImage *)dilate;
- (UIImage *)erode;

// Histogram Operations
- (UIImage *)equalization;

@end
