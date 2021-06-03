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

+ (instancetype)buttonWithTag:(YFTag *)tag {
	YFTagButton *btn = [super buttonWithType:UIButtonTypeCustom];
    btn.YFTag = tag;
    if (tag.image) {
        [btn setImage:tag.image forState:UIControlStateNormal];
        [btn layoutButtonWithEdgeInsetsStyle:LLButtonStyleTextRight imageTitleSpace:5];
    }
    
    if (tag.selectImage) {
        [btn setImage:tag.selectImage forState:UIControlStateSelected];
    }
    
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
	btn.contentEdgeInsets = tag.edgeInsets;
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

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    self.YFTag.isSelect = selected;
    
    if (self.YFTag.borderColor) {
        if (!selected) {
            self.layer.borderColor = self.YFTag.borderColor.CGColor;
        }
    }

    if (self.YFTag.selectborderColor) {
        if (selected) {
            self.layer.borderColor = self.YFTag.selectborderColor.CGColor;
        }
    }
}






@end
