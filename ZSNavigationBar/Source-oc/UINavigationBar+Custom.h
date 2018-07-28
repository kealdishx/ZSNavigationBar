//
//  UINavigationBar+Custom.h
//  ZSNavigationBar
//
//  Created by iiiceblink on 2018/7/27.
//  Copyright © 2018年 Lingyue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (Custom)

- (void)zs_setBackgroundColor:(UIColor *)backgroundColor;

- (void)zs_setTranslationY:(CGFloat)translationY;

- (void)zs_reset;

@end

NS_ASSUME_NONNULL_END
