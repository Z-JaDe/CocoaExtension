//
//  UIImage+ImageEffects.h
//  Any
//
//  Created by 郑军铎 on 2018/6/20.
//  Copyright © 2018年 ZJaDe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageEffects)

- (UIColor* _Nullable)averageColor;

- (UIImage* _Nullable)applyBlurWithRadius:(CGFloat)blurRadius
                                 tintColor:(UIColor* _Nullable)tintColor
                     saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                                 maskImage:(UIImage* _Nullable)maskImage;

- (UIColor* _Nullable)mostColor;
@end
