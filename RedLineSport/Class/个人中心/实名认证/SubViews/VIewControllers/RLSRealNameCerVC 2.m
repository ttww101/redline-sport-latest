#import "RLSRealNameCerVC.h"
#import "RLSSuccessfulView.h"
@interface RLSRealNameCerVC ()
@property (nonatomic, strong)UIView *bkView;
@property (nonatomic, strong)UIView *bkSureView;
@property (nonatomic, strong)UILabel *labName;
@property (nonatomic, strong)UILabel *labCarNum;
@property (nonatomic, strong)UILabel *labStr;
@property (nonatomic, strong)UITextField *textName;
@property (nonatomic, strong)UITextField *textCarNum;
@property (nonatomic, strong)RLSSuccessfulView *succView;
@property (nonatomic, strong)RLSNavView *nav;
@property (nonatomic, strong)RLSUserModel *model;
@property (nonatomic, strong)NSTimer *timerl;
@property (nonatomic, strong)UIButton *sureBtn;
@property (nonatomic, assign)NSInteger timeNUm;
@end
@implementation RLSRealNameCerVC
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = colorTableViewBackgroundColor;
    [self setNavView];
    self.navigationItem.title = @"实名认证";
    [self.view addSubview:self.bkView];
    [self.view addSubview:self.succView];
    _model = [RLSMethods getUserModel];
    _timeNUm = 3;
    self.succView.hidden = YES;
    if (_model.autonym == 1) {
         [self.view addSubview:self.bkSureView];
        self.bkView.frame = CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 20 + 44, Width, 89);
        self.labStr.text = @"真实姓名和身份证是结算和认证的依据，请填写真实信息，认证后不可修改";
        [_sureBtn setTitle:@"" forState:UIControlStateHighlighted];
        _sureBtn.hidden = YES;
        self.textName.text = [NSString stringWithFormat:@"%@**",[_model.realname substringToIndex:1]];
        self.textCarNum.text = [NSString stringWithFormat:@"%@***************",[_model.cardid substringToIndex:3]];
        self.textName.enabled = NO;
        self.textCarNum.enabled = NO;
    }
    [self setAotView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark -- setnavView
- (void)setNavView{
    _nav = [[RLSNavView alloc] init];
    _nav.delegate = self;
    _nav.labTitle.text = @"实名认证";
    [_nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [_nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    _nav.btnRight.hidden = YES;
    _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sureBtn.frame = CGRectMake(Width - 10 - 60, APPDELEGATE.customTabbar.height_myStateBar, 60, APPDELEGATE.customTabbar.height_myNavigationBar -APPDELEGATE.customTabbar.height_myStateBar);
    [_sureBtn setTitle:@"提交认证" forState:UIControlStateNormal];
    [_sureBtn setTitle:@"提交认证" forState:UIControlStateHighlighted];
    _sureBtn.titleLabel.font  = font14;
    [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sureBtn addTarget:self action:@selector(sureBtnCilck) forControlEvents:UIControlEventTouchUpInside];
    [_nav addSubview:_sureBtn];
    [self.view addSubview:_nav];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScrollView)];
    [_nav addGestureRecognizer:tap];
}
- (void)sureBtnCilck{
    if (isNUll(_textName.text) || isNUll(_textCarNum.text)) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"应填项不能为空"];
        return;
    }
    if (_textName.text.length == 0 || ![RLSMethods isNameValid:_textName.text]) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"真实姓名有误"];
        return;
    }
    if (![RLSMethods chk18PaperId:_textCarNum.text]) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"身份证号码有误"];
        return;
    }
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:@"16"forKey:@"flag"];
    [parameter setObject:_textName.text forKey:@"realname"];
    [parameter setObject:_textCarNum.text forKey:@"cardid"];
    [parameter setObject:@"0" forKey:@"type"];
    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_loginAndRegister] ArrayFile:nil Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _model.autonym = 1;
            _model.cardid = _textCarNum.text;
            _model.realname = _textName.text;
            [RLSMethods updateUsetModel:_model];
            self.bkView.hidden = YES;
            self.succView.hidden = NO;
            self.labStr.hidden = YES;
            [_sureBtn setTitle:@"" forState:UIControlStateNormal];
            _timerl = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(delayMethod) userInfo:nil repeats:YES];
        }else{
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:responseOrignal[@"msg"]];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        NSLog(@"%@",responseOrignal);
        NSLog(@"%@",errorDict);
    }];
}
- (UIView *)bkSureView{
    if (!_bkSureView) {
        _bkSureView = [[UIView alloc] initWithFrame:CGRectMake(0,APPDELEGATE.customTabbar.height_myNavigationBar + 10 , Width, 44)];
        _bkSureView.backgroundColor = [UIColor whiteColor];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 150, 44)];
        lab.text = @"您已经实名认证";
        lab.textColor = color33;
        lab.font = font14;
        [_bkSureView addSubview:lab];
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(Width - 40, 9.5, 25, 25)];
        img.image = [UIImage imageNamed:@"successful"];
        [_bkSureView addSubview:img];
    }
    return _bkSureView;
}
- (RLSSuccessfulView *)succView{
    if (!_succView) {
        _succView = [[RLSSuccessfulView alloc] initWithFrame:CGRectMake(0,APPDELEGATE.customTabbar.height_myNavigationBar + 10, Width, 200)];
        _succView.img.image = [UIImage imageNamed:@"successful"];
        _succView.labSucc.text = @"恭喜您实名认证成功";
        _succView.labContent.text = @"3秒后返回安全中心";
        _succView.labContent.attributedText = [RLSMethods withContent:_succView.labContent.text contentColor:color99 WithColorText:@"3秒" textColor:redcolor];
        [_succView.btn setTitle:@"" forState:UIControlStateNormal];
    }
    return _succView;
}
- (void)tapScrollView
{
    [self.view endEditing:YES];
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
         [_timerl invalidate];
        [self.navigationController popViewControllerAnimated:YES];
    }else if(index == 2){
    }
}
- (void)delayMethod{
    _timeNUm --;
    self.succView.labContent.text = [NSString stringWithFormat:@"%ld秒后返回安全中心",_timeNUm];
    self.succView.labContent.attributedText = [RLSMethods withContent:self.succView.labContent.text contentColor:color99 WithColorText:[NSString stringWithFormat:@"%ld秒",_timeNUm] textColor:redcolor];
    if (_timeNUm == 0) {
        [_timerl invalidate];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (UIView *)bkView{
    if (!_bkView) {
        _bkView = [[UIView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 10, Width, 89)];
        _bkView.backgroundColor = [UIColor whiteColor];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, Width, 0.5)];
        lineView.backgroundColor = colorCellLine;
        [_bkView addSubview:lineView];
    }
    return _bkView;
}
- (UILabel *)labName{
    if (!_labName) {
        _labName = [[UILabel alloc] init];
        _labName.text = @"真实姓名";
        _labName.textColor = color66;
        _labName.font = font14;
    }
    return _labName;
}
- (UITextField *)textName{
    if (!_textName) {
        _textName = [[UITextField alloc] init];
        _textName.font = font14;
        _textName.textColor = color33;
        _textName.placeholder = @"提款的依据，提交后不可修改";
    }
    return _textName;
}
- (UILabel *)labCarNum{
    if (!_labCarNum) {
        _labCarNum = [[UILabel alloc] init];
        _labCarNum.text = @"身份证号";
        _labCarNum.textColor = color66;
        _labCarNum.font = font14;
    }
    return _labCarNum;
}
- (UITextField *)textCarNum{
    if (!_textCarNum) {
        _textCarNum = [[UITextField alloc] init];
        _textCarNum.font = font14;
        _textCarNum.textColor = color33;
        _textCarNum.placeholder = @"15或18位，提交后不可修改";
    }
    return _textCarNum;
}
- (UILabel *)labStr{
    if (!_labStr) {
        _labStr = [[UILabel alloc] init];
        _labStr.numberOfLines = 0;
        _labStr.textColor = color99;
        _labStr.font = font12;
        _labStr.text = @"真实姓名和身份证是结算和认证的依据，请填写真实信息，认证后不可修改";
         [_labStr setAttributedText:[RLSMethods setTextStyleWithString:_labStr.text WithLineSpace:4 WithHeaderIndent:0]];
    }
    return _labStr;
}
- (void)setAotView{
    [self.bkView addSubview:self.labName];
    [self.labName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bkView.mas_left).offset(15);
        make.top.mas_equalTo(self.bkView.mas_top);
        make.height.mas_offset(44);
        make.width.mas_offset(60);
    }];
    [self.bkView addSubview:self.textName];
    [self.textName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labName.mas_right).offset(10);
        make.top.mas_equalTo(self.bkView.mas_top);
        make.right.mas_equalTo(self.bkView.mas_right);
        make.height.mas_offset(44);
    }];
    [self.bkView addSubview:self.labCarNum];
    [self.labCarNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bkView.mas_left).offset(15);
        make.bottom.mas_equalTo(self.bkView.mas_bottom);
        make.height.mas_offset(44);
        make.width.mas_offset(60);
    }];
    [self.bkView addSubview:self.textCarNum];
    [self.textCarNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labCarNum.mas_right).offset(10);
        make.bottom.mas_equalTo(self.bkView.mas_bottom);
        make.right.mas_equalTo(self.bkView.mas_right);
        make.height.mas_offset(44);
    }];
    [self.view addSubview:self.labStr];
    [self.labStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.right.mas_equalTo(self.view.mas_right).offset(-15);
        make.top.mas_equalTo(self.bkView.mas_bottom).offset(15);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
