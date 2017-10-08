//
//  DataSource.m
//  Password
//
//  Created by 詹强辉 on 2017/10/8.
//  Copyright © 2017年 詹强辉. All rights reserved.
//

#import "DataSource.h"

@implementation DataSource
static DataSource *dataSource;

+(DataSource *)GetDataSource
{
    if (dataSource ==nil)
    {
        dataSource = [[self alloc]init];
    }
    return dataSource;
}

-(id)init
{
    if (self = [super init])
    {
        self.CameraPhotoMDic = [[NSMutableDictionary alloc]init];
    }
    return self;
}

@end
