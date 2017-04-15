//
//  AppDelegate.m
//  JFFanYi
//
//  Created by 张志峰 on 2017/4/7.
//  Copyright © 2017年 zhifenx. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
//    [NSEvent addGlobalMonitorForEventsMatchingMask:NSLeftMouseDownMask | NSRightMouseDownMask | NSMouseMovedMask | NSLeftMouseDraggedMask | NSRightMouseDraggedMask handler:^(NSEvent * event) {
//        NSInteger delta;
//        switch (event.type) {
//            case NSLeftMouseDownMask:
//                NSLog(@"监听全局鼠标左键点击");
//                break;
//            case NSRightMouseDownMask:
//                NSLog(@"监听全局鼠标右键点击");
//                break;
//            default:
//                NSLog(@"监听全局鼠标事件");
//                break;
//        }
//    }];
    
    NSWindow *fyiWindow = [NSApplication sharedApplication].mainWindow;
    fyiWindow.title = @"JFFanYi";
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag {
    if (!flag){
        for (NSWindow * window in sender.windows) {
            [window makeKeyAndOrderFront:self];
        }
    }
    return YES;
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
