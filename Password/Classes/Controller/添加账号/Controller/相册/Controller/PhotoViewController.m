//
//  PhotoViewController.m
//  系统相册多选
//
//  Created by 詹强辉 on 2017/7/24.
//  Copyright © 2017年 詹强辉. All rights reserved.
//

#import "PhotoViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "CameraPhotoViewController.h"

@interface PhotoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *photoMArray;
@property (nonatomic, strong) ALAssetsLibrary *assetslibrary;
@property(nonatomic,strong)UITableView *photoTableView;

@end

@implementation PhotoViewController

- (NSMutableArray *)photoMArray
{
    if (!_photoMArray)
    {
        _photoMArray = [NSMutableArray array];
    }
    return _photoMArray;
}
- (ALAssetsLibrary *)assetslibrary
{
    if (!_assetslibrary)
    {
        _assetslibrary = [[ALAssetsLibrary alloc] init];
    }
    return _assetslibrary;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置导航栏背景图
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航栏.png"]  forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"相册";
    
    _photoMArray = [NSMutableArray new];
    
    [self GetAssetsGroupData];  //获取系统相册
    
    self.photoTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.photoTableView.delegate = self;
    self.photoTableView.dataSource = self;
    [self.view addSubview:self.photoTableView];
    
}


/**
 获取相册名数组
 */
- (void)GetAssetsGroupData {
    __weak typeof(self) weakSelf = self;

    [self.assetslibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop)
     {
         if (group)
         {
             [weakSelf.photoMArray insertObject:group atIndex:0];
             NSLog(@"%@", [group valueForProperty:ALAssetsGroupPropertyName]);
         }
     } failureBlock:^(NSError *error) {
         NSLog(@"获取相簿失败%@", error);
     }];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int)(0.1 * (double)NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
        [_photoTableView reloadData];
    });
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _photoMArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"photoCell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"photoCell"];
    }
    ALAssetsGroup *group = _photoMArray[indexPath.row];
    cell.imageView.image = [UIImage imageWithCGImage:[group posterImage]];
    cell.textLabel.text = [group valueForProperty:ALAssetsGroupPropertyName];
//    cell.text = [NSString stringWithFormat:@"%zd", [group numberOfAssets]];   //相册照片数
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ALAssetsGroup *group = _photoMArray[indexPath.row];
    
    CameraPhotoViewController *cameraPhotoVC = [[CameraPhotoViewController alloc]init];
    cameraPhotoVC.imgGrap = group;
    cameraPhotoVC.photoVCHandler = ^(NSArray *selectedImgsArray) {
        NSLog(@"%@------", selectedImgsArray);
    };
    [self.navigationController pushViewController:cameraPhotoVC animated:YES];
}


@end
