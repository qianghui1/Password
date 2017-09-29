//
//  AddAccountViewController.m
//  Password
//
//  Created by 詹强辉 on 2017/9/25.
//  Copyright © 2017年 詹强辉. All rights reserved.
//
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH  [UIScreen mainScreen].bounds.size.height
#import "AddAccountViewController.h"
#import "PhotoViewController.h"

@interface AddAccountViewController ()<UIActionSheetDelegate>

@end

@implementation AddAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self SetUI];

}

-(void)SetUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Add";
    
    [self SetBoundaryView:CGRectMake(0, 0, ScreenW, 20)];       //分界线1
    UIView *accountView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 20, ScreenW, ScreenH/11)];        //图标和标题
    UIImageView *titleImgV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, accountView1.frame.size.height-20, accountView1.frame.size.height-20)];
    titleImgV.image = [UIImage imageNamed:self.accountStr];
    [accountView1 addSubview:titleImgV];
    UILabel *titleStr = [self SetAccountViewUILabel:CGRectMake(titleImgV.frame.size.width+25, 10, accountView1.frame.size.width/2, titleImgV.frame.size.height) TitleText:self.accountStr];
    [accountView1 addSubview:titleStr];
    [self.view addSubview:accountView1];
    [self SetBoundaryView:CGRectMake(0, accountView1.frame.size.height+20, ScreenW, 20)];       //分界线2
    
    UIView *accountView2 = [[UIView alloc]initWithFrame:CGRectMake(0, accountView1.frame.size.height+40, ScreenW, ScreenH/12)]; //提示标题输入
    UITextField *titleTextF = [[UITextField alloc]initWithFrame:CGRectMake(25, 10, accountView2.frame.size.width-50, accountView2.frame.size.height-20)];
    titleTextF.placeholder = @"标题";
    [accountView2 addSubview:titleTextF];
    [self.view addSubview:accountView2];
    [self SetBoundaryView:CGRectMake(0, accountView2.frame.size.height+accountView2.frame.origin.y, ScreenW, 20)];       //分界线3
    
    UIView *accountView3 = [[UIView alloc]initWithFrame:CGRectMake(0, accountView2.frame.size.height+accountView2.frame.origin.y+20, ScreenW, ScreenH/12)]; //账号
    UILabel *accountLab = [self SetAccountViewUILabel:CGRectMake(30, 10, 35, titleImgV.frame.size.height) TitleText:@"账号"];
    [accountView3 addSubview:accountLab];
    [self.view addSubview:accountView3];
    [self SetBoundaryView:CGRectMake(0, accountView3.frame.size.height+accountView3.frame.origin.y, ScreenW, 1)];       //分界线4
    
    UIView *accountView4 = [[UIView alloc]initWithFrame:CGRectMake(0, accountView3.frame.size.height+accountView3.frame.origin.y+1, ScreenW, ScreenH/12)]; //密码
    UILabel *passwordLab = [self SetAccountViewUILabel:CGRectMake(30, 10, 35, titleImgV.frame.size.height) TitleText:@"密码"];
    [accountView4 addSubview:passwordLab];
    [self.view addSubview:accountView4];
    
    [self SetBoundaryView:CGRectMake(0, accountView4.frame.size.height+accountView4.frame.origin.y, ScreenW, 20)];       //分界线5
    UIView *accountView5 = [[UIView alloc]initWithFrame:CGRectMake(0, accountView4.frame.size.height+accountView4.frame.origin.y+20, ScreenW, ScreenH/12)]; //备注
    UILabel *noteLab = [self SetAccountViewUILabel:CGRectMake(30, 10, 35, accountView5.frame.size.height-20) TitleText:@"备注"];
    [accountView5 addSubview:noteLab];
    UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraBtn.frame = CGRectMake(ScreenW-(accountView5.frame.size.height-20)*1.3, 10, accountView5.frame.size.height-20, accountView5.frame.size.height-20);
    [cameraBtn setImage:[UIImage imageNamed:@"相机"] forState:UIControlStateNormal];
    [cameraBtn addTarget:self action:@selector(CameraAction) forControlEvents:UIControlEventTouchUpInside];
    [accountView5 addSubview:cameraBtn];
    [self.view addSubview:accountView5];
    
    [self SetBoundaryView:CGRectMake(0, accountView5.frame.size.height+accountView5.frame.origin.y, ScreenW, 1)];       //分界线6
    UIView *accountView6 = [[UIView alloc]initWithFrame:CGRectMake(0, accountView5.frame.size.height+accountView5.frame.origin.y+1, ScreenW, ScreenH/4)]; //相片
    // 1.创建UIScrollView
    self.imgScrollView = [[UIScrollView alloc] init];
    self.imgScrollView.frame = CGRectMake(0, 0, accountView6.frame.size.width, accountView6.frame.size.height); // frame中的size指UIScrollView的可视范围
    self.imgScrollView.backgroundColor = [UIColor whiteColor];
    [accountView6 addSubview:self.imgScrollView];
    [self.view addSubview:accountView6];
    
}

-(UILabel *)SetAccountViewUILabel:(CGRect)frame TitleText:(NSString *)titleStr
{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = titleStr;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor grayColor];
    label.alpha = 0.5;
    return label;
}

-(void)CameraAction
{
    NSLog(@"点击了相机__LINE:%d__",__LINE__);
    UIAlertController *alertview=[UIAlertController alertControllerWithTitle:@"提示" message:@"选择照片添加到备注中" preferredStyle:UIAlertControllerStyleActionSheet];
    // UIAlertControllerStyleActionSheet 是显示在屏幕底部
    // UIAlertControllerStyleAlert 是显示在中间
    // 设置按钮
    UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *defult = [UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了拍摄");
    }];
    UIAlertAction *PhotoAlbum = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])//图库获取图片
        {
            PhotoViewController *PhotoVC = [[PhotoViewController alloc]init];
            [self.navigationController pushViewController:PhotoVC animated:YES];

        }
        else
        {
            //警告框提示
            //            [Config  showAlertWith:@"信息提示!" andMessage:@"你没有相册"];
            NSLog(@"没有相册");
        }
    }];
    [alertview addAction:cancel];
    [alertview addAction:PhotoAlbum];
    [alertview addAction:defult];
    
    //显示（AppDelegate.h里使用self.window.rootViewController代替self）
    
    [self presentViewController:alertview animated:YES completion:nil];
}

-(void)SetBoundaryView:(CGRect )frame
{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1];
    [self.view addSubview:view];
}

@end
