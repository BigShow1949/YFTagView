//
//  UIButton+Position.h
//
//  Created by BigShow on 2021/6/1.
//

#import <UIKit/UIKit.h>

@interface UIButton (Position)
/*
 针对同时设置了Image和Title的场景时UIButton中的图片和文字的关系
 */
typedef NS_ENUM(NSInteger,YFPositionButton) {
    YFPositionButtonTextOnly = 1, //只显示文字
    YFPositionButtonImgOnly,      //只显示图片
    YFPositionButtonTextLeft,     //文字在左，图片在右
    YFPositionButtonTextRight,    //文字在右，图片在左
    YFPositionButtonTextTop,      //文字在上，图片在下
    YFPositionButtonTextBottom,   //文字在下，图片在上
    YFPositionButtonTextBottomFixedText,//文字在下，图片在上 固定文字
    YFPositionButtonTextMiddle,   //文字/图片都在中间
};


/**
 * 调整按钮的文本和image的布局，调用这个方法前，必须先设置好button的image和title/attributedtitle 按钮的大小 要不然无法生效
 *
 * @param style YFPositionButton 文字位置
 *
 * @param space CGFloat 文本与图片的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(YFPositionButton)style
                        imageTitleSpace:(CGFloat)space;


@end
