//
//  UIImage+ImageEffects.h
//  Any
//
//  Created by ZJaDe on 2018/6/20.
//  Copyright © 2018年 ZJaDe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageEffects)

- (UIImage* _Nullable)applyBlurWithRadius:(CGFloat)blurRadius
                                 tintColor:(UIColor* _Nullable)tintColor
                     saturationDeltaFactor:(CGFloat)saturationDeltaFactor
                                 maskImage:(UIImage* _Nullable)maskImage;

@end
