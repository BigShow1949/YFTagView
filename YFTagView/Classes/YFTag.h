//
//  YFTag.h
//  YFTagView
//
//  Created by BigShow1949 on 06/02/2021.
//  Copyright (c) 2021 BigShow1949. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define YFTagDefaultImage
typedef NS_ENUM(NSInteger, YFTagStyle) {
    YFTagStyleText = 0,     // 默认状态：文字 可加图片
    YFTagStyleDelete,       // 删除状态：右上角有个×图片（还没有做）
    YFTagStyleDeleteShake,  // 抖动删除：删除状态的前提抖动起来（还没有做）
};


@interface YFTag : NSObject

@property (nonatomic,strong,nullable,readonly) UIImage *imageDefault;
@property (nonatomic,strong,nullable,readonly) UIImage *selectImageDefault;

@property (nonatomic,strong,nullable) UIImage *image;
@property (nonatomic,strong,nullable) UIImage *selectImage;

@property (copy, nonatomic, nullable) NSString *text;
@property (copy, nonatomic, nullable) NSAttributedString *attributedText;
@property (strong, nonatomic, nullable) UIColor *textColor;
@property (strong, nonatomic, nullable) UIColor *selectTextColor;

///backgound color
@property (strong, nonatomic, nullable) UIColor *bgColor;
@property (strong, nonatomic, nullable) UIColor *highlightedBgColor;
@property (strong, nonatomic, nullable) UIColor *selectBgColor;

///background image
@property (strong, nonatomic, nullable) UIImage *bgImg;
@property (assign, nonatomic) CGFloat cornerRadius;
@property (strong, nonatomic, nullable) UIColor *borderColor;
@property (strong, nonatomic, nullable) UIColor *selectborderColor;
@property (assign, nonatomic) CGFloat borderWidth;

///like padding in css
@property (assign, nonatomic) UIEdgeInsets edgeInsets;
@property (strong, nonatomic, nullable) UIFont *font;
///if no font is specified, system font with fontSize is used
@property (assign, nonatomic) CGFloat fontSize;
///default:YES
@property (assign, nonatomic) BOOL enable;
//是否选中
@property (assign, nonatomic) BOOL isSelect;

- (nonnull instancetype)initWithText: (nonnull NSString *)text;
+ (nonnull instancetype)tagWithText: (nonnull NSString *)text;

@end
