//
//  UIImage+ImageEffects.h
//  Any
//
//  Created by 郑军铎 on 2018/6/20.
//  Copyright © 2018年 ZJaDe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageEffects)

- (UIColor * _Nullable)averageColor;

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius
                       tintColor:(UIColor *)tintColor
           saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                       maskImage:(UIImage *)maskImage;

- (UIColor* _Nullable)mostColor;
@end
