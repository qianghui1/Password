//
//  CameraPhotoViewController.h
//  系统相册多选
//
//  Created by 詹强辉 on 2017/7/24.
//  Copyright © 2017年 詹强辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@class ALAssetsGroup;
typedef void(^PhotoVCHandler)(NSArray *selectedImgsArray);

@interface CameraPhotoViewController : UIViewController

@property(nonatomic,strong)ALAssetsGroup *imgGrap;

@property (nonatomic, copy) PhotoVCHandler photoVCHandler;


@end
