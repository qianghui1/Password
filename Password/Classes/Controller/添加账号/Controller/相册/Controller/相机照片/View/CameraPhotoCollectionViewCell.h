//
//  CameraPhotoCollectionViewCell.h
//  系统相册多选
//
//  Created by 詹强辉 on 2017/7/24.
//  Copyright © 2017年 詹强辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CameraPhotoDelegate <NSObject>

-(void)CameraPhotoCellButton:(UIButton *)sender;

@end

@interface CameraPhotoCollectionViewCell : UICollectionViewCell

-(void)SetCell:(UIImage*)img;

@property(nonatomic,assign)id<CameraPhotoDelegate>cameraPhotoDelegate;

@end
