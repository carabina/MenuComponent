//
//  ParentViewController.m
//  MenuComponentDemo
//
//  Created by LEA on 2017/5/3.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import "ParentViewController.h"
#import "MenuTabBarController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "FifthViewController.h"
#import "SixthViewController.h"

@interface ParentViewController ()<MenuTabBarControllerDelegate>

@property (nonatomic,strong) NSArray *baseTitleArray;
@property (nonatomic,strong) NSArray *baseImageArray;
@property (nonatomic,strong) NSArray *baseSubVCArray;

@end

@implementation ParentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"主控制器";
    self.view.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0];
    
    FirstViewController *firstVC = [[FirstViewController alloc] init];
    SecondViewController *seconVC = [[SecondViewController alloc] init];
    ThirdViewController *thirdVC = [[ThirdViewController alloc] init];
    FourthViewController *fourthVC = [[FourthViewController alloc] init];
    FifthViewController *fifthVC = [[FifthViewController alloc] init];
    SixthViewController *sixthVC = [[SixthViewController alloc] init];

    _baseTitleArray = [[NSArray alloc] initWithObjects:@"新朋友",@"群聊",@"公众号",@"好友动态",@"附近",@"兴趣部落", nil];
    _baseImageArray = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"item_0"],[UIImage imageNamed:@"item_1"],[UIImage imageNamed:@"item_2"],[UIImage imageNamed:@"item_3"],[UIImage imageNamed:@"item_4"],[UIImage imageNamed:@"item_5"], nil];
    _baseSubVCArray = [[NSArray alloc] initWithObjects:firstVC,seconVC,thirdVC,fourthVC,fifthVC,sixthVC, nil];
    
    MenuTabBarController *tabBarController = [[MenuTabBarController alloc] init];
    tabBarController.delegate = self;
    tabBarController.scrollEnabled = NO;
    tabBarController.scrollAnimation = NO;
    tabBarController.font = [UIFont systemFontOfSize:15.0];
    tabBarController.indicatorColor = [UIColor blackColor];
    tabBarController.currentIndicatorColor = [UIColor redColor];
    tabBarController.indicatorLineColor = [UIColor redColor];

    switch (self.index)
    {
        case 0: //MenuTabBarTypeNormal
        {
            tabBarController.scrollEnabled = YES;
            tabBarController.enlargeEnabled = YES;
            tabBarController.tabBarType = MenuTabBarTypeNormal;
            tabBarController.titleArray = _baseTitleArray;
            tabBarController.imageArray = _baseImageArray;
            tabBarController.subViewControllers = _baseSubVCArray;
            break;
        }
        case 1: //MenuTabBarTypeNormal
        {
            tabBarController.enlargeEnabled = YES;
            tabBarController.tabBarType = MenuTabBarTypeNormal;
            tabBarController.titleArray = [_baseTitleArray subarrayWithRange:NSMakeRange(0, 3)];
            tabBarController.imageArray = [_baseImageArray subarrayWithRange:NSMakeRange(0, 3)];
            tabBarController.subViewControllers = [_baseSubVCArray subarrayWithRange:NSMakeRange(0, 3)];
            break;
        }
        case 2: //MenuTabBarTypeAverage
        {
            tabBarController.enlargeEnabled = YES;
            tabBarController.tabBarType = MenuTabBarTypeAverage;
            tabBarController.titleArray = [_baseTitleArray subarrayWithRange:NSMakeRange(0, 3)];
            tabBarController.imageArray = [_baseImageArray subarrayWithRange:NSMakeRange(0, 3)];
            tabBarController.subViewControllers = [_baseSubVCArray subarrayWithRange:NSMakeRange(0, 3)];
            break;
        }
        case 3: //MenuTabBarTypeImage
        {
            tabBarController.currentIndicatorColor = [UIColor blackColor];
            tabBarController.tabBarType = MenuTabBarTypeImage;
            tabBarController.titleArray = _baseTitleArray;
            tabBarController.imageArray = _baseImageArray;
            tabBarController.subViewControllers = _baseSubVCArray;
            break;
        }
        case 4: //MenuTabBarTypeImage
        {
            tabBarController.tabBarHeight = 100;
            tabBarController.currentIndicatorColor = [UIColor blackColor];
            tabBarController.tabBarType = MenuTabBarTypeImage;
            tabBarController.titleArray = [_baseTitleArray subarrayWithRange:NSMakeRange(0, 3)];
            tabBarController.imageArray = [_baseImageArray subarrayWithRange:NSMakeRange(0, 3)];
            tabBarController.subViewControllers = [_baseSubVCArray subarrayWithRange:NSMakeRange(0, 3)];
            break;
        }
        case 5: //MenuTabBarTypeArrow
        {
            tabBarController.tabBarType = MenuTabBarTypeArrow;
            tabBarController.titleArray = _baseTitleArray;
            tabBarController.imageArray = _baseImageArray;
            tabBarController.subViewControllers = _baseSubVCArray;
            break;
        }
        default:
            break;
    }
    [tabBarController setParentController:self];
}

#pragma mark - MenuTabBarControllerDelegate
- (void)tabBarController:(MenuTabBarController *)tabBarController didSelectAtIndex:(NSInteger)index
{
    if (tabBarController.tabBarType == MenuTabBarTypeArrow) {
        tabBarController.titleArray = [_baseTitleArray subarrayWithRange:NSMakeRange(0, index+1)];
        tabBarController.imageArray = [_baseImageArray subarrayWithRange:NSMakeRange(0, index+1)];
        tabBarController.subViewControllers = [_baseSubVCArray subarrayWithRange:NSMakeRange(0, index+1)];
        [tabBarController updateData];
    }
}

#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
