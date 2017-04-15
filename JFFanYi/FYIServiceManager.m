//
//  FYIServiceManager.m
//  JFFanYi
//
//  Created by 张志峰 on 2017/4/8.
//  Copyright © 2017年 zhifenx. All rights reserved.
//

#import "FYIServiceManager.h"
#import <AFNetworking.h>

#define kTimeOutInterval 60

//TODO:在http://fanyi.youdao.com/openapi?path=data-mode申请key和keyfrom
static NSString *keyfrom = @"JFFanYi";
static NSString *key = @"972519001";

@implementation FYIServiceManager

+ (FYIServiceManager *)sharedFYIServiceManager {
    static FYIServiceManager *serviceManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        serviceManager = [[self alloc] init];
    });
    return serviceManager;
}

+ (void)requestDataWihtMethodUrl:(NSString *)url
                     success:(void (^)(id response))success
                     failure:(void (^)(NSError *err))failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = kTimeOutInterval;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //设置相应内容类
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         nil];
    [manager GET:url
      parameters:nil
        progress:^(NSProgress * _Nonnull downloadProgress) {
            
        }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             success(responseObject);
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             failure(error);
         }];
}

- (void)requestDataWithTextString:(NSString *)text
                          data:(void (^)(id response))data {
    NSString *encoded = [text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *url = [NSString stringWithFormat:@"http://fanyi.youdao.com/openapi.do?keyfrom=%@&key=%@&type=data&doctype=json&version=1.1&q=%@",keyfrom,key,encoded];
    [FYIServiceManager requestDataWihtMethodUrl:url
                                        success:^(id response) {
                                            
                                            NSString *result = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
                                            NSLog(@"翻译：%@",result);
                                            NSError *err;
                                            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:response
                                                                                                options:NSJSONReadingMutableContainers
                                                                                                  error:&err];
                                            NSString *translation = [dic valueForKey:@"translation"];
                                            data(translation);
                                        }
                                        failure:^(NSError *err) {
                                            NSLog(@"error :%@",err);
                                        }];
}

@end
