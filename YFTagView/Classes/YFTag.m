//
//  YFTag.h
//  YFTagView
//
//  Created by BigShow1949 on 06/02/2021.
//  Copyright (c) 2021 BigShow1949. All rights reserved.
//

#import "YFTag.h"

static const CGFloat kDefaultFontSize = 13.0;

@interface YFTag ()
@property (nonatomic,strong) UIImage *imageDefault;
@property (nonatomic,strong) UIImage *selectImageDefault;
@end

@implementation YFTag

- (instancetype)init {
    self = [super init];
    if (self) {
        _fontSize = kDefaultFontSize;
        _textColor = [UIColor blackColor];
        _bgColor = [UIColor whiteColor];
        _enable = YES;
        _imageDefault = [self imageWithName:@"tag"];
        _selectImageDefault = [self imageWithName:@"tag_selected"];
    }
    return self;
}

- (instancetype)initWithText: (NSString *)text {
    self = [self init];
    if (self) {
        _text = text;
    }
    return self;
}

+ (instancetype)tagWithText: (NSString *)text {
    return [[self alloc] initWithText: text];
}

- (UIImage *)imageWithName:(NSString *)img {
    NSURL *associateBundleURL = [[NSBundle mainBundle] URLForResource:@"Frameworks" withExtension:nil];
    associateBundleURL = [associateBundleURL URLByAppendingPathComponent:@"YFTagView"];
    associateBundleURL = [associateBundleURL URLByAppendingPathExtension:@"framework"];
    NSBundle *associateBunle = [NSBundle bundleWithURL:associateBundleURL];
    associateBundleURL = [associateBunle URLForResource:@"YFTagView" withExtension:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithURL:associateBundleURL];
    UIImage *image3  = [UIImage imageNamed:img
      inBundle: bundle
    compatibleWithTraitCollection:nil];
    return image3;
}

@end
