//
//  CameraPhotoCollectionViewCell.m
//  系统相册多选
//
//  Created by 詹强辉 on 2017/7/24.
//  Copyright © 2017年 詹强辉. All rights reserved.
//

#import "CameraPhotoCollectionViewCell.h"

@interface CameraPhotoCollectionViewCell()
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UIButton *checkBtn;
@end

@implementation CameraPhotoCollectionViewCell

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
    _imgV = [[UIImageView alloc]init];
    [self addSubview:_imgV];
    
    _checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_checkBtn setBackgroundImage:[UIImage imageNamed:@"check_button_normal"] forState:UIControlStateNormal];
    [_checkBtn setBackgroundImage:[UIImage imageNamed:@"check_button_selected"] forState:UIControlStateSelected];
    [_checkBtn addTarget:self action:@selector(CheckAction:) forControlEvents:UIControlEventTouchUpInside];
    _checkBtn.selected = NO;
    [self addSubview:_checkBtn];
}

-(void)SetCell:(UIImage*)img
{
    _imgV.image = img;
}

-(void)CheckAction:(UIButton*)sender
{
    if (sender.selected == YES)
    {
        sender.selected = NO;
    }
    else
    {
        sender.selected = YES;
        //存储照片
        [self.cameraPhotoDelegate CameraPhotoCellButton:sender];
    }
}

-(void)layoutSubviews
{
    _imgV.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _checkBtn.frame = CGRectMake(self.frame.size.width-30, 2, 28, 28);
}

@end
