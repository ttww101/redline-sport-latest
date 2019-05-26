#import "RLSFeedbackVC.h"
#import "RLSFeedBackHeaderView.h"
#import "RLSFeedBackCell.h"
#import "RLSFeedBackModel.h"
#import "RLSTFFileUploadManager.h"
#import "AFNetworking.h"
@interface RLSFeedbackVC ()<UITextViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView  *tableView;
@property (nonatomic, strong) UITextView *textContent;
@property (nonatomic, strong) UILabel *labPlaceholderContent;
@property (nonatomic, strong) UIView *viewContent;
@property (nonatomic, strong) UIView *viewComplete;
@property (nonatomic, strong) UIView                            *addImgView;
@property (nonatomic, strong) UIImageView                       *addImgeBtn;
@property (nonatomic, strong) UITextField                       *telPhoneTextField;
@property (nonatomic, strong) UIImage                           *image;
@property (nonatomic, strong) RLSNavView                           *nav;
@property (nonatomic, strong) RLSFeedBackHeaderView                *feedBackHeaderView;
@property (nonatomic, strong) NSMutableArray                   *feedArr;
@property (nonatomic, strong) NSString                          *urlStr;
@end
@implementation RLSFeedbackVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([RLSMethods login]) {
        _scrollView.contentSize = CGSizeMake(Width, _tableView.bottom);
    }else{
        _scrollView.contentSize = CGSizeMake(Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar);
    }
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([RLSMethods login]) {
        [self getComments];
    }
    [self setNavView];
    [self setupSubView];
    self.tableView.estimatedRowHeight = 80.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark -- setnavView
- (void)setNavView
{
    _nav = [[RLSNavView alloc] init];
    _nav.delegate = self;
    _nav.labTitle.text = @"意见反馈";
    [_nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [_nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [_nav.btnRight setTitle:@"提交  " forState:UIControlStateNormal];
    _nav.tag = 10;
    _nav.btnRight.titleLabel.font = font14;
    [_nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [self.view addSubview:_nav];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScrollView)];
    [_nav addGestureRecognizer:tap];
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    [self.view endEditing:YES];
    if (index == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(index == 2){
        if (_nav.tag == 11) {
            _scrollView.hidden = NO;
            _viewComplete.hidden = YES;
            _textContent.text = @"";
            _image = [UIImage imageNamed:@""];
            if ([RLSMethods login]) {
                [self getComments];
            }
            [_nav.btnRight setTitle:@"提交  " forState:UIControlStateNormal];
            _nav.tag = 10;
            [self.tableView reloadData];
            return;
        }
        [self.view endEditing:YES];
        if (_textContent.text.length == 0) {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入您的意见和反馈"];
            return;
        }
        if (_image) {
            [self upLoadImage];
        }else{
            [self feedBack];
        }
    }
}
- (void)navViewTouchButton:(UIButton *)btn
{
    if (btn.tag == 11) {
            [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)setupSubView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.scrollEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScrollView)];
    [_scrollView addGestureRecognizer:tap];
    [self.view addSubview:_scrollView];
    _viewContent = [[UIView alloc] init];
    [_scrollView addSubview:_viewContent];
    [_viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scrollView.mas_top);
        make.left.equalTo(_scrollView.mas_left);
        make.trailing.equalTo(_scrollView.mas_trailing);
        make.height.mas_equalTo(331);
    }];
    _textContent = [[UITextView alloc] init];
    _textContent.textColor = color33;
    _textContent.font = font14;
    _textContent.delegate =self;
    _textContent.layer.borderWidth = 2;
    _textContent.layer.borderColor = colorf3f4f5.CGColor;
    [_viewContent addSubview:_textContent];
    [_textContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_viewContent.mas_top).offset(14);
        make.left.equalTo(_viewContent.mas_left).offset(15);
        make.right.equalTo(_viewContent.mas_right).offset(-15);
        make.size.mas_equalTo(CGSizeMake(Width -30, 98));
    }];
    _labPlaceholderContent = [[UILabel alloc] init];
    _labPlaceholderContent.textColor = color999999;
    _labPlaceholderContent.font = font14;
    _labPlaceholderContent.text = @"请提出你的宝贵意见，我们第一时间回复你！";
    [_viewContent addSubview:_labPlaceholderContent];
    [_labPlaceholderContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_textContent.mas_left).offset(10); 
        make.top.equalTo(_textContent.mas_top).offset(10);  
    }];
    _addImgView = [UIView new];
    _addImgView.layer.borderWidth = 2;
    _addImgView.layer.borderColor = colorf3f4f5.CGColor;
    [_viewContent addSubview:_addImgView];
    _addImgeBtn = [UIImageView new];
    _addImgeBtn.image = [UIImage imageNamed:@"addImg"];
    _addImgeBtn.userInteractionEnabled = YES;
    UITapGestureRecognizer *addImgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImgBtnClick)];
    [_addImgeBtn addGestureRecognizer:addImgTap];
    [_addImgView addSubview:_addImgeBtn];
    UILabel *addImageLab = [UILabel new];
    addImageLab.text = @"添加图片 ";
    addImageLab.textColor = color999999;
    addImageLab.font = font14;
    [_addImgView addSubview:addImageLab];
    UILabel *telPhoneLab = [UILabel new];
    telPhoneLab.text = @"手机号码: ";
    telPhoneLab.font = font15;
    telPhoneLab.textColor = colorf66666;
    [_viewContent addSubview:telPhoneLab];
    _telPhoneTextField = [UITextField new];
    _telPhoneTextField.placeholder = @"请输入你的手机号";
    _telPhoneTextField.userInteractionEnabled = NO;
    if ([RLSMethods login]) {
        _telPhoneTextField.text = [RLSMethods getUserModel].showmobile;
    }else{
        _telPhoneTextField.hidden = YES;
        telPhoneLab.hidden = YES;
    }
    [_telPhoneTextField setValue:font14 forKeyPath:@"_placeholderLabel.font"];
    [_viewContent addSubview:_telPhoneTextField];
    [_addImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_textContent.mas_bottom).offset(-2); 
        make.left.equalTo(_scrollView.mas_left).offset(15);
        make.right.equalTo(_scrollView.mas_right).offset(-15);
        make.height.mas_equalTo(71);
    }];
    [_addImgeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addImgView.mas_top).offset(13);
        make.left.equalTo(_addImgView.mas_left).offset(9);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    [addImageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addImgeBtn);
        make.left.equalTo(_addImgeBtn.mas_right).offset(14);
        make.right.equalTo(_addImgView.mas_right);
        make.height.mas_equalTo(20);
    }];
    [telPhoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_addImgView.mas_bottom).offset(60);
        make.left.equalTo(_viewContent.mas_left).offset(25.5);
        make.height.mas_equalTo(30);
    }];
    [_telPhoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(telPhoneLab.mas_top);
        make.left.equalTo(telPhoneLab.mas_right).offset(8);
        make.width.mas_equalTo(207);
        make.height.mas_equalTo(30);
    }];
    if ([RLSMethods login]) {
        [_scrollView addSubview:self.tableView];
        _scrollView.contentSize = CGSizeMake(Width, _tableView.bottom);
    }
    _viewComplete = [[UIView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar)];
    _viewComplete.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_viewComplete];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"completerFeedback"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"completerFeedback"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(completeFeedBack) forControlEvents:UIControlEventTouchUpInside];
    [_viewComplete addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_viewComplete.mas_top).offset(50);
        make.centerX.equalTo(_viewComplete.mas_centerX);
    }];
    UILabel *labComplete = [[UILabel alloc] init];
    labComplete.text = @"反馈成功";
    labComplete.textColor = redcolor;
    labComplete.font = font16;
    [_viewComplete addSubview:labComplete];
    [labComplete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn.mas_bottom).offset(17.5);
        make.centerX.equalTo(btn.mas_centerX);
    }];
    UILabel *labCC = [[UILabel alloc] init];
    labCC.text = @"您的反馈我们会认真查看，并尽快修复及完善，感谢您对滚球体育一如既往的支持";
    labCC.textColor = color33;
    labCC.font = font14;
    labCC.numberOfLines = 0;
    labCC.textAlignment = NSTextAlignmentCenter;
    [_viewComplete addSubview:labCC];
    [labCC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labComplete.mas_bottom).offset(10);
        make.left.equalTo(_viewComplete.mas_left).offset(45);
        make.right.equalTo(_viewComplete.mas_right).offset(-45);
    }];
    _viewComplete.hidden = YES;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,  331 - 30, Width,Height - APPDELEGATE.customTabbar.height_myNavigationBar - _viewContent.height ) style:UITableViewStyleGrouped];  
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = colorf3f4f5;
        _tableView.scrollEnabled = NO;
        [_tableView registerClass:[RLSFeedBackCell class] forCellReuseIdentifier:@"feedBackCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.feedArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RLSFeedBackCell *feedBackCell = [tableView cellForRowAtIndexPath:indexPath];
    if (!feedBackCell) {
        feedBackCell = [[RLSFeedBackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"feedBackCell"];
    }
    feedBackCell.feedModeltmp = _feedArr[indexPath.row];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 1)];
    lineView.backgroundColor = colorf3f4f5;
    [feedBackCell.contentView addSubview:lineView];
    return feedBackCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        if (_feedArr.count > 0) {
            return 40;
        }
        return 0.0001;
    }else{
        return 0;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        if (_feedArr.count > 0) {
            UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 40)];
            UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 12.5, Width, 20)];
            titleLab.text = @"反馈记录";
            titleLab.font = font14;
            [titleView addSubview:titleLab];
            return titleView;
        }
        return [UIView new];
    }
    return [UIView new];
}
- (void)completeFeedBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _labPlaceholderContent.hidden = YES;
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (isNUll(textView.text)) {
        _labPlaceholderContent.hidden = NO;
    }else{
        _labPlaceholderContent.hidden = YES;
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    if (size.height <85) {
        size.height = 85;
    }
    [_textContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(Width -30, size.height));
    }];
    _scrollView.contentSize = CGSizeMake(Width, _viewContent.bottom);
    _tableView.frame = CGRectMake(0, _telPhoneTextField.bottom + 54, Width, 500);
}
- (void)KeyboardShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    CGRect rect =
    [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = CGRectGetHeight(rect);
    CGFloat keyboardDuration =
    [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:keyboardDuration animations:^{
        _scrollView.frame = CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - keyboardHeight);
        if (_scrollView.contentSize.height > Height - APPDELEGATE.customTabbar.height_myNavigationBar) {
        }
    }];
}
- (void)KeyboardHide:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    CGFloat keyboardDuration =[userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:keyboardDuration animations:^{
        _scrollView.frame = CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar);
    }];
}
#pragma mark - action -
- (void)addImgBtnClick {
    UIImagePickerController *pickerVC = [[UIImagePickerController alloc] init];
    pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerVC.delegate = self;
    pickerVC.allowsEditing = YES;
    [APPDELEGATE.customTabbar presentToViewController:pickerVC animated:YES completion:^{
    }];
}
#pragma  mark - imagePickerController -
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    _image = [info objectForKey:UIImagePickerControllerOriginalImage];
    _addImgeBtn.image = _image;
}
- (void)tapScrollView
{
    [self.view endEditing:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
- (void)getComments {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:@"2" forKey:@"flag"];
    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_feedback] ArrayFile:nil Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _feedArr = [[NSMutableArray alloc] initWithArray:[RLSFeedBackModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]]];
            [self.tableView reloadData];
        }else{
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
}
- (void)upLoadImage {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:@"feedBack" forKey:@"type"];
    [parameter setObject:@"json" forKey:@"returnfmt"];
    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_upLoadImg,url_feedBack_upLoadImg] ArrayFile:[NSArray arrayWithObjects:_image, nil]  FileName:@"imagefile"
      Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _urlStr = [[responseOrignal objectForKey:@"data"] objectForKey:@"picurl"];
            [self feedBack];
        }else{
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
 }
- (void)feedBack
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:@"0" forKey:@"flag"];
    [parameter setObject:_textContent.text forKey:@"content"];
    if (!isNUll(_urlStr)) {
        [parameter setObject:_urlStr forKey:@"imgurl"];
    }
    if (!isNUll(_telPhoneTextField.text)) {
        [parameter setObject:_telPhoneTextField.text forKey:@"mobile"];
    }
    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_feedback] ArrayFile:nil Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _scrollView.hidden = YES;
            _viewComplete.hidden = NO;
            [_nav.btnRight setTitle:@"关闭  " forState:UIControlStateNormal];
            _nav.tag = 11;
        }else{
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
}
@end
