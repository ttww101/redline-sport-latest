//
//  PublishViewController.m
//  GQZhiBo
//
//  Created by genglei on 2018/11/23.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "PublishViewController.h"
#import "GL_TextView.h"
#import "RLSInputViewController.h"
#import "InputAccessoryView.h"
//#import "WBEmoticonInputView.h"
//#import "WBStatusComposeTextParser.h"
#import "PictureModel.h"
#import "NSAttributedString+html.h"


@interface PublishViewController () <UITextViewDelegate, UITextFieldDelegate, YYTextViewDelegate, InputAccessoryViewDelegate, YYTextKeyboardObserver,UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) UITextField *titleTxtFiled;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) GL_TextView *textview;
@property (nonatomic ,strong) InputAccessoryView *inputView;
@property (nonatomic, strong) NSMutableArray *picArray;
@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, assign) BOOL isRecord;


@end

@implementation PublishViewController

- (instancetype)init {
    self = [super init];
    [[YYTextKeyboardManager defaultManager] addObserver:self];
    return self;
}

- (void)dealloc {
    [[YYTextKeyboardManager defaultManager] removeObserver:self];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:ResignActiveNotificarion object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self loadData];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(saveContent) name:ResignActiveNotificarion object:nil];
    self.isRecord = true;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:false animated:true];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self saveContent];
}

#pragma mark - Config UI

- (void)configUI {
    self.navigationItem.title = @"发布推荐";
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitle:@"发表" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = font16;
    rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 40, 44);
    [rightBtn addTarget:self action:@selector(upContent) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.title = @"发表帖子";
    self.view.backgroundColor = [UIColor whiteColor];
   
    
    [self.view addSubview:self.titleTxtFiled];
    [self.titleTxtFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(5);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(44);
    }];
    
    [self.view addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleTxtFiled.mas_bottom).offset(0);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(ONE_PX_LINE);
    }];

    [self.view addSubview:self.textview];
    [self.textview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).offset(0);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.bottom.equalTo(self.view.mas_bottom).offset(-40);
    }];
    
    [self.view addSubview: self.inputView];
    self.inputView.bottom = self.view.height;
}

#pragma mark - Load Data

- (void)loadData {
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:RecordsFormEditContentPath];
    self.titleTxtFiled.text = dic[@"title"];
    self.picArray = [dic[@"pic"] mutableCopy];
    NSMutableAttributedString *attributText = [[NSMutableAttributedString alloc]initWithString: PARAM_IS_NIL_ERROR(dic[@"content"])];
    NSMutableArray *array = [NSMutableArray array];
    NSArray *layouts = dic[@"layout"];
    for (NSInteger i = 0; i < self.picArray.count; i ++) {
        UIImage *image = [[YYImageCache sharedCache]getImageForKey:self.picArray[i]];
        [array addObject:image];
        UIFont *font = [UIFont systemFontOfSize:16];
        YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(0, 0, Width - 30, Width - 30/image.size.width*image.size.height);
        imageView.tag = 0;
        NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:imageView contentMode:UIViewContentModeCenter attachmentSize:imageView.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
        [attributText insertAttributedString:attachText atIndex:[layouts[i] integerValue]];
    }
    self.textview.attributedText = attributText;
    self.imageArray = array;
}

#pragma mark UITextFieldDelegate

// 简易写法 限制字数不是很准确
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length == 0) return YES;
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if (existedLength - selectedLength + replaceLength > 20){
        return NO;
    }
    return YES;
}

#pragma mark - YYTextViewDelegate

- (void)textViewDidEndEditing:(YYTextView *)textView {
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void)textViewDidChange:(YYTextView *)textView {
   
}

- (BOOL)textView:(YYTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@""]) {
        NSArray *attachmentRanges = textView.textLayout.attachmentRanges;
        NSInteger location = range.location;
        for (NSInteger i = 0; i < attachmentRanges.count; i ++) {
            NSRange r = [attachmentRanges[i] rangeValue];
            if (r.location == location) {
                [self.picArray removeObjectAtIndex:i];
                [self.imageArray removeObjectAtIndex:i];
            }
        }
    }
    return true;
}

#pragma mark @protocol YYTextKeyboardObserver

- (void)keyboardChangedWithTransition:(YYTextKeyboardTransition)transition {
    CGRect toFrame = [[YYTextKeyboardManager defaultManager] convertRect:transition.toFrame toView:self.view];
    if (transition.animationDuration == 0) {
        self.inputView.bottom = CGRectGetMinY(toFrame);
    } else {
        [UIView animateWithDuration:transition.animationDuration delay:0 options:transition.animationOption | UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.inputView.bottom = CGRectGetMinY(toFrame);
        } completion:NULL];
    }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSUInteger sourceType = 0;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        switch (buttonIndex)
        {
            case 2:
                // 取消
                return;
            case 0:
                // 相机
                sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
                
            case 1:
                // 相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
        }
    }
    else
    {
        if (buttonIndex == 1)
        {
            return;
        }
        else
        {
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
    }
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    [self presentViewController:imagePickerController animated:YES completion:^{}];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    NSData*imageData =UIImageJPEGRepresentation(image,0.8);
    image = [UIImage imageWithData:imageData];
    
    [RLSLodingAnimateView showLodingView];
    [[RLSDCHttpRequest shareInstance]sendRequestByMethod:@"post" WithParamaters:@{@"type":@"avatar"} PathUrlL:[NSString stringWithFormat:@"http://mobile.gunqiu.com:8897%@",url_uploadAliyun] ArrayFile:[NSArray arrayWithObjects:image, nil] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        [RLSLodingAnimateView dissMissLoadingView];
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            NSDictionary *dic = responseOrignal;
            NSDictionary *contentDic = dic[@"data"];
            NSString *picUrl = contentDic[@"picurl"];
            [self.picArray addObject:picUrl];
            [self.imageArray addObject:image];
             [self setImageText:image withRange:_textview.selectedRange appenReturn:true currentTime:0];
        }else{
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [RLSLodingAnimateView dissMissLoadingView];
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:^{}];
}


#pragma mark WBStatusComposeEmoticonView

- (void)emoticonInputDidTapText:(NSString *)text {
    if (text.length) {
        [self.textview replaceRange:self.textview.selectedTextRange withText:text];
    }
}

- (void)emoticonInputDidTapBackspace {
    [self.textview deleteBackward];
}

#pragma mark - InputAccessoryViewDelegate

- (void)InputAccessoryViewEmojiAction:(UIButton *)sender {
    if (self.textview.inputView) {
        self.textview.inputView = nil;
        [self.textview reloadInputViews];
        [self.textview becomeFirstResponder];
        [sender setBackgroundImage:[UIImage imageNamed:@"emoji"] forState:UIControlStateNormal];
    } else {
//        WBEmoticonInputView *v = [WBEmoticonInputView sharedView];
//        v.delegate = self;
//        self.textview.inputView = v;
        [self.textview reloadInputViews];
        [self.textview becomeFirstResponder];
        [sender setBackgroundImage:[UIImage imageNamed:@"keyboard"] forState:UIControlStateNormal];
    }
}

- (void)InputAccessoryViewPicAction:(UIButton *)sender {
    if (self.picArray.count >= 3) {
        [SVProgressHUD showErrorWithStatus:@"最多只能选择三张图片"];
        return;
    }
    UIActionSheet *sheet;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择",@"取消", nil];
    } else {
        sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"从相册选择" otherButtonTitles:@"取消", nil];
    }
    [sheet showInView:self.view];
}

#pragma mark - Notification

- (void)saveContent {
    
    if (self.isRecord) {
        NSString *content = self.textview.attributedText.string;
        for (NSInteger i = 0; i < self.picArray.count; i ++) {
            YYImageCache *cache = [YYImageCache sharedCache];
            [cache setImage:self.imageArray[i] forKey:self.picArray[i]];
        }
        NSMutableArray *array = [NSMutableArray array];
        
        NSArray *attachmentRanges = self.textview.textLayout.attachmentRanges;
        for (NSValue *range in attachmentRanges)
        {
            NSRange r = [range rangeValue];
            [array addObject:@(r.location)];
        }
        NSDictionary *saveDic = @{
                                  @"title": PARAM_IS_NIL_ERROR(self.titleTxtFiled.text),
                                  @"content": PARAM_IS_NIL_ERROR(content),
                                  @"pic": self.picArray,
                                  @"layout": array
                                  };
        [[NSUserDefaults standardUserDefaults]setObject:saveDic forKey:RecordsFormEditContentPath];
        [[NSUserDefaults standardUserDefaults]synchronize];
    
    } else {
        [self.picArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [[YYImageCache sharedCache]removeImageForKey:obj];
        }];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:RecordsFormEditContentPath];
        [[NSUserDefaults standardUserDefaults]synchronize];
    
    }
}

#pragma mark - Events

- (void)upContent {
    
    if(![RLSMethods login]) {
        [RLSMethods toLogin];
        return;
    }
    
    if (self.titleTxtFiled.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"标题不能为空"];
        return;
    }
    
    if (self.textview.attributedText.length == 0) {
         [SVProgressHUD showErrorWithStatus:@"内容不能为空"];
         return;
    }
    
    RLSUserModel *model = [RLSMethods getUserModel];
    NSString *content = [self replacetagWithImageArray:[self.picArray copy]];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:PARAM_IS_NIL_ERROR(self.modelId) forKey:@"modelId"];
    [parameter setObject:PARAM_IS_NIL_ERROR(self.titleTxtFiled.text) forKey:@"title"];
    [parameter setObject:content forKey:@"content"];
    [parameter setObject:@(model.idId) forKey:@"userId"];
    for (NSInteger i = 0; i < self.picArray.count; i ++) {
        [parameter setObject:self.picArray[i] forKey:[NSString stringWithFormat:@"image%zi", i + 1]];
    }
     [RLSLodingAnimateView showLodingView];
    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server, url_topic_publish] ArrayFile:nil Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        [RLSLodingAnimateView dissMissLoadingView];
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            self.isRecord = false;
            [self.navigationController popViewControllerAnimated:true];
        }else{
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
         [RLSLodingAnimateView dissMissLoadingView];
    }];
}

#pragma mark - Private

#pragma mark -- 拼接图片地址
-(NSString *)replacetagWithImageArray:(NSArray *)picArr
{
    NSMutableAttributedString * contentStr=[[NSMutableAttributedString alloc]initWithAttributedString:self.textview.attributedText];
    [contentStr enumerateAttribute:@"YYTextAttachment" inRange:NSMakeRange(0, contentStr.length)
                           options:0
                        usingBlock:^(id value, NSRange range, BOOL *stop) {
                            if (value && [value isKindOfClass:[YYTextAttachment class]]) {
                                [contentStr replaceCharactersInRange:range withString:RICHTEXT_IMAGE];
                            }
                        }];
    NSMutableString * mutableStr=[[NSMutableString alloc]initWithString:contentStr.string];
    NSArray * strArr=[mutableStr  componentsSeparatedByString:RICHTEXT_IMAGE];
    NSString * newContent=@"";
    for (int i=0; i<strArr.count; i++) {
        NSString * imgTag=@"";
        if (i<picArr.count) {

           imgTag=[NSString stringWithFormat:@"<img src=\"%@\" style='max-width:100%%'/>", picArr[i]];
        }
        NSString * cutStr=[strArr objectAtIndex:i];
        newContent=[NSString stringWithFormat:@"%@%@%@",newContent,cutStr,imgTag];
    }
//    [self getPPP:newContent];
    return newContent;
}

- (NSString *)getRichText {
    NSMutableAttributedString *contentStr = [[NSMutableAttributedString alloc]initWithAttributedString:self.textview.attributedText];
    [contentStr enumerateAttribute:@"YYTextAttachment" inRange:NSMakeRange(0, contentStr.length)
                           options:0
                        usingBlock:^(id value, NSRange range, BOOL *stop) {
                            if (value && [value isKindOfClass:[YYTextAttachment class]]) {
                                [contentStr replaceCharactersInRange:range withString:RICHTEXT_IMAGE];
                            }
                        }];
    return contentStr.string;
}

- (void)getPPP:(NSString *)strHTML{
    NSArray *arrayOne = [strHTML componentsSeparatedByString:@"<body>"];
    NSArray *arrayTwo = [arrayOne[1] componentsSeparatedByString:@"</body>"];
    NSArray *arrTwo = [arrayTwo[0] componentsSeparatedByString:@"</span>"];
    NSString *str = @"";
    for (int i = 0; i < arrTwo.count ; i ++) {
        if ([arrTwo[i] rangeOfString:@"<img"].location ==NSNotFound) {
            str = [NSString stringWithFormat:@"%@%@",str,arrTwo[i]];
        }
    }

}
-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        NSLog(@"%@",text);
        if ([text containsString:@"img"]) {
            continue;
        }else if ([text containsString:@"<p"]) {
            html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",text] withString:@"<p"];
        }else if ([text isEqualToString:@"</p"]) {
            html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",text] withString:@"</p"];
        }else if ([text isEqualToString:@"\n"]) {
            html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",text] withString:@"<br>"];
        }else{
            html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
        }
    }
    html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    html = [html stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    return html;
}

- (void)setImageText:(UIImage *)img withRange:(NSRange)range appenReturn:(BOOL)appen currentTime:(NSTimeInterval)time {
    UIImage * image=img;
    if (image == nil)
    {
        return;
    }
    if (![image isKindOfClass:[UIImage class]])
    {
        return;
    }
    NSMutableAttributedString *attributText = [self.textview.attributedText mutableCopy];
    UIFont *font = [UIFont systemFontOfSize:16];
    YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 0, _textview.width, _textview.width/image.size.width*image.size.height);
    imageView.tag = time;
    NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:imageView contentMode:UIViewContentModeCenter attachmentSize:imageView.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
    [attributText insertAttributedString:attachText atIndex:range.location];
    self.textview.attributedText = attributText;
}

#pragma mark - Lazy Load

- (UITextField *)titleTxtFiled {
    if (_titleTxtFiled == nil) {
        _titleTxtFiled = [[UITextField alloc]init];
        NSString *placeText = @"标题（最多20个字符）";
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:placeText];
        [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:[placeText rangeOfString:placeText]];
        [att addAttribute:NSForegroundColorAttributeName value:UIColorHex(#D0CFCF) range:[placeText rangeOfString:placeText]];
        _titleTxtFiled.attributedPlaceholder = att;
        _titleTxtFiled.delegate = self;
    }
    return _titleTxtFiled;
}

- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [UIView new];
        _lineView.backgroundColor = UIColorHex(eeeeee);
    }
    return _lineView;
}

- (GL_TextView *)textview {
    if (_textview == nil) {
        _textview = [[GL_TextView alloc]init];
        _textview.delegate = self;
        _textview.placeholderText = @"发表帖子正文";
        _textview.placeholderTextColor = UIColorHex(#D0CFCF);
        _textview.placeholderFont = [UIFont systemFontOfSize:14];
        _textview.allowsPasteImage = true;
        _textview.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
        _textview.inputAccessoryView = [UIView new];
        _textview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//         _textview.textParser = [WBStatusComposeTextParser new];
        _textview.showsVerticalScrollIndicator = NO;
        _textview.alwaysBounceVertical = YES;
        _textview.allowsCopyAttributedString = NO;
        _textview.extraAccessoryViewHeight = 36;
        _textview.allowsPasteAttributedString = YES; /// Paste attributed string
    }
    return _textview;
}

- (InputAccessoryView *)inputView {
    if (_inputView == nil) {
        _inputView = [[InputAccessoryView alloc]init];
        _inputView.delegate = self;
    }
    return _inputView;
}

- (NSMutableArray *)picArray {
    if (_picArray == nil) {
        _picArray = [NSMutableArray new];
    }
    return _picArray;
}

- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray new];
    }
    return _imageArray;
}

@end
