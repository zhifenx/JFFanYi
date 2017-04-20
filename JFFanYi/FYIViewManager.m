//
//  FYIViewManager.m
//  JFFanYi
//
//  Created by 张志峰 on 2017/4/8.
//  Copyright © 2017年 zhifenx. All rights reserved.
//

#import "FYIViewManager.h"
#import "FYIServiceManager.h"
#import "NSString+FYIHumpString.h"

@interface FYIViewManager () <NSTextViewDelegate>

@property (nonatomic, strong) NSTextView *inputTextView;
@property (nonatomic, strong) NSTextView *outputTextView;;

@end

@implementation FYIViewManager
{
    NSScrollView *_inputScrollView;
    NSScrollView *_outputScrollView;
    FYIServiceManager *_serviceManager;
    NSPasteboard *_pasteboard;
    NSButton *_switchTranslationModeButton;
    NSButton *_switchCopyModeButton;
}

- (instancetype)initViewManagerWithInputScrollView:(NSScrollView *)inputScrollView
                                     inputTextView:(NSTextView *)inputTextView
                                  outputScrollView:(NSScrollView *)outputScrollView
                                       outTextView:(NSTextView *)outputTextView
                       switchTranslationModeButton:(NSButton *)translationModeButton
                              switchCopyModeButton:(NSButton *)copyModeButton
                                       clearButton:(NSButton *)clearButton {
    if (self = [super init]) {
        _inputScrollView = inputScrollView;
        _outputScrollView = outputScrollView;
        self.inputTextView = inputTextView;
        self.outputTextView = outputTextView;
        _switchCopyModeButton = copyModeButton;
        _switchTranslationModeButton = translationModeButton;

        _inputTextView.delegate = self;
        _outputTextView.delegate = self;

        _outputTextView.editable = NO;
        [_inputTextView setRichText:NO];
        [_inputTextView setFont:[NSFont systemFontOfSize:14]];
        [_inputTextView setTextColor:[NSColor blackColor]];
        
        _pasteboard = [NSPasteboard generalPasteboard];
        
        [clearButton setTarget:self];
        [clearButton setAction:@selector(clearContent:)];
    }
    return self;
}

- (NSTextField *)addTextViewPlaceholderWithString:(NSString *)placeholder textView:(NSTextView *)textView {
     NSTextField *textField = [[NSTextField alloc] initWithFrame:NSMakeRect(15, 0, 220, 40)];
    [textField setEnabled:NO];
    [textField setBordered:NO];
    textField.placeholderString = placeholder;
    [textView addSubview:textField];
    return textField;
}

- (void)removePlaceholder:(NSTextField *)textField {
    [textField removeFromSuperview];
    textField = nil;
}

- (void)textDidChange:(NSNotification *)notification {

    if (notification.object == _inputTextView) {
        _serviceManager = [FYIServiceManager sharedFYIServiceManager];
        NSString *text = [_inputTextView string];
        if (text.length <= 0) {
            return;
        }
        NSString *tempString;
        if (_switchTranslationModeButton.state) {
            //驼峰转普通
            tempString = [NSString humpStringToCommonString:text];
        }else {
            tempString = text;
        }
        __weak typeof(self) weakSelf = self;
        [_serviceManager requestDataWithTextString:tempString
                                              data:^(id response) {
                                                  if (!response) {
                                                      return;
                                                  }
                                                  __strong typeof(self) strongSelf = weakSelf;
                                                  if (strongSelf) {
                                                      
                                                      [strongSelf.outputTextView.textStorage beginEditing];
                                                      NSString *result;
                                                      if (_switchTranslationModeButton.state) {
                                                          result = [NSString commonStringToHumpString:response[0]];
                                                      }else {
                                                          result = response[0];
                                                      }
                                                      NSMutableAttributedString * attrContent = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",result]];
                                                      [strongSelf.outputTextView.textStorage setAttributedString:attrContent];
                                                      [strongSelf.outputTextView.textStorage setFont:[NSFont systemFontOfSize:14]];
                                                      [strongSelf.outputTextView.textStorage setForegroundColor:[NSColor redColor]];
                                                      [strongSelf.outputTextView.textStorage endEditing];
                                                      if (_switchCopyModeButton.state) {
                                                          [strongSelf writeDataToThePasteboardWithString:result];
                                                      }
                                                  }
        }];
    }
}

- (void)writeDataToThePasteboardWithString:(NSString *)data {
    [_pasteboard declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:self];
    [_pasteboard clearContents];
    [_pasteboard setString:data forType:NSStringPboardType];
}

- (void)clearContent:(NSButton *)sender {
    NSMutableAttributedString * attrContent = [[NSMutableAttributedString alloc] initWithString:@""];
    [_inputTextView.textStorage setAttributedString:attrContent];
    [_outputTextView.textStorage setAttributedString:attrContent];
}

@end
