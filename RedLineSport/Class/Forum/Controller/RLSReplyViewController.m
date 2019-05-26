//
//  ReplyViewController.m
//  GQZhiBo
//
//  Created by genglei on 2018/11/30.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "RLSReplyViewController.h"

@interface RLSReplyViewController () <UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *textNumberLabel;
@property (nonatomic, strong) UILabel *placeHolderLabel;
@property (assign, nonatomic) NSInteger maxLength;
@property (nonatomic , copy) NSString *recordText;

@end

NSInteger maxValue = 1000;

@implementation RLSReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Systerm Method

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if (textView.text.length > 0) {
        self.placeHolderLabel.hidden = YES;
    } else {
        self.placeHolderLabel.hidden = NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    UITextRange *selectedRange = [textView markedTextRange];
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    if (selectedRange && pos) {
        return;
    }
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    if (existTextNum > self.maxLength){
        NSString *s = [nsTextContent substringToIndex:self.maxLength];
        [textView setAttributedText: [self textViewAttributedStr:s]];
    }
    self.textNumberLabel.text = [NSString stringWithFormat:@"%ld/%ld",MAX(0,self.maxLength - existTextNum),self.maxLength];
    if ([self isStringContainsEmoji:textView.text]) {
        self.textView.text = [textView.text substringToIndex:textView.text.length - 2];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if(![text isEqualToString:@""]) {
        [self.placeHolderLabel setHidden:YES];
    }
    if([text isEqualToString:@""] && range.length == 1 && range.location == 0){
        [self.placeHolderLabel setHidden:NO];
    }
    UITextRange *selectedRange = [textView markedTextRange];
    UITextPosition *pos = [textView positionFromPosition:selectedRange.start offset:0];
    if (selectedRange && pos) {
        NSInteger startOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.start];
        NSInteger endOffset = [textView offsetFromPosition:textView.beginningOfDocument toPosition:selectedRange.end];
        NSRange offsetRange = NSMakeRange(startOffset, endOffset - startOffset);
        if (offsetRange.location < self.maxLength) {
            return YES;
        }else{
            return NO;
        }
    }
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger caninputlen = self.maxLength - comcatstr.length;
    if (caninputlen >= 0){
        return YES;
    }else{
        NSInteger len = text.length + caninputlen;
        NSRange rg = {0, MAX(len, 0)};
        if (rg.length > 0){
            [textView setAttributedText: [self textViewAttributedStr:[textView.text stringByReplacingCharactersInRange:range withString:[text substringWithRange:rg]]]];
            self.textNumberLabel.text = [NSString stringWithFormat:@"%d/%ld",0,(long)self.maxLength];
        }
        return NO;
    }
}

- (NSAttributedString *)textViewAttributedStr:(NSString *)text {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:14],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (BOOL)isStringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop)
     {
         const unichar hs = [substring characterAtIndex:0];
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
         } else {
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    return returnValue;
}

- (void)configUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.maxLength = maxValue;
    self.navigationItem.title = @"发表评论";
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(10);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(200);
    }];
    [self.textView addSubview:self.placeHolderLabel];
    [self.placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_top).offset(5);
        make.left.equalTo(self.textView.mas_left).offset(5);
    }];
    [self.view addSubview:self.textNumberLabel];
    [self.textNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textView.mas_left);
        make.top.equalTo(self.textView.mas_bottom).offset(20);
    }];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitle:@"提交" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = font16;
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    rightBtn.frame = CGRectMake(0, 0, 40, 44);
    [rightBtn addTarget:self action:@selector(upContent) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];

    if (self.nickName == nil) {
         self.placeHolderLabel.text = @"发表你的评论";
    } else {
        _placeHolderLabel.text = [NSString stringWithFormat:@"回复%@的评论", self.nickName];
    }
}

#pragma mark - Events

- (void)upContent {
    RLSUserModel *model = [RLSMethods getUserModel];
    if (!(self.textView.text.length > 0)) {
        [SVProgressHUD showErrorWithStatus:@"请输入内容"];
        return;
    }
    if (self.recordText) {
        if ([self.recordText isEqualToString:self.textView.text]) {
            [SVProgressHUD showErrorWithStatus:@"不可重复提交"];
            return;
        }
    }
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    NSString *urlPath = nil;
    if (self.nickName) {
        urlPath = url_topic_reply;
        [parameter setValue:PARAM_IS_NIL_ERROR(self.commentId) forKey:@"commentId"];
        [parameter setValue:self.textView.text forKey:@"content"];
    } else {
        urlPath = url_topic_comment;
        [parameter setValue:PARAM_IS_NIL_ERROR(self.postId) forKey:@"postId"];
        [parameter setValue:self.textView.text forKey:@"content"];
        [parameter setValue:@(model.idId) forKey:@"userId"];
    }
    
    [RLSLodingAnimateView showLodingView];
    [[RLSDCHttpRequest shareInstance]sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,urlPath] ArrayFile:nil Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        [RLSLodingAnimateView dissMissLoadingView];
        if ([responseOrignal[@"code"] isEqualToString:@"200"]) {
            self.recordText = self.textView.text;
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"发表成功"];
            [self.view endEditing:YES];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:responseOrignal[@"msg"]];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
         [RLSLodingAnimateView dissMissLoadingView];
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:responseOrignal[@"msg"]];
    }];
     

}

#pragma mark - Lazy Load

- (UITextView *)textView {
    if (_textView == nil) {
        _textView = [[UITextView alloc]init];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.delegate = self;
//        _textView.layer.borderColor = UIColorFromRGBWithOX(0x999999).CGColor;
//        _textView.layer.borderWidth = ONE_PX_LINE;
//        _textView.layer.masksToBounds = YES;
    }
    return _textView;
}
- (UILabel *)textNumberLabel {
    if (_textNumberLabel == nil) {
        _textNumberLabel = [UILabel new];
        _textNumberLabel.font = font12;
        _textNumberLabel.textColor = [UIColor grayColor];
        _textNumberLabel.text = [NSString stringWithFormat:@"可输入字数%zi字",maxValue];
    }
    return _textNumberLabel;
}
- (UILabel *)placeHolderLabel {
    if (_placeHolderLabel == nil) {
        _placeHolderLabel = [UILabel new];
        _placeHolderLabel.font = font15;
        _placeHolderLabel.textColor = UIColorFromRGBWithOX(0x333333);
       
    }
    return _placeHolderLabel;
}

@end
