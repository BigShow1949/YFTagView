//
//  YFTagButton.h
//  YFTagView
//
//  Created by BigShow1949 on 06/02/2021.
//  Copyright (c) 2021 BigShow1949. All rights reserved.
//

#import "YFTagButton.h"
#import "YFTag.h"

#import "YFTagView.h"
#import "UIButton+Extension_yf.h"

@implementation YFTagButton

+ (UIImage *)imageWithName:(NSString *)img {
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

+ (instancetype)buttonWithTag:(YFTag *)tag {
	YFTagButton *btn = [super buttonWithType:UIButtonTypeCustom];
    btn.YFTag = tag;
        
    [btn setImage:[self imageWithName:@"tag"] forState:UIControlStateNormal];
    [btn setImage:[self imageWithName:@"tag_selected"] forState:UIControlStateSelected];

    [btn layoutButtonWithEdgeInsetsStyle:LLButtonStyleTextRight imageTitleSpace:5];
    
	if (tag.attributedText) {
		[btn setAttributedTitle: tag.attributedText forState: UIControlStateNormal];
	} else {
		[btn setTitle: tag.text forState:UIControlStateNormal];
		[btn setTitleColor: tag.textColor forState: UIControlStateNormal];
		btn.titleLabel.font = tag.font ?: [UIFont systemFontOfSize: tag.fontSize];
	}
    if (tag.selectTextColor) {
        [btn setTitleColor:tag.selectTextColor forState:UIControlStateSelected];
    }
    if (tag.selectBgColor) {
        UIColor *selectBgColor = tag.selectBgColor;
        [btn setBackgroundImage:[self imageWithColor:selectBgColor] forState:UIControlStateSelected];
    }
    
    btn.selected = tag.isSelect;
	btn.backgroundColor = tag.bgColor;
	btn.contentEdgeInsets = tag.padding;
	btn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
	
    if (tag.bgImg) {
        [btn setBackgroundImage: tag.bgImg forState: UIControlStateNormal];
    }

    
    if (btn.selected) {
        if (tag.selectborderColor) {
            btn.layer.borderColor = tag.selectborderColor.CGColor;
        }
        
    }
    
    if (!btn.selected) {
        if (tag.borderColor) {
            btn.layer.borderColor = tag.borderColor.CGColor;
        }
        
    }
    
    if (tag.borderWidth) {
        btn.layer.borderWidth = tag.borderWidth;
    }
    
    btn.userInteractionEnabled = tag.enable;
    if (tag.enable) {
        UIColor *highlightedBgColor = tag.highlightedBgColor ?: [self darkerColor:btn.backgroundColor];
        [btn setBackgroundImage:[self imageWithColor:highlightedBgColor] forState:UIControlStateHighlighted];
    }
    
    btn.layer.cornerRadius = tag.cornerRadius;
    btn.layer.masksToBounds = YES;
    
    return btn;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

+ (UIColor *)darkerColor:(UIColor *)color {
    CGFloat h, s, b, a;
    if ([color getHue:&h saturation:&s brightness:&b alpha:&a])
        return [UIColor colorWithHue:h
                          saturation:s
                          brightness:b * 0.85
                               alpha:a];
    return color;
}

@end
