//
//  MenuTabBar.m
//  MenuComponent
//
//  Created by LEA on 2017/5/3.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import "MenuTabBar.h"

//## 宏定义
//iPhone6p
#define kIphone6P   CGSizeEqualToSize(CGSizeMake(1242,2208),[[[UIScreen mainScreen] currentMode] size])

@interface MenuTabBar ()

//滚动视图
@property (nonatomic,strong) UIScrollView *mainScrollView;
//标示线
@property (nonatomic,strong) UIView *indicatorLine;
//前一个Index
@property (nonatomic,assign) NSInteger preIndex;
//变大后的字体
@property (nonatomic,strong) UIFont *largeFont;

@end

@implementation MenuTabBar

//初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.mainScrollView];
    }
    return self;
}

//更新数据
- (void)updateData
{
    //## 移除所有子视图
    for (UIView *V in self.mainScrollView.subviews) {
        [V removeFromSuperview];
    }
    
    //## 初始化默认值
    _preIndex = 0;
    _currentIndex = 0;
    _largeFont = self.font;
    if (!self.indicatorColor) {
        self.indicatorColor = [UIColor blackColor];
    }
    if (!self.currentIndicatorColor) {
        self.currentIndicatorColor = [UIColor redColor];
    }
    if (!self.indicatorLineColor) {
        self.indicatorLineColor = [UIColor redColor];
    }
    if (!self.font) {
        self.font = [UIFont systemFontOfSize:16.0];
    }
    if (self.enlargeEnabled) {
        _largeFont = [UIFont fontWithName:self.font.fontName size:self.font.pointSize+2];
    }
    
    //## 重新添加视图
    NSString *title = nil;
    UIButton *itemBtn = nil;
    
    CGFloat X = 0;
    CGFloat titleWidth = 0;
    CGFloat itemWidth = 0;
    CGFloat itemHeight = self.mainScrollView.height;
    CGFloat mainWidth = self.mainScrollView.width;
    NSInteger count = self.titleArray.count;
    for (NSInteger i = 0; i < count; i ++ )
    {
        title = [self.titleArray objectAtIndex:i];
        titleWidth = [title sizeWithAttributes:@{NSFontAttributeName:self.font}].width;
        
        itemBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        itemBtn.tag = 100+i;
        itemBtn.titleLabel.font = self.font;
        itemBtn.backgroundColor = [UIColor clearColor];
        itemBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [itemBtn setTitle:title forState:UIControlStateNormal];
        [itemBtn setTitleColor:self.indicatorColor forState:UIControlStateNormal];
        [itemBtn addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainScrollView addSubview:itemBtn];
        
        [itemBtn setTitleColor:self.indicatorColor forState:UIControlStateNormal];
        if (i == 0) {
            itemBtn.titleLabel.font = _largeFont;
            [itemBtn setTitleColor:self.currentIndicatorColor forState:UIControlStateNormal];
        }
        
        //## 分类处理
        switch (self.tabBarType)
        {
            case MenuTabBarTypeNormal:
            {
                itemWidth = titleWidth+40;
                break;
            }
            case MenuTabBarTypeAverage:
            {
                itemWidth = mainWidth/count;
                break;
            }
            case MenuTabBarTypeArrow:
            {
                itemWidth = titleWidth+20;
                itemBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [itemBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
                [itemBtn setTitleColor:self.indicatorColor forState:UIControlStateNormal];
                if (i == count-1) {
                    [itemBtn setTitleColor:self.currentIndicatorColor forState:UIControlStateNormal];
                } else {
                    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.arrowImageName]];
                    imageView.origin = CGPointMake(itemWidth-imageView.width, (itemHeight-imageView.height)/2);
                    [itemBtn addSubview:imageView];
                }
                break;
            }
            case MenuTabBarTypeImage:
            {
                NSInteger maxCount = kIphone6P?4:3;
                if (count <= maxCount) {
                    itemWidth = mainWidth/count;
                } else {
                    itemWidth = mainWidth/maxCount;
                }
                
                UIImage *image = [UIImage imageNamed:[self.imageNameArray objectAtIndex:i]];
                CGFloat imageWidth = image.size.width;
                CGFloat imageHeight = image.size.height;
                
                CGFloat top = (itemHeight-imageHeight-30)/2+5;
                CGFloat left = (itemWidth-imageWidth)/2;
                
                itemBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [itemBtn setImage:image forState:UIControlStateNormal];
                [itemBtn setImageEdgeInsets:UIEdgeInsetsMake(top, left, itemHeight-imageHeight-top, left)];
                [itemBtn setTitleEdgeInsets:UIEdgeInsetsMake(top+imageHeight, left-(imageWidth+titleWidth)/2, itemHeight-(top+imageHeight+30), 0)];
                break;
            }
            default:
                break;
        }
        
        itemBtn.frame = CGRectMake(X, 0, itemWidth, itemHeight);
        X += itemWidth;
    }
    
    //## 添加标示线
    if (self.tabBarType != MenuTabBarTypeArrow) {
        self.indicatorLine.backgroundColor = self.indicatorLineColor;
        [self.mainScrollView addSubview:self.indicatorLine];
        
        UIButton *sender = [self.mainScrollView viewWithTag:100];
        self.indicatorLine.left = sender.left;
        self.indicatorLine.width = sender.width;
    }
    //## 底部边线
    if (self.tabBarType == MenuTabBarTypeImage) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, self.height-0.5, self.width, 0.5);
        layer.backgroundColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.5] CGColor];
        [self.layer addSublayer:layer];
    }
    //## 更新contentSize
    self.mainScrollView.contentSize = CGSizeMake(itemBtn.right, self.mainScrollView.height);
}

#pragma mark - 点击事件
- (void)itemPressed:(UIButton *)sender
{
    _currentIndex = sender.tag-100;
    if ([self.delegate respondsToSelector:@selector(menuTabBar:didSelectAtIndex:)]) {
        [self.delegate menuTabBar:self didSelectAtIndex:_currentIndex];
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    UIButton *sender = [self.mainScrollView viewWithTag:100+_currentIndex];
    if (sender.right > self.width) {
        CGFloat offsetX = sender.right - self.width;
        if (currentIndex < [_titleArray count] - 1) {
            offsetX = offsetX + 40.0f;
        }
        [self.mainScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    } else {
        [self.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    
    if (self.tabBarType != MenuTabBarTypeArrow) {
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.indicatorLine.left = sender.left;
                             self.indicatorLine.width = sender.width;
                             UIButton *repBtn = [self.mainScrollView viewWithTag:100+_preIndex];
                             repBtn.titleLabel.font = self.font;
                             [repBtn setTitleColor:self.indicatorColor forState:UIControlStateNormal];
                             
                             sender.titleLabel.font = _largeFont;
                             [sender setTitleColor:self.currentIndicatorColor forState:UIControlStateNormal];
                         }];
    }
    _preIndex = currentIndex;
}

#pragma mark - getter
- (UIScrollView *)mainScrollView
{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _mainScrollView.backgroundColor = [UIColor clearColor];
        _mainScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _mainScrollView;
}

- (UIView *)indicatorLine
{
    if (!_indicatorLine) {
        _indicatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.mainScrollView.height-2, 0, 2)];
    }
    return _indicatorLine;
}

@end
