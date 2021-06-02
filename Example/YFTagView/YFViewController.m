//
//  YFViewController.m
//  YFTagView
//
//  Created by BigShow1949 on 06/02/2021.
//  Copyright (c) 2021 BigShow1949. All rights reserved.
//

#import "YFViewController.h"
#import "YFTagView.h"
#import "Masonry.h"

@interface YFViewController ()
@property (strong, nonatomic) YFTagView *tagView;
@property (strong, nonatomic) NSArray *colors;
@end

@implementation YFViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.colors = @[@"#7ecef4", @"#84ccc9", @"#88abda", @"#7dc1dd", @"#b6b8de"];
    [self setupTagView];
}

#pragma mark - Private
- (void)setupTagView {
    self.tagView = ({
        YFTagView *view = [YFTagView new];
        view.backgroundColor = [UIColor redColor];
        view.padding = UIEdgeInsetsMake(12, 12, 12, 12);
        view.interitemSpacing = 15;
        view.lineSpacing = 10;
        __weak YFTagView *weakView = view;
//        view.didTapTagAtIndex = ^(NSUInteger index){
//            [weakView removeTagAtIndex:index];
//        };
        view.didTapTagAtIndex = ^(NSUInteger index, UIButton * _Nonnull bnt) {
            
        };
        view;
    });
    [self.view addSubview:self.tagView];
    [self.tagView mas_makeConstraints: ^(MASConstraintMaker *make) {
        UIView *superView = self.view;
        make.centerY.equalTo(superView.mas_centerY).with.offset(0);
        make.leading.equalTo(superView.mas_leading).with.offset(0);
        make.trailing.equalTo(superView.mas_trailing);
    }];
    
    //Add Tags , @"Python", @"Swift", @"Go", @"Objective-C", @"C", @"PHP"
    [@[@"Python", @"Javascript"] enumerateObjectsUsingBlock: ^(NSString *text, NSUInteger idx, BOOL *stop) {
        YFTag *tag = [YFTag tagWithText: text];
        tag.textColor = [UIColor whiteColor];
        tag.fontSize = 15;
        //tag.font = [UIFont fontWithName:@"Courier" size:15];
        //tag.enable = NO;
        tag.padding = UIEdgeInsetsMake(13.5, 12.5, 13.5, 12.5);
        tag.bgColor = [UIColor lightGrayColor];
        tag.cornerRadius = 5;
        [self.tagView addTag:tag];
    }];
}

#pragma mark - IBActions
//- (IBAction)onAdd: (id)sender {
//    YFTag *tag = [YFTag tagWithText: @"Some Language"];
//    tag.textColor = [UIColor whiteColor];
//    tag.fontSize = 15;
//    tag.enable = YES;
//    tag.padding = UIEdgeInsetsMake(13.5, 12.5, 13.5, 12.5);
////    tag.bgColor = [UIColor colorWithHexString:self.colors[arc4random() % self.colors.count]];
//
//    tag.cornerRadius = 5;
//    
//    [self.tagView addTag:tag];
//}

@end
