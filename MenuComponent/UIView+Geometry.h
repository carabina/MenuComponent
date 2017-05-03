//
//  UIView+Geometry.h
//  MenuComponent
//
//  Created by LEA on 2017/5/3.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import <UIKit/UIKit.h>

//## 宏定义
//屏幕宽度
#define kWidth      [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define kHeight     [UIScreen mainScreen].bounds.size.height
//iPhone4
#define kIphone4    CGSizeEqualToSize(CGSizeMake(640,960),[[[UIScreen mainScreen] currentMode] size])
//iPhone5
#define kIphone5    CGSizeEqualToSize(CGSizeMake(640,1136),[[[UIScreen mainScreen] currentMode] size])
//iPhone6
#define kIphone6    CGSizeEqualToSize(CGSizeMake(750,1334),[[[UIScreen mainScreen] currentMode] size])
//iPhone6p
#define kIphone6P   CGSizeEqualToSize(CGSizeMake(1242,2208),[[[UIScreen mainScreen] currentMode] size])


@interface UIView (Geometry)

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;


@end
