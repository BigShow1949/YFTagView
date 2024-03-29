//
//  YFTagView.h
//  YFTagView
//
//  Created by BigShow1949 on 06/02/2021.
//  Copyright (c) 2021 BigShow1949. All rights reserved.
//

#import "YFTagView.h"
#import "YFTagButton.h"


@interface YFTagView ()
/** 数据源tags数组 */
@property (strong, nonatomic, nullable) NSMutableArray <YFTag *>*tagsArr;
/** 选中的tags数组 */
@property (nonatomic,strong,nullable) NSMutableArray <YFTag *>*selectedTagsArr;
/** 选中的tags的index数组 */
@property (nonatomic,strong,nullable) NSMutableArray <NSNumber *>*selectedTagsIndexArr;

@property (assign, nonatomic) BOOL didSetup;
@property (nonatomic,assign) BOOL isIntrinsicWidth;  //!<是否宽度固定
@property (nonatomic,assign) BOOL isIntrinsicHeight; //!<是否高度固定
//@property (nonatomic, strong) NSMutableArray *bntArray;//所有的按钮

@end

@implementation YFTagView

// 重写setter给bool赋值
- (void)setRegularWidth:(CGFloat)intrinsicWidth
{
    if (_regularWidth != intrinsicWidth) {
        _regularWidth = intrinsicWidth;
        if (intrinsicWidth == 0) {
            self.isIntrinsicWidth = NO;
        }
        else
        {
            self.isIntrinsicWidth = YES;
        }
    }
    
}

- (void)setRegularHeight:(CGFloat)intrinsicHeight
{
    if (_regularHeight != intrinsicHeight) {
        _regularHeight = intrinsicHeight;
        if (intrinsicHeight == 0)
        {
            self.isIntrinsicHeight = NO;
        }
        else
        {
            self.isIntrinsicHeight = YES;
        }
    }
}

#pragma mark - Lifecycle

-(CGSize)intrinsicContentSize {
    if (!self.tagsArr.count) {
        return CGSizeZero;
    }
    
    NSArray *subviews = self.subviews;
    UIView *previousView = nil;
    CGFloat topPadding = self.edgeInsets.top;
    CGFloat bottomPadding = self.edgeInsets.bottom;
    CGFloat leftPadding = self.edgeInsets.left;
    CGFloat rightPadding = self.edgeInsets.right;
    CGFloat itemSpacing = self.interitemSpacing;
    CGFloat lineSpacing = self.lineSpacing;
    CGFloat currentX = leftPadding;
    CGFloat intrinsicHeight = topPadding;
    CGFloat intrinsicWidth = leftPadding;
    
    if (!self.singleLine && self.preferredMaxLayoutWidth > 0) {
        NSInteger lineCount = 0;
        for (UIView *view in subviews) {
            CGSize size = view.intrinsicContentSize;
            // 宽度和高度通过参数的0或者非0来进行赋值
            CGFloat width = self.isIntrinsicWidth?self.regularWidth:size.width;
            CGFloat height = self.isIntrinsicHeight?self.regularHeight:size.height;
            if (previousView) {
                //                CGFloat width = size.width;
                currentX += itemSpacing;
                if (currentX + width + rightPadding <= self.preferredMaxLayoutWidth) {
                    currentX += width;
                } else {
                    lineCount ++;
                    currentX = leftPadding + width;
                    intrinsicHeight += height;
                }
            } else {
                lineCount ++;
                intrinsicHeight += height;
                currentX += width;
            }
            previousView = view;
            intrinsicWidth = MAX(intrinsicWidth, currentX + rightPadding);
        }
        
        intrinsicHeight += bottomPadding + lineSpacing * (lineCount - 1);
    } else {
        for (UIView *view in subviews) {
            CGSize size = view.intrinsicContentSize;
            intrinsicWidth += self.isIntrinsicWidth?self.regularWidth:size.width;
        }
        intrinsicWidth += itemSpacing * (subviews.count - 1) + rightPadding;
        intrinsicHeight += ((UIView *)subviews.firstObject).intrinsicContentSize.height + bottomPadding;
    }
    
    return CGSizeMake(intrinsicWidth, intrinsicHeight);
}

- (void)layoutSubviews {
    if (!self.singleLine) {
        self.preferredMaxLayoutWidth = self.frame.size.width;
    }
    
    [super layoutSubviews];
    
    [self layoutTags];
}

#pragma mark - Custom accessors

- (NSMutableArray *)tagsArr {
    if(!_tagsArr) {
        _tagsArr = [NSMutableArray array];
    }
    return _tagsArr;
}

- (NSMutableArray<YFTag *> *)selectedTagsArr {
    if (!_selectedTagsArr) {
        _selectedTagsArr = [NSMutableArray array];
    }
    return  _selectedTagsArr;;
}

- (NSMutableArray<NSNumber *> *)selectedTagsIndexArr {
    if (!_selectedTagsIndexArr) {
        _selectedTagsIndexArr = [NSMutableArray array];
    }
    return _selectedTagsIndexArr;
}

//- (NSMutableArray *)bntArray{
//    if (!_bntArray) {
//        _bntArray = [NSMutableArray array];
//    }
//    return _bntArray;
//}

- (void)setPreferredMaxLayoutWidth: (CGFloat)preferredMaxLayoutWidth {
    if (preferredMaxLayoutWidth != _preferredMaxLayoutWidth) {
        _preferredMaxLayoutWidth = preferredMaxLayoutWidth;
        _didSetup = NO;
        [self invalidateIntrinsicContentSize];
    }
}

#pragma mark - Private

- (void)updateSelectedTags {
    [self.selectedTagsArr removeAllObjects];
    [self.selectedTagsIndexArr removeAllObjects];
    
    for (YFTag *tag in self.tagsArr) {
        NSInteger index = [self.tagsArr indexOfObject:tag];
        if (tag.isSelect) {
            [self.selectedTagsArr addObject:tag];
            [self.selectedTagsIndexArr addObject:@(index)];
        }
    }
}

- (void)layoutTags {
    if (self.didSetup || !self.tagsArr.count) {
        return;
    }
    
    NSArray *subviews = self.subviews;
    UIView *previousView = nil;
    CGFloat topPadding = self.edgeInsets.top;
    CGFloat leftPadding = self.edgeInsets.left;
    CGFloat rightPadding = self.edgeInsets.right;
    CGFloat itemSpacing = self.interitemSpacing;
    CGFloat lineSpacing = self.lineSpacing;
    CGFloat currentX = leftPadding;
    
    if (!self.singleLine && self.preferredMaxLayoutWidth > 0) {
        for (UIView *view in subviews) {
            CGSize size = view.intrinsicContentSize;
            CGFloat width1 = self.isIntrinsicWidth?self.regularWidth:size.width;
            CGFloat height1 = self.isIntrinsicHeight?self.regularHeight:size.height;
            if (previousView) {
                //                CGFloat width = size.width;
                currentX += itemSpacing;
                if (currentX + width1 + rightPadding <= self.preferredMaxLayoutWidth) {
                    view.frame = CGRectMake(currentX, CGRectGetMinY(previousView.frame), width1, height1);
                    currentX += width1;
                } else {
                    CGFloat width = MIN(width1, self.preferredMaxLayoutWidth - leftPadding - rightPadding);
                    view.frame = CGRectMake(leftPadding, CGRectGetMaxY(previousView.frame) + lineSpacing, width, height1);
                    currentX = leftPadding + width;
                }
            } else {
                CGFloat width = MIN(width1, self.preferredMaxLayoutWidth - leftPadding - rightPadding);
                view.frame = CGRectMake(leftPadding, topPadding, width, height1);
                currentX += width;
            }
            
            previousView = view;
        }
    } else {
        for (UIView *view in subviews) {
            CGSize size = view.intrinsicContentSize;
            view.frame = CGRectMake(currentX, topPadding, self.isIntrinsicWidth?self.regularWidth:size.width, self.isIntrinsicHeight?self.regularHeight:size.height);
            currentX += self.isIntrinsicWidth?self.regularWidth:size.width;
            
            previousView = view;
        }
    }
    
    self.didSetup = YES;
}

#pragma mark - IBActions

- (void)onTag:(YFTagButton *)btn{
    if (self.tagViewStyle == YFTagViewSelectStyleNone) {
        
    }
    if(self.tagViewStyle == YFTagViewSelectStyleOne){
        btn.selected = YES;
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            YFTagButton *bnt = (YFTagButton *)obj;
            if (bnt != btn) {
                bnt.selected = NO;
            }
        }];
    }
    if (self.tagViewStyle == YFTagViewSelectStyleMore) {
        btn.selected = !btn.selected;
    }
    
    [self updateSelectedTags];

    if (self.didTapTagAtIndex) {
        self.didTapTagAtIndex([self.subviews indexOfObject:btn] ,btn);
    }
}

#pragma mark - Public

- (void)addTag:(YFTag *)tag {
    NSParameterAssert(tag);
    YFTagButton *btn = [YFTagButton buttonWithTag:tag];
    [btn addTarget:self action:@selector(onTag:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: btn];
    [self.tagsArr addObject: tag];
    
    self.didSetup = NO;
    [self invalidateIntrinsicContentSize];
    
    [self updateSelectedTags];
}

- (void)insertTag:(YFTag *)tag atIndex:(NSUInteger)index {
    NSParameterAssert(tag);
    if (index + 1 > self.tagsArr.count) {
        [self addTag:tag];
    } else {
        YFTagButton *btn = [YFTagButton buttonWithTag:tag];
        [btn addTarget:self action: @selector(onTag:) forControlEvents:UIControlEventTouchUpInside];
        [self insertSubview:btn atIndex:index];
        [self.tagsArr insertObject:tag atIndex:index];
        
        self.didSetup = NO;
        [self invalidateIntrinsicContentSize];
    }
    
    [self updateSelectedTags];
}

- (void)removeTag: (YFTag *)tag {
    NSParameterAssert(tag);
    NSUInteger index = [self.tagsArr indexOfObject: tag];
    if (NSNotFound == index) {
        return;
    }
    
    [self.tagsArr removeObjectAtIndex: index];
    if (self.subviews.count > index) {
        [self.subviews[index] removeFromSuperview];
    }
    
    self.didSetup = NO;
    [self invalidateIntrinsicContentSize];
    [self updateSelectedTags];
}

- (void)removeTagAtIndex: (NSUInteger)index {
    if (index + 1 > self.tagsArr.count) {
        return;
    }
    
    [self.tagsArr removeObjectAtIndex: index];
    if (self.subviews.count > index) {
        [self.subviews[index] removeFromSuperview];
    }
    
    self.didSetup = NO;
    [self invalidateIntrinsicContentSize];
    [self updateSelectedTags];
}

- (void)removeAllTags {
    [self.tagsArr removeAllObjects];
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    self.didSetup = NO;
    [self invalidateIntrinsicContentSize];
    [self updateSelectedTags];
}


@end
