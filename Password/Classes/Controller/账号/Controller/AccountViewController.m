//
//  AccountViewController.m
//  Password
//
//  Created by 詹强辉 on 2017/9/25.
//  Copyright © 2017年 詹强辉. All rights reserved.
//

#import "AccountViewController.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self SetUI];
    
    NSLog(@"%@",self.accountStr);
    
}

-(void)SetUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"账号";
    
}

@end
