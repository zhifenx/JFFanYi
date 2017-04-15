//
//  FYIViewManager.h
//  JFFanYi
//
//  Created by 张志峰 on 2017/4/8.
//  Copyright © 2017年 zhifenx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface FYIViewManager : NSObject

- (instancetype)initViewManagerWithInputScrollView:(NSScrollView *)inputScrllView inputTextView:(NSTextView *)inputTextView outputScrollView:(NSScrollView *)outputScrllView outTextView:(NSTextView *)outputTextView;
@end
