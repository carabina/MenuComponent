//
//  MenuTabBarController.m
//  MenuComponent
//
//  Created by LEA on 2017/5/3.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import "MenuTabBarController.h"

@interface MenuTabBarController ()<MenuTabBarDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) MenuTabBar *menuTabBar;
@property (nonatomic,strong) UIScrollView *mainScrollView;


@end

@implementation MenuTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //顶部视图[菜单]
    [self.view addSubview:self.menuTabBar];
    //子控制器视图
    [self.view addSubview:self.mainScrollView];
    [self.subViewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        UIViewController *subVC = (UIViewController *)self.subViewControllers[idx];
        subVC.view.frame = CGRectMake(idx * self.view.width, 0, self.view.width, self.mainScrollView.height);
        subVC.view.tag = idx+100;
        [self.mainScrollView addSubview:subVC.view];
        [self addChildViewController:subVC];
    }];
    self.mainScrollView.scrollEnabled = self.scrollEnabled;
    if (self.tabBarType == MenuTabBarTypeArrow) {
        self.mainScrollView.contentOffset = CGPointMake(self.mainScrollView.width*(self.subViewControllers.count-1), 0);
        self.mainScrollView.scrollEnabled = NO;
    }
}

#pragma mark - 外部接口
- (void)setParentController:(UIViewController *)viewController
{
    [viewController addChildViewController:self];
    [viewController.view addSubview:self.view];
}

- (void)updateData
{
    self.menuTabBar.titleArray = self.titleArray;
    self.menuTabBar.imageArray = self.imageArray;
    [self.menuTabBar updateData];
    
    for (UIViewController *subVC in self.childViewControllers) {
        [subVC removeFromParentViewController];
        [subVC.view removeFromSuperview];
    }
    
    [self.subViewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        UIViewController *subVC = (UIViewController *)self.subViewControllers[idx];
        subVC.view.frame = CGRectMake(idx * self.view.width, 0, self.view.width, self.mainScrollView.height);
        subVC.view.tag = idx+100;
        [self.mainScrollView addSubview:subVC.view];
        [self addChildViewController:subVC];
    }];
    if (self.tabBarType == MenuTabBarTypeArrow) {
        self.mainScrollView.contentOffset = CGPointMake(self.mainScrollView.width*(self.subViewControllers.count-1), 0);
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _currentIndex = scrollView.contentOffset.x / self.mainScrollView.width;
    [self.menuTabBar setCurrentIndex:_currentIndex];
}

#pragma mark - MMSubViewDelegate
- (void)menuTabBar:(MenuTabBar *)menuTabBar didSelectAtIndex:(NSInteger)index
{
    if (self.tabBarType != MenuTabBarTypeArrow) {
        [self.mainScrollView setContentOffset:CGPointMake(self.mainScrollView.width*index, 0) animated:self.scrollAnimation];
    }
    if ([self.delegate respondsToSelector:@selector(tabBarController:didSelectAtIndex:)]) {
        [self.delegate tabBarController:self didSelectAtIndex:index];
    }
}

#pragma mark - getter
- (MenuTabBar *)menuTabBar
{
    if (!_menuTabBar) {
        CGFloat height = self.tabBarHeight;
        if (height == 0) {
            height = kMinMenuHeight;
            if (self.tabBarType == MenuTabBarTypeImage) {
                height = kMaxMenuHeight;
            }
        }
        _menuTabBar = [[MenuTabBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width, height)];
        _menuTabBar.delegate = self;
        _menuTabBar.font = self.font;
        _menuTabBar.subViewType = self.tabBarType;
        _menuTabBar.titleArray = self.titleArray;
        _menuTabBar.imageArray = self.imageArray;
        _menuTabBar.enlargeEnabled = self.enlargeEnabled;
        _menuTabBar.indicatorColor = self.indicatorColor;
        _menuTabBar.currentIndicatorColor = self.currentIndicatorColor;
        _menuTabBar.indicatorLineColor = self.indicatorLineColor;
        [_menuTabBar updateData];
    }
    return _menuTabBar;
}

- (UIScrollView *)mainScrollView
{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.menuTabBar.bottom, self.view.width, self.view.height-self.menuTabBar.bottom)];
        _mainScrollView.backgroundColor = [UIColor clearColor];
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.delegate = self;
        _mainScrollView.contentSize = CGSizeMake(self.view.width*self.subViewControllers.count, _mainScrollView.height);
    }
    return _mainScrollView;
}

#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
