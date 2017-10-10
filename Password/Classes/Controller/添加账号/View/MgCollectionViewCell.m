//
//  MgCollectionViewCell.m
//  Password
//
//  Created by 詹强辉 on 2017/10/8.
//  Copyright © 2017年 詹强辉. All rights reserved.
//

#import "MgCollectionViewCell.h"

@implementation MgCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame])
    {
        [self SetUI];
    }
    return self;
}

-(void)SetUI
{
    self.previewImgV = [[UIImageView alloc]init];
    [self addSubview:self.previewImgV];
}

-(void)SetCell:(UIImage *)cellImg
{
    self.previewImgV.image = cellImg;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.previewImgV.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

@end
