//
//  SixthViewController.m
//  MenuComponentDemo
//
//  Created by LEA on 2017/5/3.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import "SixthViewController.h"

@interface SixthViewController ()

@end

@implementation SixthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 400)];
    lab.text = @"No.6";
    lab.textColor = [UIColor blackColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont boldSystemFontOfSize:25.0];
    [self.view addSubview:lab];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
