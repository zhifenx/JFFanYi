//
//  NSString+FYIHumpString.h
//  JFFanYi
//
//  Created by 张志峰 on 2017/4/10.
//  Copyright © 2017年 zhifenx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FYIHumpString)

/**
 驼峰字符串转换成普通字符串

 @param string 普通字符串
 @return 驼峰字符串
 */
+ (NSString *)humpStringToCommonString:(NSString *)string;

/**
 普通字符串转换成驼峰字符串转
 
 @param string 驼峰字符串
 @return 普通字符串
 */
+ (NSString *)commonStringToHumpString:(NSString *)string;
@end
