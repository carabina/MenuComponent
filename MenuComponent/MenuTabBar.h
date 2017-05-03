//
//  MenuTabBar.h
//  MenuComponent
//
//  Created by LEA on 2017/5/3.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Geometry.h"

//## 枚举
typedef enum {
    MenuTabBarTypeNormal = 0,   //同级：仅有文字，宽度由文字决定
    MenuTabBarTypeAverage,      //同级：仅有文字，宽度均分
    MenuTabBarTypeArrow,        //分级：可逐级点击
    MenuTabBarTypeImage         //同级：图在上文字在下，宽度均分
    
} MenuTabBarType;

@protocol MenuTabBarDelegate;
@interface MenuTabBar : UIView

//代理
@property (nonatomic,assign) id<MenuTabBarDelegate> delegate;
//类型
@property (nonatomic,assign) MenuTabBarType tabBarType;
//点击切换文字是否变大
@property (nonatomic,assign) BOOL enlargeEnabled;
//字体
@property (nonatomic,strong) UIFont *font;
//标签颜色
@property (nonatomic,strong) UIColor *indicatorColor;
//被选中标签的颜色
@property (nonatomic,strong) UIColor *currentIndicatorColor;
//标示线颜色
@property (nonatomic,strong) UIColor *indicatorLineColor;
//文字数组
@property (nonatomic,strong) NSArray *titleArray;
//图片名称数组
@property (nonatomic,strong) NSArray *imageNameArray;
//当前选择的Index
@property (nonatomic,assign) NSInteger currentIndex;

//### 外部接口

//更新
- (void)updateData;

@end

@protocol MenuTabBarDelegate <NSObject>

@optional
//选取某个标签
- (void)menuTabBar:(MenuTabBar *)menuTabBar didSelectAtIndex:(NSInteger)index;

@end
