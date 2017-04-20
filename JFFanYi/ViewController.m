//
//  ViewController.m
//  JFFanYi
//
//  Created by 张志峰 on 2017/4/7.
//  Copyright © 2017年 zhifenx. All rights reserved.
//

#import "ViewController.h"
#import "FYIViewManager.h"

@interface ViewController ()

@property (strong) IBOutlet NSScrollView *inputContentScrollView;
@property (strong) IBOutlet NSTextView *inputTextView;
@property (strong) IBOutlet NSScrollView *outputContentScrollView;
@property (strong) IBOutlet NSTextView *outputTextView;
@property (strong) IBOutlet NSButton *switchTranslationModeButton;
@property (strong) IBOutlet NSButton *switchCopyModeButton;
@property (strong) IBOutlet NSButton *clearButton;

@end

@implementation ViewController
{
    FYIViewManager *_viewManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _viewManager = [[FYIViewManager alloc] initViewManagerWithInputScrollView:self.inputContentScrollView
                                                                inputTextView:self.inputTextView
                                                             outputScrollView:self.outputContentScrollView
                                                                  outTextView:self.outputTextView
                                                  switchTranslationModeButton:self.switchTranslationModeButton
                                                         switchCopyModeButton:self.switchCopyModeButton
                                                                  clearButton:self.clearButton];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void)dealloc {
    NSLog(@"ViewController dealloc");
}
@end
