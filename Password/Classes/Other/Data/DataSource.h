//
//  DataSource.h
//  Password
//
//  Created by 詹强辉 on 2017/10/8.
//  Copyright © 2017年 詹强辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSource : NSObject

/**
 已选择的图片字典
 */
@property (nonatomic,strong) NSMutableDictionary *CameraPhotoMDic;


/**
 实例化对象

 @return 返回实例对象
 */
+(DataSource *)GetDataSource;

@end
