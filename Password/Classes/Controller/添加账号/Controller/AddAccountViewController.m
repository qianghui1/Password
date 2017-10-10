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
#import "DataSource.h"
#import "MgCollectionViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface AddAccountViewController ()<UIActionSheetDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)UICollectionView *mgCollectionView;

@end

@implementation AddAccountViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSLog(@"运行一次");
    DataSource *dataSource = [DataSource GetDataSource];
    if (dataSource.CameraPhotoMArray.count != 0)
    {
        if (self.mgCollectionView != nil)
        {
            [self.mgCollectionView reloadData];
        }
    }
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self SetUI];
}

-(void)SetUI
{
    self.view.backgroundColor = [UIColor colorWithRed:246.0/255.0 green:246.0/255.0 blue:246.0/255.0 alpha:1];;
    self.title = @"Add";
    
    [self SetBoundaryView:CGRectMake(0, 0, ScreenW, 20)];       //分界线1
    UIView *accountView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 20, ScreenW, ScreenH/11)];        //图标和标题
    accountView1.backgroundColor = [UIColor whiteColor];
    UIImageView *titleImgV = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, accountView1.frame.size.height-20, accountView1.frame.size.height-20)];
    titleImgV.image = [UIImage imageNamed:self.accountStr];
    [accountView1 addSubview:titleImgV];
    UILabel *titleStr = [self SetAccountViewUILabel:CGRectMake(titleImgV.frame.size.width+25, 10, accountView1.frame.size.width/2, titleImgV.frame.size.height) TitleText:self.accountStr];
    [accountView1 addSubview:titleStr];
    [self.view addSubview:accountView1];
    [self SetBoundaryView:CGRectMake(0, accountView1.frame.size.height+20, ScreenW, 20)];       //分界线2
    
    UIView *accountView2 = [[UIView alloc]initWithFrame:CGRectMake(0, accountView1.frame.size.height+40, ScreenW, ScreenH/12)]; //提示标题输入
    accountView2.backgroundColor = [UIColor whiteColor];
    UITextField *titleTextF = [[UITextField alloc]initWithFrame:CGRectMake(25, 10, accountView2.frame.size.width-50, accountView2.frame.size.height-20)];
    titleTextF.placeholder = @"标题";
    [accountView2 addSubview:titleTextF];
    [self.view addSubview:accountView2];
    [self SetBoundaryView:CGRectMake(0, accountView2.frame.size.height+accountView2.frame.origin.y, ScreenW, 20)];       //分界线3
    
    UIView *accountView3 = [[UIView alloc]initWithFrame:CGRectMake(0, accountView2.frame.size.height+accountView2.frame.origin.y+20, ScreenW, ScreenH/12)]; //账号
    accountView3.backgroundColor = [UIColor whiteColor];
    UILabel *accountLab = [self SetAccountViewUILabel:CGRectMake(30, 10, 35, titleImgV.frame.size.height) TitleText:@"账号"];
    [accountView3 addSubview:accountLab];
    [self.view addSubview:accountView3];
    [self SetBoundaryView:CGRectMake(0, accountView3.frame.size.height+accountView3.frame.origin.y, ScreenW, 1)];       //分界线4
    
    UIView *accountView4 = [[UIView alloc]initWithFrame:CGRectMake(0, accountView3.frame.size.height+accountView3.frame.origin.y+1, ScreenW, ScreenH/12)]; //密码
    accountView4.backgroundColor = [UIColor whiteColor];
    UILabel *passwordLab = [self SetAccountViewUILabel:CGRectMake(30, 10, 35, titleImgV.frame.size.height) TitleText:@"密码"];
    [accountView4 addSubview:passwordLab];
    [self.view addSubview:accountView4];
    
    [self SetBoundaryView:CGRectMake(0, accountView4.frame.size.height+accountView4.frame.origin.y, ScreenW, 20)];       //分界线5
    UIView *accountView5 = [[UIView alloc]initWithFrame:CGRectMake(0, accountView4.frame.size.height+accountView4.frame.origin.y+20, ScreenW, ScreenH/12)]; //备注
    accountView5.backgroundColor = [UIColor whiteColor];
    UILabel *noteLab = [self SetAccountViewUILabel:CGRectMake(30, 10, 35, accountView5.frame.size.height-20) TitleText:@"备注"];
    [accountView5 addSubview:noteLab];
    UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraBtn.frame = CGRectMake(ScreenW-(accountView5.frame.size.height-20)*1.3, 10, accountView5.frame.size.height-20, accountView5.frame.size.height-20);
    [cameraBtn setImage:[UIImage imageNamed:@"相机"] forState:UIControlStateNormal];
    [cameraBtn addTarget:self action:@selector(CameraAction) forControlEvents:UIControlEventTouchUpInside];
    [accountView5 addSubview:cameraBtn];
    [self.view addSubview:accountView5];
    
    [self SetBoundaryView:CGRectMake(0, accountView5.frame.size.height+accountView5.frame.origin.y, ScreenW, 1)];       //分界线6
    UIView *accountView6 = [[UIView alloc]initWithFrame:CGRectMake(0, accountView5.frame.size.height+accountView5.frame.origin.y+1, ScreenW, ScreenW/3)]; //相片
    accountView6.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *lyout=[[UICollectionViewFlowLayout alloc]init];
    self.mgCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, (ScreenW/3-ScreenW/3.5)/2, accountView6.frame.size.width, accountView6.frame.size.height) collectionViewLayout:lyout];
    [self.mgCollectionView registerClass:[MgCollectionViewCell class]forCellWithReuseIdentifier:@"mgCollectionViewCell"];
    self.mgCollectionView.backgroundColor = [UIColor whiteColor];
    self.mgCollectionView.dataSource = self;
    self.mgCollectionView.delegate = self;
    [accountView6 addSubview:self.mgCollectionView];
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

#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    DataSource *dataSource = [DataSource GetDataSource];
    return dataSource.CameraPhotoMArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MgCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mgCollectionViewCell" forIndexPath:indexPath];
    DataSource *dataSource = [DataSource GetDataSource];
    [cell SetCell:dataSource.CameraPhotoMArray[indexPath.row][0]];
    return cell;
}
// 设置cell大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.width/3.5,collectionView.frame.size.width/3.5);
}

// 设置cell边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //上 左 下 右
    return UIEdgeInsetsMake(0, 10, 0 ,10);
}
@end
