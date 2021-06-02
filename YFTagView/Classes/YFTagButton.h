//
//  YFTagButton.h
//  YFTagView
//
//  Created by BigShow1949 on 06/02/2021.
//  Copyright (c) 2021 BigShow1949. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class YFTag;
@interface YFTagButton: UIButton

@property (nonatomic, strong) YFTag * _Nullable YFTag;

+ (nonnull instancetype)buttonWithTag:(nonnull YFTag *)tag;

@end
