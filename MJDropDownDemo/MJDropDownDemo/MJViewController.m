//
//  MJViewController.m
//  MJDropDownDemo
//
//  Created by Matěj Kašpar Jirásek on 01/02/14.
//  Copyright (c) 2014 Matěj Kašpar Jirásek. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "MJViewController.h"
#import "MJDropDown.h"

@interface MJViewController ()

@end

@implementation MJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadBasicDropDown];
	// Do any additional setup after loading the view.
}

- (void)loadBasicDropDown
{
    UIButton *firstButton = [[UIButton alloc] init];
    [firstButton setTitle:@"S" forState:UIControlStateNormal];
    UIButton *secondButton = [[UIButton alloc] init];
    [secondButton setTitle:@"M" forState:UIControlStateNormal];
    UIButton *thirdButton = [[UIButton alloc] init];
    [thirdButton setTitle:@"L" forState:UIControlStateNormal];
    
    
    MJDropDown *dropDown = [[MJDropDown alloc] initWithFrame:CGRectMake(40.0, 40.0, 40.0, 40.0)];
    dropDown.buttons = @[firstButton, secondButton, thirdButton];
    dropDown.closedBackgroundColor = [UIColor redColor];
    dropDown.animationTime = 0.3;
    dropDown.layer.cornerRadius = 6.0;
    
    [dropDown shut];
    
    [self.view addSubview:dropDown];
}

@end
