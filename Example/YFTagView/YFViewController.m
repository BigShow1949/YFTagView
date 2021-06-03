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
@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic,strong) UIButton *addBtn;
@property (nonatomic,strong) UIButton *deleteBtn;

@end

@implementation YFViewController

#pragma mark - Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = @[@"含有错别字",@"答案不正确",@"图片不存在",@"解析不完整",@"这是一个很长的错误原因",@"这是错的原因",@"其他错误"];
    self.colors = @[@"#7ecef4", @"#84ccc9", @"#88abda", @"#7dc1dd", @"#b6b8de"];
    [self setupTagView];
}

#pragma mark - Private
- (void)setupTagView {
    [self.view addSubview:self.tagView];
    [self.view addSubview:self.addBtn];
    [self.view addSubview:self.deleteBtn];

    [self.tagView mas_makeConstraints: ^(MASConstraintMaker *make) {
        make.top.trailing.leading.equalTo(self.view);
    }];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tagView.mas_bottom);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(44);
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.height.equalTo(self.addBtn);
        make.left.equalTo(self.addBtn.mas_right).offset(10);
    }];
    
    //Add Tags , @"Python", @"Swift", @"Go", @"Objective-C", @"C", @"PHP"
    [self.dataArray enumerateObjectsUsingBlock: ^(NSString *text, NSUInteger idx, BOOL *stop) {
        YFTag *tag = [YFTag tagWithText: text];
        tag.textColor = [UIColor whiteColor];
        tag.fontSize = 15;
        //tag.font = [UIFont fontWithName:@"Courier" size:15];
        //tag.enable = NO;
        tag.edgeInsets = UIEdgeInsetsMake(13.5, 12.5, 13.5, 12.5);
        tag.bgColor = [UIColor lightGrayColor];
        tag.cornerRadius = 5;
        tag.image = tag.imageDefault;
        tag.selectImage = tag.selectImageDefault;
        [self.tagView addTag:tag];
    }];
}

#pragma mark - voids
- (void)onAdd: (id)sender {
   YFTag *tag = [YFTag tagWithText: @"Some Language"];
   tag.textColor = [UIColor whiteColor];
   tag.fontSize = 15;
   tag.enable = YES;
   tag.edgeInsets = UIEdgeInsetsMake(13.5, 12.5, 13.5, 12.5);
   tag.bgColor = [UIColor lightGrayColor];
   tag.cornerRadius = 5;
   [self.tagView addTag:tag];
}

- (void)onInsert: (id)sender {
   YFTag *tag = [YFTag tagWithText:@"insetOne"];
   tag.textColor = [UIColor whiteColor];
   tag.fontSize = 15;
   tag.edgeInsets = UIEdgeInsetsMake(13.5, 12.5, 13.5, 12.5);
   tag.bgColor = [UIColor lightGrayColor];;
   tag.cornerRadius = 5;
   [self.tagView insertTag:tag atIndex:0];
}

- (void)onRemove: (id)sender {
   [self.tagView removeTagAtIndex:0];
}

- (void)onTapBg: (id)sender {
   [self.view endEditing: YES];
}

- (YFTagView *)tagView {
    if (!_tagView) {
        YFTagView *view = [YFTagView new];
        view.preferredMaxLayoutWidth = CGRectGetWidth(view.frame);
        view.backgroundColor = [UIColor whiteColor];
        view.edgeInsets = UIEdgeInsetsMake(12, 0, 12, 0);
        view.interitemSpacing = 0;
        view.lineSpacing = 0;
        view.tagViewStyle = YFTagViewSelectStyleMore;
        __weak YFTagView *weakView = view;
        view.didTapTagAtIndex = ^(NSUInteger index , UIButton * _Nonnull bnt){
            NSLog(@"%ld",index);
//            [weakView removeTagAtIndex:index];
        };
        _tagView = view;
    }
    return _tagView;
}

- (UIButton *)addBtn {
    if (!_addBtn) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:@"增加" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor redColor];
        [btn addTarget:self action:@selector(onInsert:) forControlEvents:UIControlEventTouchUpInside];
        _addBtn = btn;
    }
    return  _addBtn;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:@"删除" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor redColor];
        [btn addTarget:self action:@selector(onRemove:) forControlEvents:UIControlEventTouchUpInside];
        _deleteBtn = btn;
    }
    return  _deleteBtn;
}



@end
