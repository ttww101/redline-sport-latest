#import "RLSToAnalystsVC.h"
#import "RLSSuccessfulView.h"
#import "RLSChangePhoneNumVC.h"
#import "RLSAnalystsEventFilterVC.h"
#import "RLSPictureView.h"
@interface RLSToAnalystsVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate,SuccessfulViewDelegate,AnalystsEventFilterVCDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong)UITextField *txtName;
@property (nonatomic, strong)UITextField *txtCarNum;
@property (nonatomic, strong)UITextView *txtReson;
@property (nonatomic, strong)UILabel *labPlaceholder;
@property (nonatomic, strong)UILabel *labLeagues;
@property (nonatomic, strong)UILabel *txtTelPhone;
@property (nonatomic, strong)UITextField *txtQQ;
@property (nonatomic, strong)UITextField *txtWeiXin;
@property (nonatomic, strong)UIButton *btnLeagues;
@property (nonatomic, strong)UIButton *btnPhone;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIView *firstView;
@property (nonatomic, strong)RLSSuccessfulView *succView;
@property (nonatomic, strong)RLSNavView *nav;
@property (nonatomic, assign) CGFloat textViewHeight;
@property (nonatomic, strong)RLSUserModel *Newmodel;
@property (nonatomic, strong)NSString *strLeagues;
@property (nonatomic, strong)UILabel *labReason;
@property (nonatomic, strong)UIButton *sureBtn;
@property (nonatomic, strong) RLSPictureView *picView1;
@property (nonatomic, strong) RLSPictureView *picView2;
@property (nonatomic, strong) RLSPictureView *picView3;
@property (nonatomic, assign) BOOL keyBShow;

@property (nonatomic, strong) BaseImageView *IDCard1;
@property (nonatomic, strong) BaseImageView *IDCard0;

@property (nonatomic, assign) NSInteger isCard1;
@property (nonatomic , copy) NSString *card1Pic;
@property (nonatomic , copy) NSString *card0Pic;


@end
@implementation RLSToAnalystsVC

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
    UIImage *originImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    NSData*imageData =UIImageJPEGRepresentation(originImage,0.8);
    UIImage * image = [UIImage imageWithData:imageData];
    [RLSLodingAnimateView showLodingView];
    [[RLSDCHttpRequest shareInstance]sendRequestByMethod:@"post" WithParamaters:@{@"type":@"avatar"} PathUrlL:[NSString stringWithFormat:@"http://mobile.gunqiu.com:8897%@",url_uploadAliyun] ArrayFile:[NSArray arrayWithObjects:image, nil] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        [RLSLodingAnimateView dissMissLoadingView];
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            NSDictionary *dic = responseOrignal;
            NSDictionary *contentDic = dic[@"data"];
            NSString *picUrl = contentDic[@"picurl"];
            picUrl = [NSString stringWithFormat:@"%@%@",url_pic,picUrl];
            if (self.isCard1) {
                self.IDCard1.image = originImage;
                self.card1Pic = picUrl;
            } else {
                self.IDCard0.image = originImage;
                self.card0Pic = picUrl;
            }
            
           
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

#pragma mark - Events

- (void)cardOneAction {
    self.isCard1 = true;
    UIActionSheet *sheet;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择",@"取消", nil];
    } else {
        sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"从相册选择" otherButtonTitles:@"取消", nil];
    }
    [sheet showInView:self.view];
}

- (void)cardZeroAction {
    self.isCard1 = false;
    UIActionSheet *sheet;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sheet  = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择",@"取消", nil];
    } else {
        sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"从相册选择" otherButtonTitles:@"取消", nil];
    }
    [sheet showInView:self.view];
}

#pragma mark - Lazy Load

- (BaseImageView *)IDCard1 {
    if (_IDCard1 == nil) {
        _IDCard1 = [[BaseImageView alloc]init];
        _IDCard1.contentMode = UIViewContentModeScaleAspectFill;
        _IDCard1.userInteractionEnabled = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cardOneAction)];
        [_IDCard1 addGestureRecognizer:tap];
        _IDCard1.clipsToBounds = true;
        _IDCard1.image = [UIImage imageNamed:@"add_IDCard"];
        
    }
    return _IDCard1;
}

- (BaseImageView *)IDCard0 {
    if (_IDCard0 == nil) {
        _IDCard0 = [[BaseImageView alloc]init];
        _IDCard0.contentMode = UIViewContentModeScaleAspectFill;
        _IDCard0.userInteractionEnabled = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cardZeroAction)];
        [_IDCard0 addGestureRecognizer:tap];
        _IDCard0.clipsToBounds = true;
        _IDCard0.image = [UIImage imageNamed:@"add_IDCard"];
    }
    return _IDCard0;
}

#pragma mark - ************  以下高人所写  ************

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
    [super viewWillAppear:animated];
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = colorTableViewBackgroundColor;
    _textViewHeight = 33;
    _strLeagues = @"";
    [self setNavView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)setModel:(RLSUserModel *)model{
    _model = model;
    [self.view addSubview:self.firstView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.succView];
    switch (self.type) {
        case 0:{
            self.succView.hidden = YES;
            self.tableView.hidden = NO;
            self.firstView.hidden = NO;
        }
            break;
        case 100:{
            self.succView.hidden = YES;
            self.tableView.hidden = NO;
            self.firstView.hidden = NO;
        }
            break;
        case 1:{
            self.succView.hidden = NO;
            self.tableView.hidden = YES;
            self.succView.img.image = [UIImage imageNamed:@"successful"];
            self.succView.labSucc.text = @"申请分析师成功";
            self.succView.delegate = self;
            self.succView.labContent.text = @"如需修改认证资料，请联系QQ客服：2811132884";
            self.succView.btn.hidden = YES;
            self.firstView.hidden = YES;
        }
            break;
        case 2:{
            self.succView.frame = CGRectMake(0,APPDELEGATE.customTabbar.height_myNavigationBar + 10, Width, 200);
            self.succView.hidden = NO;
            self.tableView.hidden = YES;
            self.firstView.hidden = YES;
            [_sureBtn setTitle:@"" forState:UIControlStateNormal];
            _sureBtn.enabled = NO;
        }
            break;
        case 3:{
            self.succView.hidden = NO;
            self.tableView.hidden = NO;
            self.firstView.hidden = NO;
            self.succView.img.image = [UIImage imageNamed:@"bestAni"];
            self.succView.labSucc.text = [NSString stringWithFormat:@"申请分析师失败"];
            self.succView.delegate = self;
            self.succView.labContent.text = [NSString stringWithFormat:@"原因：%@",model.failreason];
            self.succView.labContent.font = font14;
            self.succView.labContent.textColor = color33;
            self.succView.btn.hidden = YES;
            _labReason = [[UILabel alloc] initWithFrame:CGRectMake(0, 175, Width - 30, 20)];
            _labReason.textAlignment = NSTextAlignmentCenter;
            _labReason.center = CGPointMake(self.succView.center.x, _labReason.center.y);
            _labReason.text = @"请填写真实资料后重新提交审核";
            _labReason.textColor = color99;
            _labReason.font = font12;
            [self.succView addSubview:_labReason];
            self.tableView.frame = CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 10, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 10);
            self.firstView.hidden = YES;
            [_sureBtn setTitle:@"提交认证" forState:UIControlStateNormal];
        }
            break;
        default:
        {
            self.succView.hidden = YES;
            self.tableView.hidden = NO;
            self.firstView.hidden = NO;
        }
            break;
    }
    if (self.model.analyst == 2 || self.model.analyst == 3 || self.model.analyst == 5 || self.model.analyst == 1) {
        self.txtName.text = self.model.realname;
        self.txtCarNum.text = self.model.cardid;
        self.txtQQ.text = self.model.qq;
        self.txtWeiXin.text = self.model.wechat;
        self.card0Pic = self.model.cardPic2;
        self.card1Pic = self.model.cardPic1;
        
        [self.IDCard1 setImageWithUrl:[NSURL URLWithString:self.card1Pic] placeholder:[UIImage imageNamed:@"add_IDCard"]];
        [self.IDCard0 setImageWithUrl:[NSURL URLWithString:self.card1Pic] placeholder:[UIImage imageNamed:@"add_IDCard"]];
        
        if (self.model.userinfo.length > 0) {
            self.labPlaceholder.hidden = YES;
        }

        if (self.model.applyreason.length > 0) {
            self.txtReson.text = self.model.applyreason;
            self.labPlaceholder.hidden = true;
        }
        self.txtReson.text = self.model.applyreason;
        self.txtReson.frame = CGRectMake(0, 0, Width - 30, 33);
        CGRect frame = self.txtReson.frame;
        CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
        CGSize size = [self.txtReson sizeThatFits:constraintSize];
        _textViewHeight = size.height;
    }
    if (self.model.autonym == 1) {
        self.txtName.text = self.model.realname;
        self.txtCarNum.text = self.model.cardid;
    }
    _strLeagues = model.skill;
    [self.tableView reloadData];
}
- (RLSSuccessfulView *)succView{
    if (!_succView) {
        _succView = [[RLSSuccessfulView alloc] initWithFrame:CGRectMake(0,APPDELEGATE.customTabbar.height_myNavigationBar + 10, Width, 200)];
        _succView.img.image = [UIImage imageNamed:@"successful"];
        _succView.labSucc.text = @"申请提交成功";
        _succView.delegate = self;
        _succView.labContent.text = @"等待审核，如需                   请编辑后重新提交";
        [_succView.btn setTitle:@"【修改资料】" forState:UIControlStateNormal];
    }
    return _succView;
}
- (void)backView{
    [_sureBtn setTitle:@"提交认证" forState:UIControlStateNormal];
    _sureBtn.enabled = YES;
    _sureBtn.hidden = NO;
    self.tableView.frame = CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 30, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 30);
    self.tableView.hidden = NO;
    self.firstView.hidden = NO;
    self.succView.hidden = YES;
    [self.view endEditing:YES];
}
- (void)KeyboardShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    CGRect rect =
    [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = CGRectGetHeight(rect);
    CGFloat keyboardDuration =
    [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
     self.tableView.contentSize = CGSizeMake(self.tableView.contentSize.width, self.tableView.contentSize.height + keyboardHeight);
    if (self.model.analyst == 3) {
        [self.tableView setContentOffset:CGPointMake(0.0, keyboardHeight) animated:NO];
    }
    [UIView animateWithDuration:keyboardDuration animations:^{
        if (self.txtQQ.isFirstResponder || self.txtWeiXin.isFirstResponder) {
            if (self.model.analyst == 3) {
                [self.tableView setContentOffset:CGPointMake(0.0, keyboardHeight + 210) animated:NO];
            }else{
                [self.tableView setContentOffset:CGPointMake(0.0, keyboardHeight) animated:NO];
            }
        }
    }];
}
- (void)KeyboardHide:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    CGFloat keyboardDuration =[userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect rect =
    [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = CGRectGetHeight(rect);
    
    self.tableView.contentSize = CGSizeMake(self.tableView.contentSize.width, self.tableView.contentSize.height - keyboardHeight);
    [UIView animateWithDuration:keyboardDuration animations:^{
        [self.tableView setContentOffset:CGPointMake(0.0, 0.0) animated:NO];
    }];
}
- (void)textViewDidChange:(UITextView *)textView
{
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    if (size.height <=33) {
        size.height = 33;
    }
    if (_textViewHeight != size.height) {
        _textViewHeight = size.height;
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:2 inSection:0];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        [self.txtReson becomeFirstResponder];
    }
}
- (UITextView *)txtReson{
    if (!_txtReson) {
        _txtReson = [[UITextView alloc] init];
        _txtReson.font = font14;
        _txtReson.textColor = color33;
        _txtReson.delegate = self;
        _txtReson.tag = 3;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 4;
        NSDictionary *attributes = @{
                                     NSFontAttributeName:font14,
                                     NSParagraphStyleAttributeName:paragraphStyle
                                     };
        _txtReson.attributedText = [[NSAttributedString alloc] initWithString:_txtReson.text attributes:attributes];
    }
    return _txtReson;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _labPlaceholder.hidden = YES;
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([_txtReson.text isEqualToString:@""])
    {
        _labPlaceholder.hidden = NO;
    }else{
        _labPlaceholder.hidden = YES;
    }
}
#pragma mark -- setnavView
- (void)setNavView{
    _nav = [[RLSNavView alloc] init];
    _nav.delegate = self;
    _nav.labTitle.text = @"申请分析师";
    [_nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [_nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    _nav.btnRight.enabled = NO;
    _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sureBtn.frame = CGRectMake(Width - 10 - 60, APPDELEGATE.customTabbar.height_myStateBar, 60, APPDELEGATE.customTabbar.height_myNavigationBar -APPDELEGATE.customTabbar.height_myStateBar);
    [_sureBtn setTitle:@"提交认证" forState:UIControlStateNormal];
    [_sureBtn setTitle:@"提交认证" forState:UIControlStateHighlighted];
    _sureBtn.titleLabel.font  = font14;
    [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sureBtn addTarget:self action:@selector(sureBtnCilck) forControlEvents:UIControlEventTouchUpInside];
    if (_model.analyst != 1) {
        [_nav addSubview:_sureBtn];
    }
    [self.view addSubview:_nav];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScrollView)];
    [_nav addGestureRecognizer:tap];
    [self.tableView addGestureRecognizer:tap];
}
- (void)sureBtnCilck{
    if (isNUll(self.txtName.text) || isNUll(self.txtCarNum.text) || isNUll(self.txtReson.text) || isNUll(self.txtTelPhone.text)  ) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"应填项不能为空"];
        return;
    }
    if (self.txtQQ.text.length == 0 && self.txtWeiXin.text.length == 0) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"QQ或微信,请至少填写一项"];
        return;
    }
    if (self.txtName.text.length == 0 ) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"姓名不能为空"];
        return;
    }
    if (![RLSMethods isNameValid:self.txtName.text]) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"真实姓名有误"];
        return;
    }
    if (self.txtCarNum.text.length == 0) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"身份证不能为空"];
        return;
    }
    
    if ([self.txtCarNum.text length] != 15 && [self.txtCarNum.text length] != 18) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"身份证号码有误"];
        return;
    }
    
    if ([self.txtCarNum.text containsString:@"*"]) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请再次输入身份证号码"];
        return;
    }
    
    if (!self.card1Pic) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请添加身份证照片"];
        return;
    }
    
    if (!self.card0Pic) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请添加身份证照片"];
        return;
    }
    
    if (self.txtReson.text.length == 0) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"申请理由不能为空"];
        return;
    }
    if (self.txtTelPhone.text.length == 0) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"手机号不能为空"];
        return;
    }
    if (self.txtTelPhone.text.length!= 11 ) { 
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"手机号不正确"];
        return;
    }
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:@"15"forKey:@"flag"];
    [parameter setObject:self.txtWeiXin.text forKey:@"wechat"];
    [parameter setObject:self.txtQQ.text forKey:@"qq"];
    [parameter setObject:self.txtName.text forKey:@"realname"];
    [parameter setObject:self.txtTelPhone.text forKey:@"mobile"];
    [parameter setObject:self.txtReson.text forKey:@"applyreason"];
    [parameter setObject:self.txtCarNum.text forKey:@"cardid"];
    [parameter setObject:@"" forKey:@"league"];
    [parameter setObject:@"0" forKey:@"type"];
    [parameter setObject:@"account_shenqingfenxishi" forKey:@"tag"];
    [parameter setObject:self.card1Pic forKey:@"cardPic1"];
    [parameter setObject:self.card0Pic forKey:@"cardPic2"];
    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_loginAndRegister] ArrayFile:nil Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            self.tableView.hidden = YES;
            self.firstView.hidden = YES;
            self.succView.hidden = NO;
            [_sureBtn setTitle:@"" forState:UIControlStateNormal];
            _sureBtn.hidden = YES;
            self.succView.frame = CGRectMake(0,APPDELEGATE.customTabbar.height_myNavigationBar + 10, Width, 200);
            self.succView.img.image = [UIImage imageNamed:@"successful"];
            self.succView.labSucc.text = @"申请提交成功";
            self.succView.delegate = self;
            self.succView.labContent.text = @"等待审核，如需                   请编辑后重新提交";
            [self.succView.btn setTitle:@"【修改资料】" forState:UIControlStateNormal];
            self.succView.btn.hidden = NO;
            self.succView.btn.enabled = YES;
            self.succView.labContent.font = font14;
            self.succView.labContent.textColor = color99;
            [self.view addSubview:self.succView];
            self.model.analyst = 2;
            self.model.autonym = 1;
            self.model.skill = _strLeagues;
            _labReason.hidden = YES;
            [RLSMethods updateUsetModel:self.model];
            [self.tableView reloadData];
        }else{
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:responseOrignal[@"msg"]];
            NSLog(@"%@",responseOrignal);
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
        NSLog(@"%@",responseOrignal);
        NSLog(@"%@",errorDict);
    }];
}
- (void)tapScrollView
{
    [self.view endEditing:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)setSubView{
}
- (UIView *)firstView{
    if (!_firstView) {
        _firstView = [[UIView alloc] initWithFrame:CGRectMake(0,APPDELEGATE.customTabbar.height_myNavigationBar , Width, 30)];
        _firstView.backgroundColor = colorFFFFDF;
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, Width - 50, 30)];
        lab.text = @"为了更好的为你服务，请务必填写真实信息";
        lab.font = font12;
        lab.textColor = colorFF9900;
        [_firstView addSubview:lab];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(Width - 30, 0, 30, 30);
        [btn setImage:[UIImage imageNamed:@"colose"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(coloseClick) forControlEvents:UIControlEventTouchUpInside];
        [_firstView addSubview:btn];
    }
    return _firstView;
}
- (void)coloseClick{
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.frame = CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar);
    }];
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 30, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar - 30) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.backgroundColor = colorTableViewBackgroundColor;
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _tableView;
}
- (UILabel *)labPlaceholder{
    if (!_labPlaceholder) {
        _labPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(4, 0, Width - 30, 30)];
        _labPlaceholder.text = @"请填写您成为分析师的理由吧";
        _labPlaceholder.font = font14;
        _labPlaceholder.textColor = colorCC;
    }
    return _labPlaceholder;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }else if (section == 1){
        return 3;
    }
    return 3;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *bkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 210)];
        bkView.backgroundColor = [UIColor clearColor];
        if (self.model.analyst == 1) {
            return bkView;
        }else if (self.model.analyst == 3 ){
            self.succView.frame = CGRectMake(0, 0, Width , 220);
            [bkView addSubview:self.succView];
            return bkView;
        }
    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 2) {
        return 140;
    }
    return 73;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *acell = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:acell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:acell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    while ([cell.contentView.subviews lastObject]!= nil) {
        [[cell.contentView.subviews lastObject] removeFromSuperview];
    }
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = colorCellLine;
    [cell.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(cell.contentView.mas_bottom);
        make.left.equalTo(cell.contentView.mas_left);
        make.size.mas_equalTo(CGSizeMake(Width, 0.6));
    }];
    UILabel *labStr = [[UILabel alloc] init];
    labStr.font = font14;
    labStr.textColor = color99;
    [cell.contentView addSubview:labStr];
    [labStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cell.contentView.mas_left).offset(15);
        make.top.mas_equalTo(cell.contentView.mas_top).offset(10);
        make.height.mas_offset(20);
    }];
    UILabel *labRealStr = [[UILabel alloc] init];
    labRealStr.font = font13;
    labRealStr.textColor = redcolor;
    labRealStr.text = @" *必填";
    [cell.contentView addSubview:labRealStr];
    [labRealStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(labStr.mas_right);
        make.centerY.mas_equalTo(labStr.mas_centerY);
    }];
    UIImageView *imageMore = [[UIImageView alloc] initWithFrame:CGRectMake(Width - 15 - 7, 73/2 + 8, 7, 14)];
    imageMore.image = [UIImage imageNamed:@"meRight"];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                labStr.text = @"真实姓名";
                [cell.contentView addSubview:self.txtName];
                [self.txtName mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(cell.contentView.mas_left).offset(15);
                    make.right.mas_equalTo(cell.contentView.mas_right).offset(-15);
                    make.top.mas_offset(73 / 2);
                    make.height.mas_offset(30);
                }];
            }
                break;
            case 1:{
                labStr.text = @"身份证号";
                [cell.contentView addSubview:self.txtCarNum];
                [self.txtCarNum mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(cell.contentView.mas_left).offset(15);
                    make.right.mas_equalTo(cell.contentView.mas_right).offset(-15);
                    make.top.mas_offset(73 / 2);
                    make.height.mas_offset(30);
                }];
            }
                break;
            case 2:{
                labStr.text = @"上传身份证";
                [cell.contentView addSubview:self.IDCard1];
                [cell.contentView addSubview:self.IDCard0];
                CGFloat space = ( Width - 300 - 10) / 2;
                self.IDCard1.frame = CGRectMake(space, 73 / 2, 150, 80);
                self.IDCard0.frame = CGRectMake(self.IDCard1.right + 10, 73 / 2, 150, 80);
            }
                break;
                
            case 3:{
                labStr.text = @"申请理由";
                self.txtReson.frame =CGRectMake(11, 40 , Width - 22, _textViewHeight );
                [cell.contentView addSubview:self.txtReson];
                [self.txtReson addSubview:self.labPlaceholder];
                lineView.hidden = YES;
            }
                break;
            default:
                break;
        }
    }
    else{
        switch (indexPath.row) {
            case 0:{
                labStr.text = @"手机号码";
                [cell.contentView addSubview:self.txtTelPhone];
                [self.txtTelPhone mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(cell.contentView.mas_left).offset(15);
                    make.right.mas_equalTo(cell.contentView.mas_right).offset(-15);
                    make.top.mas_offset(73 / 2);
                    make.height.mas_offset(30);
                }];
                [cell.contentView addSubview:imageMore];
                _btnPhone = [UIButton  buttonWithType:UIButtonTypeCustom];
                _btnPhone.frame = CGRectMake(0, 0, Width, 73);
                _btnPhone.tag = 2;
                [cell.contentView addSubview:_btnPhone];
                [_btnPhone addTarget:self action:@selector(clickPhone:) forControlEvents:UIControlEventTouchUpInside];
            }
                break;
            case 1:{
                labStr.text = @"QQ";
                [cell.contentView addSubview:self.txtQQ];
                [self.txtQQ mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(cell.contentView.mas_left).offset(15);
                    make.right.mas_equalTo(cell.contentView.mas_right).offset(-15);
                    make.top.mas_offset(73 / 2);
                    make.height.mas_offset(30);
                }];
                labRealStr.hidden = YES;
            }
                break;
            case 2:{
                labStr.text = @"微信";
                [cell.contentView addSubview:self.txtWeiXin];
                [self.txtWeiXin mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(cell.contentView.mas_left).offset(15);
                    make.right.mas_equalTo(cell.contentView.mas_right).offset(-15);
                    make.top.mas_offset(73 / 2);
                    make.height.mas_offset(30);
                }];
                labRealStr.hidden = YES;
                lineView.hidden = YES;
            }
                break;
            default:
                break;
        }
    }
    
//    if (self.model.analyst == 1) {
//        self.txtName.enabled = NO;
//        self.txtCarNum.enabled = NO;
//        self.txtWeiXin.enabled = NO;
//        self.txtQQ.enabled = NO;
//        self.txtReson.editable = NO;
//        imageMore.hidden = YES;
//        _btnPhone.enabled = NO;
//    }
//    if (self.model.autonym == 1) {
//        self.txtName.enabled = NO;
//        self.txtCarNum.enabled = NO;
//    }
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        if (self.model.analyst == 3) {
            return 230;
        }else if (self.model.analyst == 1){
            return 210;
        }
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return 60;
    }
    return 0.00001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        UIView *bkView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 42)];
        bkView.backgroundColor = [UIColor clearColor];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, Width, 42)];
        lab.textColor = color99;
        lab.font = font12;
        lab.text = @"QQ微信请至少填写一项";
        [bkView addSubview:lab];
        UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, Width - 30, 30)];
        lab2.textColor = color99;
        lab2.font = font12;
        lab2.text = @"申请分析师要求:注册满7天，且近7天竞猜≥15场、胜率≥70%、盈利率为正。";
        lab2.numberOfLines = 0;
        lab2.hidden=YES;
        [bkView addSubview:lab2];
        return bkView;
    }
    return nil;
}
- (UITextField *)txtName{
    if (!_txtName) {
        _txtName = [[UITextField alloc] init];
        _txtName.font = font14;
        _txtName.textColor = color33;
        _txtName.tag = 1;
        _txtName.placeholder = @"请填写真实姓名，用于结算与认证";
    }
    return _txtName;
}
- (UITextField *)txtCarNum{
    if (!_txtCarNum) {
        _txtCarNum = [[UITextField alloc] init];
        _txtCarNum.font = font14;
        _txtCarNum.textColor = color33;
        _txtCarNum.tag = 2;
        _txtCarNum.placeholder = @"请填写真实身份证号，用于结算与认证";
    }
    return _txtCarNum;
}
- (UILabel *)labLeagues{
    if (!_labLeagues) {
        _labLeagues = [[UILabel alloc] init];
        _labLeagues.font = font14;
        _labLeagues.textColor = colorCC;
        _labLeagues.text = @"请选择擅长的联赛，最多5个";
    }
    return _labLeagues;
}
- (RLSPictureView *)picView1
{
    if (!_picView1) {
        _picView1 = [[RLSPictureView alloc] init];
        _picView1.detailText = @"手持身份证";
    }
    return _picView1;
}
- (RLSPictureView *)picView2
{
    if (!_picView2) {
        _picView2 = [[RLSPictureView alloc] init];
        _picView2.detailText = @"身份证正面";
    }
    return _picView2;
}
- (RLSPictureView *)picView3
{
    if (!_picView3) {
        _picView3 = [[RLSPictureView alloc] init];
        _picView3.detailText = @"身份证反面";
    }
    return _picView3;
}
- (UILabel *)txtTelPhone{
    if (!_txtTelPhone) {
        _txtTelPhone = [[UILabel alloc] init];
        _txtTelPhone.font = font14;
        _txtTelPhone.textColor = color33;
        _txtTelPhone.text = _model.mobile;
        _txtTelPhone.tag = 4;
    }
    return _txtTelPhone;
}
- (UITextField *)txtQQ{
    if (!_txtQQ) {
        _txtQQ = [[UITextField alloc] init];
        _txtQQ.font = font14;
        _txtQQ.textColor = color33;
        _txtQQ.delegate =self;
        _txtQQ.placeholder = @"请填写常用的QQ号";
        _txtQQ.tag = 5;
    }
    return _txtQQ;
}
- (UITextField *)txtWeiXin{
    if (!_txtWeiXin) {
        _txtWeiXin = [[UITextField alloc] init];
        _txtWeiXin.font = font14;
        _txtWeiXin.textColor = color33;
        _txtWeiXin.tag = 6;;
        _txtWeiXin.delegate =self;
        _txtWeiXin.placeholder = @"请填写常用的微信号";
    }
    return _txtWeiXin;
}

- (void)clickPhone:(UIButton *)btn{
    if (self.model.analyst == 1) {
        return;
    }
    if (btn.tag == 1) {
        RLSAnalystsEventFilterVC *change = [[RLSAnalystsEventFilterVC alloc] init];
        change.hidesBottomBarWhenPushed = YES;
        change.delegate = self;
        [APPDELEGATE.customTabbar pushToViewController:change animated:YES];
    }else{
        RLSChangePhoneNumVC *change = [[RLSChangePhoneNumVC alloc] init];
        change.hidesBottomBarWhenPushed = YES;
        [APPDELEGATE.customTabbar pushToViewController:change animated:YES];
    }
}
- (void)backStr:(NSString *)str{
    _strLeagues = str;
    if (str.length > 0) {
        self.labLeagues.text = str;
        self.labLeagues.textColor = color33;
    }else{
        self.labLeagues.textColor = colorCC;
        self.labLeagues.text = @"请选择擅长的联赛，最多5个";
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2 && indexPath.row == 0) {
    }
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(index == 2){
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([textView isFirstResponder]) {
        if ([[[textView textInputMode] primaryLanguage] isEqualToString:@"emoji"] ||
            ![[textView textInputMode] primaryLanguage] ) {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"暂不支持输入表情符号"];
            return NO;
        }
    }
    if ([textView isFirstResponder]) {
        if ([self stringContainsEmoji:text]) {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"暂不支持输入表情符号"];
            return NO;
        }
    }
    return YES;
}
- (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
