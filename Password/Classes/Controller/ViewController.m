//
//  ViewController.m
//  Password
//
//  Created by 詹强辉 on 2017/9/24.
//  Copyright © 2017年 詹强辉. All rights reserved.
//

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH  [UIScreen mainScreen].bounds.size.height
#import "ViewController.h"
#import "ViewControllerTableViewCell.h"
#import "AccountViewController.h"
#import "AddAccountViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray *accountArray;

@property(nonatomic,strong)UITableView *accountTableView;          //列表

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self InitData];
    
//    [self TouchID];
    
    [self SetUI];
    
}

-(void)InitData
{
    _accountArray = [NSArray arrayWithObjects:@"其他账户",@"游戏账户",@"网站论坛",@"银行账户",@"电子邮箱",@"聊天账号",@"私密记事", nil];
}

-(void)SetUI
{
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];      //改变属性栏颜色
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault]; //隐藏返回按钮文字
    self.view.backgroundColor = [UIColor whiteColor];           //背景色
    self.title = @"Passwords";
    
    [self SetTableViewUI];
    
}
-(void)SetTableViewUI
{
    self.accountTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStylePlain];
    self.accountTableView.dataSource = self;
    self.accountTableView.delegate = self;
    self.accountTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.accountTableView];
}

-(void)TouchID          //指纹识别
{
    // Do any additional setup after loading the view, typically from a nib.
    //创建LAContext
    LAContext *context = [LAContext new];
    
    //这个属性是设置指纹输入失败之后的弹出框的选项
    context.localizedFallbackTitle = @"没有忘记密码";
    
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error])
    {
        NSLog(@"支持指纹识别");
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"请按home键指纹解锁" reply:^(BOOL success, NSError * _Nullable error)
        {
            if (success)
            {
                NSLog(@"验证成功 刷新主界面");
            }
            else
            {
                NSLog(@"%@",error.localizedDescription);
                switch (error.code)
                {
                    case LAErrorSystemCancel:
                    {
                        NSLog(@"系统取消授权，如其他APP切入");
                        break;
                    }
                    case LAErrorUserCancel:
                    {
                        NSLog(@"用户取消验证Touch ID");
                        break;
                    }
                    case LAErrorAuthenticationFailed:
                    {
                        NSLog(@"授权失败");
                        break;
                    }
                    case LAErrorPasscodeNotSet:
                    {
                        NSLog(@"系统未设置密码");
                        break;
                    }
                    case LAErrorTouchIDNotAvailable:
                    {
                        NSLog(@"设备Touch ID不可用，例如未打开");
                        break;
                    }
                    case LAErrorTouchIDNotEnrolled:
                    {
                        NSLog(@"设备Touch ID不可用，用户未录入");
                        break;
                    }
                    case LAErrorUserFallback:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"用户选择输入密码，切换主线程处理");
                        }];
                        break;
                    }
                    default:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"其他情况，切换主线程处理");
                        }];
                        break;
                    }
                }
            }
        }];
    }
    else
    {
        NSLog(@"不支持指纹识别");
        switch (error.code)
        {
            case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"TouchID is not enrolled");
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                NSLog(@"A passcode has not been set");
                break;
            }
            default:
            {
                NSLog(@"TouchID not available");
                break;
            }
        }
        
        NSLog(@"%@",error.localizedDescription);
    }
}
- (void)evaluateAuthenticate
{
    //创建LAContext
    LAContext* context = [[LAContext alloc] init];
    NSError* error = nil;
    NSString* result = @"请验证已有指纹";
    
    //首先使用canEvaluatePolicy 判断设备支持状态
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error])
    {
        //支持指纹验证
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError *error)
        {
            if (success)
            {
                //验证成功，主线程处理UI
            }
            else
            {
                NSLog(@"%@",error.localizedDescription);
                switch (error.code) {
                    case LAErrorSystemCancel:
                    {
                        //系统取消授权，如其他APP切入
                        break;
                    }
                    case LAErrorUserCancel:
                    {
                        //用户取消验证Touch ID
                        break;
                    }
                    case LAErrorAuthenticationFailed:
                    {
                        //授权失败
                        break;
                    }
                    case LAErrorPasscodeNotSet:
                    {
                        //系统未设置密码
                        break;
                    }
                    case LAErrorTouchIDNotAvailable:
                    {
                        //设备Touch ID不可用，例如未打开
                        break;
                    }
                    case LAErrorTouchIDNotEnrolled:
                    {
                        //设备Touch ID不可用，用户未录入
                        break;
                    }
                    case LAErrorUserFallback:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //用户选择输入密码，切换主线程处理
                            
                        }];
                        break;
                    }
                    default:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            //其他情况，切换主线程处理
                        }];
                        break;
                    }
                }
            }
        }];
    }
    else
    {
        //不支持指纹识别，LOG出错误详情
        NSLog(@"不支持指纹识别");
        
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"TouchID is not enrolled");
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                NSLog(@"A passcode has not been set");
                break;
            }
            default:
            {
                NSLog(@"TouchID not available");
                break;
            }
        }
        
        NSLog(@"%@",error.localizedDescription);
    }
}

#pragma mark - Delegate
#pragma mark TableViewDeleagte
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewControllerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell = [[ViewControllerTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.titleImg.image = [UIImage imageNamed:_accountArray[indexPath.row]];
    cell.titleLab.text = _accountArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *accountDic = [[NSDictionary alloc]initWithDictionary:[defaults objectForKey:@"accountDic"]];
    NSArray *accountArray = [[NSArray alloc]initWithArray:accountDic[_accountArray[indexPath.row]]];
    cell.accountNumber.text = [NSString stringWithFormat:@"%lu",(unsigned long)accountArray.count];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScreenH/11;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *accountDic = [[NSDictionary alloc]initWithDictionary:[defaults objectForKey:@"accountDic"]];
    NSArray *accountArray = [[NSArray alloc]initWithArray:accountDic[_accountArray[indexPath.row]]];
    
    if (accountArray.count == 0)    //如果没有数据,进入创建页面
    {
        AddAccountViewController *addAccountVC = [[AddAccountViewController alloc]init];
        addAccountVC.accountStr = _accountArray[indexPath.row];
        [self.navigationController pushViewController:addAccountVC animated:YES];
    }
    else
    {
        AccountViewController *accountVC = [[AccountViewController alloc]init];
        accountVC.accountStr = _accountArray[indexPath.row];
        [self.navigationController pushViewController:accountVC animated:YES];
    }
    
}

@end
