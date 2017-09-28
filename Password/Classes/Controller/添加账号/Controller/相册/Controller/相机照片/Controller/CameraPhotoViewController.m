//
//  CameraPhotoViewController.m
//  系统相册多选
//
//  Created by 詹强辉 on 2017/7/24.
//  Copyright © 2017年 詹强辉. All rights reserved.
//

#import "CameraPhotoViewController.h"
#import "CameraPhotoCollectionViewCell.h"
//#import "PhotoWallViewController.h"

@interface CameraPhotoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,CameraPhotoDelegate>
/*!
 @brief  显示group的所有照片的collectionView
 */
@property (nonatomic, strong) UICollectionView *photosCollectionView;       //展示表格
@property(nonatomic,strong)NSMutableArray *photoMArray;         //本相册的所有照片
@property(nonatomic,strong)NSMutableArray *cameraPhotoMArray;   //已选择的照片数组
@property(nonatomic,strong)UIButton *determineBtn;  //确定选择按钮
@end

@implementation CameraPhotoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"相机照片";
    [self InitData];
    [self SetData];
    [self SetCollectionViewUI];
    [self SetToolBarUI];
}

-(void)InitData
{
    _photoMArray = [[NSMutableArray alloc]init];
    _cameraPhotoMArray = [[NSMutableArray alloc]init];
}

-(void)SetData
{
    [self.imgGrap enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {     // 遍历获取缩略图
        if (result) {
            [_photoMArray insertObject:result atIndex:0];
        }
    }];
}

-(void)SetCollectionViewUI
{
    UICollectionViewFlowLayout *lyout=[[UICollectionViewFlowLayout alloc]init];
    self.photosCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49-64) collectionViewLayout:lyout];
    [self.photosCollectionView registerClass:[CameraPhotoCollectionViewCell class]forCellWithReuseIdentifier:@"CameraPhotoCell"];
    self.photosCollectionView.backgroundColor = [UIColor clearColor];
    self.photosCollectionView.dataSource = self;
    self.photosCollectionView.delegate = self;
    [self.view addSubview:self.photosCollectionView];
}

-(void)SetToolBarUI
{
    UIView *toolBarView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-49-64, self.view.frame.size.width, 49)];
    toolBarView.backgroundColor = [UIColor grayColor];
    toolBarView.alpha = 0.1;
    [self.view addSubview:toolBarView];
    
    self.determineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.determineBtn.frame = CGRectMake(self.view.frame.size.width-120, toolBarView.frame.origin.y+6, 100, 38);
    [self.determineBtn setTitle:@"确定" forState:UIControlStateNormal];
    self.determineBtn.backgroundColor = [UIColor blueColor];
    [self.determineBtn addTarget:self action:@selector(DetermineAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.determineBtn];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _photoMArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CameraPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CameraPhotoCell" forIndexPath:indexPath];
    cell.cameraPhotoDelegate = self;
    ALAsset *assert = _photoMArray[indexPath.row];
    [cell SetCell: [UIImage imageWithCGImage:[assert thumbnail]]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)CameraPhotoCellButton:(UIButton *)sender     //获取勾选按钮
{
    CameraPhotoCollectionViewCell *cell = (CameraPhotoCollectionViewCell *)[sender superview];
    //获取按钮所在的row
    NSIndexPath *indexPath = [_photosCollectionView indexPathForCell:cell];
    NSLog(@"indexPath is = %ld",indexPath.row);
    ALAsset *assert = _photoMArray[indexPath.row];
    [_cameraPhotoMArray addObject:assert];
}

#pragma mark 设置cell大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width/4-3,self.view.frame.size.width/4-3);
}

#pragma mark 设置cell边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //上 左 下 右
    return UIEdgeInsetsMake(0, 0, 0 ,0);
}

#pragma mark 设置cell之间的高度
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0f;
}

-(void)DetermineAction          //确定上次按钮
{
//    //将照片存储到沙盒中
//    if ([[NSFileManager defaultManager] fileExistsAtPath:[self SandboxPath]])//判断createPath路径文件夹是否已存在，此处createPath为需要新建的文件夹的绝对路径
//    {
//        NSLog(@"文件已存在");
//    }
//    else
//    {
//        [[NSFileManager defaultManager] createDirectoryAtPath:[self SandboxPath] withIntermediateDirectories:YES attributes:nil error:nil];//创建文件夹
//        NSLog(@"创建文件");
//    }
    
//    for (int  i =0; i<_cameraPhotoMArray.count; i++)
//    {
//        ALAsset *assert = _cameraPhotoMArray[i];
//        UIImage *image = [UIImage imageWithCGImage:[assert thumbnail]];
//        NSData *imageData = UIImagePNGRepresentation(image);
//        // 可以在上传时使用当前的系统时间作为文件名
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        // 设置时间格式
//        formatter.dateFormat = @"yyyy-MM-dd-HH-mm-ss";
//        NSString *str = [formatter stringFromDate:[NSDate date]];
//        NSString *SandboxPahtStr = [NSString stringWithFormat:@"%@/%@_%d",[self SandboxPath],str,i];
////        [[UserData GetUserData].CameraPhotoMArray addObject:SandboxPahtStr];
//        [imageData writeToFile:SandboxPahtStr atomically:YES];
//    }
    
#warning 将照片传到上个页面中
    
//    PhotoWallViewController *viewCtl = (PhotoWallViewController *)self.navigationController.viewControllers[2];
//    [viewCtl ReloadData];
//    [self.navigationController popToViewController:viewCtl animated:YES];
}

#pragma mark 获取沙盒路径
/**
 *  获取沙盒路径
 *
 *  @return 返回当前文件路径
 */
-(NSString *)SandboxPath
{
    //沙盒路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *path = [NSString stringWithFormat:@"%@/PhotoWall",documentDirectory];
    return path;
}

@end
