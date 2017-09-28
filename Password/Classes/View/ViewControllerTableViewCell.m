//
//  ViewControllerTableViewCell.m
//  Password
//
//  Created by 詹强辉 on 2017/9/24.
//  Copyright © 2017年 詹强辉. All rights reserved.
//

#import "ViewControllerTableViewCell.h"

@implementation ViewControllerTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self SetUI];
    }
    return self;
}

-(void)SetUI
{
    self.titleImg = [[UIImageView alloc]init];
    [self addSubview:self.titleImg];
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.titleLab];
    self.accountNumber = [[UILabel alloc]init];
    self.accountNumber.font = [UIFont systemFontOfSize:15];
    self.accountNumber.textColor = [UIColor grayColor];
    self.accountNumber.alpha = 0.5;
    [self addSubview:self.accountNumber];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleImg.frame = CGRectMake(10, 10, self.frame.size.height-20, self.frame.size.height-20);
    self.titleLab.frame = CGRectMake(25+self.titleImg.frame.size.width, 10, self.frame.size.width/2, self.titleImg.frame.size.height);
    self.accountNumber.frame = CGRectMake(self.frame.size.width-40, 10, 20, self.titleImg.frame.size.height);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
