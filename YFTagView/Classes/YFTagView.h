//
//  YFTagView.h
//  YFTagView
//
//  Created by BigShow1949 on 06/02/2021.
//  Copyright (c) 2021 BigShow1949. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFTag.h"

typedef NS_ENUM(NSInteger, YFTagViewSelectStyle) {
    YFTagViewSelectStyleNone = 0,  // 不可选 默认
    YFTagViewSelectStyleOne,       // 单选
    YFTagViewSelectStyleMore       // 多选
};

@interface YFTagView : UIView

@property (nonatomic, assign) YFTagViewSelectStyle tagViewStyle;//是否可以进行多选


@property (assign, nonatomic) UIEdgeInsets edgeInsets;
@property (assign, nonatomic) CGFloat lineSpacing;
@property (assign, nonatomic) CGFloat interitemSpacing;
@property (assign, nonatomic) CGFloat preferredMaxLayoutWidth;
@property (assign, nonatomic) CGFloat regularWidth; //!< 固定宽度
@property (nonatomic, assign) CGFloat regularHeight; //!< 固定高度
@property (assign, nonatomic) BOOL singleLine;
@property (copy, nonatomic, nullable) void (^didTapTagAtIndex)(NSUInteger index , UIButton * _Nonnull bnt);

- (void)addTag: (nonnull YFTag *)tag;
- (void)insertTag: (nonnull YFTag *)tag atIndex:(NSUInteger)index;
- (void)removeTag: (nonnull YFTag *)tag;
- (void)removeTagAtIndex: (NSUInteger)index;
- (void)removeAllTags;

@end

