//
//  MgCollectionViewCell.h
//  Password
//
//  Created by 詹强辉 on 2017/10/8.
//  Copyright © 2017年 詹强辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MgCollectionViewCell : UICollectionViewCell

-(void)SetCell:(UIImage *)cellImg;

/**
 预览略缩图
 */
@property(nonatomic,strong)UIImageView *previewImgV;

@end
