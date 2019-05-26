#import "ImageTextAttachment.h"
#import "NSAttributedString+html.h"
#import "PictureModel.h"
#import "NSString+Regular.h"
#import "NSAttributedString+RichText.h"
#define IMAGE_MAX_SIZE (Width - 30)
#import "RLSSelectedViewOfFabuTuijian.h"
#import "RLSZhumaViewOfFabuTuijian.h"
#import "RLSRelRecNewVC.h"
#import "RLSTitleIndexView.h"
#import "RLSFaBuSucceedVCViewController.h"
#import "RLSToAnalystsVC.h"
#import "PlayControl.h"
#import "showMessageView.h"

@interface RLSRelRecNewVC ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,SelectedViewOfFabuTuijianDelegate,ZhumaViewOfFabuTuijianDelegate,TitleIndexViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UITextField *textFiled;
@property (nonatomic, strong) RLSNavView *nav;
@property (nonatomic, strong) UIScrollView *ScrollView;
@property (nonatomic, strong) RLSTitleIndexView *titleView;
@property (nonatomic, strong) UIView *viewDetialTitle;
@property (nonatomic, strong) UIView *viewDetial;
@property (nonatomic, strong) RLSZhumaViewOfFabuTuijian *viewZhuma;
@property (nonatomic, strong) UIView *ViewTextTitle;
@property (nonatomic, strong) UIView *viewDescribe;
@property (nonatomic, strong) NSMutableArray *arrSelectedView;
@property (nonatomic, retain)UIView *buttomView;
@property (nonatomic, retain)UIButton *btnPhoto;
@property (nonatomic, assign) CGFloat textViewHeight;
@property (nonatomic, strong) UILabel *textViewPlaceholder;
@property (nonatomic,strong) NSMutableAttributedString * locationStr;
@property (nonatomic, assign)NSRange textViewSelectedRange;
@property (nonatomic, retain)NSMutableArray *arrPhoto;
@property (nonatomic, strong) NSString *choice;
@property (nonatomic, strong) NSString *play;
@property (nonatomic, strong) NSString *playContent;
@property (nonatomic, strong) NSString *multiple;
@property (nonatomic, strong) NSString *compa;
@property (nonatomic, assign) NSInteger projectPrice;
@property (nonatomic, strong) NSString *choiceMultiple;
@property (nonatomic, strong) NSString *yaChoiceMultiple;
@property (nonatomic, assign) BOOL isTouchedFabuBtn;
@property (nonatomic, strong) UIView  *rqBaseView;
@property (nonatomic, strong) UIView  *dxBaseView;
@property (nonatomic, strong) UIButton *btnOne;
@property (nonatomic, strong) UIButton *btnTwo;
@property (nonatomic, strong) UIButton *btnThree;
@property (nonatomic, strong) UILabel  *labRQ;
@property (nonatomic, strong) UIButton *btnZhu;
@property (nonatomic, strong) UIButton *btnKe;
@property (nonatomic, strong) UIButton *yaCenterBtn;

@property (nonatomic, strong) UILabel  *labDXQ;
@property (nonatomic, strong) UIButton *btnBig;
@property (nonatomic, strong) UIButton *btnLittle;
@property (nonatomic, strong) UIButton *dxCenterBtn;
@property (nonatomic, assign) int tuijianBackID;
@property (nonatomic , strong) RLSUserModel *user_Model;
@property (nonatomic , strong) UISwitch *switchBtn;

@property (nonatomic , strong) PlayControl *leftControl;
@property (nonatomic , strong) PlayControl *centerControl;
@property (nonatomic , strong) PlayControl *rightControl;
@property (nonatomic, strong) UIView  *oddsBgView;
@property (nonatomic, assign) CGFloat  oddsBtnWidth;
@property (nonatomic, strong) UILabel  *oddsLab;

@property (nonatomic, strong) UILabel  *adaDetaiLab;
@property (nonatomic, strong) UILabel  *describeLab;
@property (nonatomic, strong) BaseImageView *warningIV;
@property (nonatomic, strong) UIView  *coverView;
@property (nonatomic , strong) UISwitch *currentSwitch;


@end
@implementation RLSRelRecNewVC

#pragma mark -  UITextFieldDelegate

// 简易写法 限制字数不是很准确
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (string.length == 0) return YES;
    NSInteger existedLength = textField.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if (existedLength - selectedLength + replaceLength > 16){
        return NO;
    }
    return YES;
}

- (void)setLayout:(CGFloat)height {
    _textView.frame = CGRectMake(15, _adaDetaiLab.bottom + 10, Width - 30, height);
    _warningIV.top = _textView.bottom + 10;
    _describeLab.top = _textView.bottom + 10;
    _viewZhuma.top = _describeLab.bottom + 10;
    _ScrollView.contentSize = CGSizeMake(Width, _viewZhuma.bottom + 10);
}

#pragma mark - Lazy Load

- (UIScrollView *)ScrollView
{
    if (!_ScrollView) {
        _ScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _nav.bottom, Width, Height -_nav.bottom)];
        _ScrollView.backgroundColor = [UIColor whiteColor];
        _ScrollView.scrollEnabled = YES;
        [self addPlayType]; // 添加顶层 玩法切换
        //        [_ScrollView addSubview:self.viewDetial];
        [_ScrollView addSubview:self.oddsBgView];
//        [_ScrollView addSubview:self.dxBaseView];
        [_ScrollView addSubview:self.ViewTextTitle];
        [_ScrollView addSubview:self.textFiled];
        [_ScrollView addSubview:self.adaDetaiLab];
        [_ScrollView addSubview:self.textView];
        [_ScrollView addSubview:self.warningIV];
        [_ScrollView addSubview:self.describeLab];
        [_ScrollView addSubview:self.coverView];
        [_ScrollView addSubview:self.viewZhuma];
        _ScrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _ScrollView.contentSize = CGSizeMake(Width,  self.viewZhuma.bottom);
    }
    return _ScrollView;
}


- (UIView *)viewDetialTitle
{
    if (!_viewDetialTitle) {
        _viewDetialTitle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 42)];
        _viewDetialTitle.backgroundColor = [UIColor whiteColor];
        _viewDetialTitle.userInteractionEnabled = true;
    }
    return _viewDetialTitle;
}

- (UIView *)viewDetial
{
    if (!_viewDetial) {
        _arrSelectedView = [NSMutableArray array];
        _viewDetial = [[UIView alloc] initWithFrame:CGRectMake(0, 30, Width, 34)];
        _viewDetial.backgroundColor = [UIColor whiteColor];
        [_viewDetial addSubview:self.btnOne];
        [_viewDetial addSubview:self.btnTwo];
        [_viewDetial addSubview:self.btnThree];
    }
    return _viewDetial;
}


- (UIView *)rqBaseView {
    if (!_rqBaseView) {
        _rqBaseView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, Width, 34)];
        _rqBaseView.backgroundColor = [UIColor whiteColor];
        [_rqBaseView addSubview:self.btnZhu];
        [_rqBaseView addSubview:self.yaCenterBtn];
        [_rqBaseView addSubview:self.btnKe];
    }
    return _rqBaseView;
}

- (UIView *)dxBaseView {
    if (!_dxBaseView) {
        _dxBaseView = [[UIView alloc] initWithFrame:CGRectMake(0, 30 , Width, 34)];
        [_dxBaseView addSubview:self.btnBig];
        [_dxBaseView addSubview:self.dxCenterBtn];
        [_dxBaseView addSubview:self.btnLittle];
    }
    return _dxBaseView;
}

- (UIView *)oddsBgView {
    if (_oddsBgView == nil) {
        _oddsBgView = [[UIView alloc] initWithFrame:CGRectMake(0, _viewDetialTitle.bottom, Width, 44+20+20)];
        [_oddsBgView addSubview:self.labRQ];
        [_oddsBgView addSubview:self.viewDetial];
        [_oddsBgView addSubview:self.rqBaseView];
        [_oddsBgView addSubview:self.dxBaseView];
        [_oddsBgView addSubview:self.oddsLab];
        UIView *spaceView = [[UIView alloc]initWithFrame:CGRectMake(0, 74, Width, 10)];
        spaceView.backgroundColor = UIColorHex(#E5E5E5);
        [_oddsBgView addSubview:spaceView];
    }
    return _oddsBgView;
}

- (UILabel *)oddsLab {
    if (_oddsLab == nil) {
        _oddsLab = [[UILabel alloc]initWithFrame:CGRectMake(15, self.labRQ.bottom + 10, 60, 20)];
        _oddsLab.textColor = UIColorHex(#6C6C6C);
        _oddsLab.textAlignment = NSTextAlignmentLeft;
        _oddsLab.font = [UIFont systemFontOfSize:12];
        _oddsLab.hidden = true;
    }
    return _oddsLab;
}

- (void)addPlayType {
    [self.ScrollView addSubview:self.viewDetialTitle];
    CGFloat width = self.view.width / 3;
    self.leftControl = [[PlayControl alloc]initWithFrame:CGRectMake(0, 0, width, self.viewDetialTitle.height - 1)];
    self.leftControl.title = @"胜平负";
    self.leftControl.userInteractionEnabled = true;
    [self.viewDetialTitle addSubview:self.leftControl];
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbtn addTarget:self action:@selector(spfAction) forControlEvents:UIControlEventTouchUpInside];
    leftbtn.frame = self.leftControl.frame;
    [self.viewDetialTitle addSubview:leftbtn];
    
    self.centerControl = [[PlayControl alloc]initWithFrame:CGRectMake(width, 0, width, self.viewDetialTitle.height - 1)];
    self.centerControl.title = @"让球";
    [self.viewDetialTitle addSubview:self.centerControl];
    UIButton *centerbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [centerbtn addTarget:self action:@selector(yapanAction) forControlEvents:UIControlEventTouchUpInside];
    centerbtn.frame = self.centerControl.frame;
    [self.viewDetialTitle addSubview:centerbtn];
    
    self.rightControl = [[PlayControl alloc]initWithFrame:CGRectMake(2 * width, 0, width, self.viewDetialTitle.height - 1)];
    self.rightControl.title = @"进球数";
    [self.viewDetialTitle addSubview:self.rightControl];
    UIButton *rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbtn addTarget:self action:@selector(dxAction) forControlEvents:UIControlEventTouchUpInside];
    rightbtn.frame = self.rightControl.frame;
    [self.viewDetialTitle addSubview:rightbtn];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.viewDetialTitle.height - 1, Width, 1)];
    line.backgroundColor = UIColorHex(eeeeee);
    [self.viewDetialTitle addSubview:line];
    
    self.leftControl.isSelected = true;
    self.centerControl.isSelected = false;
    self.rightControl.isSelected = false;
    self.viewDetial.hidden = false;
    self.rqBaseView.hidden = true;
    self.dxBaseView.hidden = true;

}

#pragma mark - Events

- (void)spfAction {
    if (_model.spf.count == 0) {
        [showMessageView showMessage:@"胜平负暂无推荐"];
        return;
    }
    self.leftControl.isSelected = true;
    self.centerControl.isSelected = false;
    self.rightControl.isSelected = false;
    self.viewDetial.hidden = false;
    self.rqBaseView.hidden = true;
    self.dxBaseView.hidden = true;
    
}

- (void)yapanAction {
    if (_model.rq.count == 0) {
        [showMessageView showMessage:@"让球暂无推荐"];
        return;
    }
    self.leftControl.isSelected = false;
    self.centerControl.isSelected = true;
    self.rightControl.isSelected = false;
    self.viewDetial.hidden = true;
    self.rqBaseView.hidden = false;
    self.dxBaseView.hidden = true;
    self.yaCenterBtn.userInteractionEnabled = false;
}

- (void)dxAction {
    if (_model.dx.count == 0) {
        [showMessageView showMessage:@"进球数暂无推荐"];
        return;
    }
    self.leftControl.isSelected = false;
    self.centerControl.isSelected = false;
    self.rightControl.isSelected = true;
    self.viewDetial.hidden = true;
    self.rqBaseView.hidden = true;
    self.dxBaseView.hidden = false;
    self.dxCenterBtn.userInteractionEnabled = false;
    
}



#pragma mark - ************  以下高人所写  ************



- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
    [[RLSUMStatisticsMgr sharedInstance] viewStaticsBeginWithMarkStr:@"RLSRelRecNewVC"] ;
    [[RLSDependetNetMethods sharedInstance] loadUserInfocompletion:^(RLSUserModel *userback) {
        _user_Model = userback;
    } errorMessage:^(NSString *msg) {
    }];
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma mark -- setnavView
- (void)setNavView{
    _nav = [[RLSNavView alloc] init];
    _nav.delegate = self;
    UIView *viewT = [[UIView alloc] initWithFrame:_nav.labTitle.frame];
    [_nav addSubview:viewT];
    UILabel *_labVS = [[UILabel alloc] init];
    _labVS.textColor = [UIColor whiteColor];
    _labVS.font = font16;
    _labVS.text = @"vs";
    [viewT addSubview:_labVS];
    [_labVS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(viewT.mas_centerY);
        make.centerX.equalTo(viewT.mas_centerX);
    }];
    UILabel *labHome = [[UILabel alloc] init];
    labHome.textColor = [UIColor whiteColor];
    labHome.font = font16;
    labHome.text = _model.hometeam;
    labHome.textAlignment = NSTextAlignmentRight;
    [viewT addSubview:labHome];
    [labHome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(viewT.mas_centerY);
        make.right.equalTo(_labVS.mas_left).offset(-10);
        make.width.mas_equalTo(125*Scale_Ratio_width);
    }];
    UILabel *labGuest = [[UILabel alloc] init];
    labGuest.textColor = [UIColor whiteColor];
    labGuest.font = font16;
    labGuest.text = _model.guestteam;
    [viewT addSubview:labGuest];
    [labGuest mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(viewT.mas_centerY);
        make.left.equalTo(_labVS.mas_right).offset(10);
        make.width.mas_equalTo(125*Scale_Ratio_width);
    }];
    [_nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [_nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [_nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [self.view addSubview:_nav];
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(index == 2){
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.oddsBtnWidth = (self.view.width - 90 ) / 3;
    [self updateModel];
    [self setNavView];
    self.view.backgroundColor = [UIColor whiteColor];
    _textViewHeight = 140;
    _multiple = @"1";
    _projectPrice = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapButtomView)];
    [self.view addGestureRecognizer:tap];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[RLSUMStatisticsMgr sharedInstance] viewStaticsEndWithMarkStr:@"RLSRelRecNewVC"];
}
- (void)setupModel:(RLSDan_StringMatchsModel *)model{
    _model = model;
    [self.view addSubview:self.ScrollView];
    [self.view addSubview:self.buttomView];
    
    self.viewZhuma.priceList = _model.priceList;
    if (model.spf.count > 0) {
        RLSDxModel *dxModel = model.spf[0];
        self.oddsLab.text = dxModel.company;
        [self.btnOne setTitle:[NSString stringWithFormat:@"胜        %.2f",[dxModel.UpOdds floatValue]] forState:UIControlStateNormal];
        [self.btnOne setAttributedTitle:[RLSMethods withContent:self.btnOne.titleLabel.text WithContColor:UIColorHex(#151515) WithContentFont:font12 WithText:@"胜" WithTextColor:UIColorHex(#151515) WithTextFont:font12] forState:UIControlStateNormal];
        [self.btnOne setAttributedTitle:[RLSMethods withContent:self.btnOne.titleLabel.text WithContColor:[UIColor whiteColor] WithContentFont:font12 WithText:self.btnOne.titleLabel.text WithTextColor:[UIColor whiteColor] WithTextFont:font12] forState:UIControlStateSelected];
        [self.btnTwo setTitle:[NSString stringWithFormat:@"平        %.2f",[dxModel.Goal floatValue]] forState:UIControlStateNormal];
        [self.btnTwo setAttributedTitle:[RLSMethods withContent:self.btnTwo.titleLabel.text WithContColor:UIColorHex(#151515) WithContentFont:font12 WithText:@"平" WithTextColor:UIColorHex(#151515) WithTextFont:font12] forState:UIControlStateNormal];
        [self.btnTwo setAttributedTitle:[RLSMethods withContent:self.btnTwo.titleLabel.text WithContColor:[UIColor whiteColor] WithContentFont:font12 WithText:self.btnTwo.titleLabel.text WithTextColor:[UIColor whiteColor] WithTextFont:font12] forState:UIControlStateSelected];
        [self.btnThree setTitle:[NSString stringWithFormat:@"负        %.2f",[dxModel.DownOdds floatValue]] forState:UIControlStateNormal];
        [self.btnThree setAttributedTitle:[RLSMethods withContent:self.btnThree.titleLabel.text WithContColor:UIColorHex(#151515) WithContentFont:font12 WithText:@"负" WithTextColor:UIColorHex(#151515) WithTextFont:font12] forState:UIControlStateNormal];
        [self.btnThree setAttributedTitle:[RLSMethods withContent:self.btnThree.titleLabel.text WithContColor:[UIColor whiteColor] WithContentFont:font12 WithText:self.btnThree.titleLabel.text WithTextColor:[UIColor whiteColor] WithTextFont:font12] forState:UIControlStateSelected];
    }
    
    if (model.rq.count > 0) {
        RLSDxModel *dxModel = model.rq[0];
        self.oddsLab.text = dxModel.company;
        [self.btnZhu setTitle:[NSString stringWithFormat:@"主        %.2f",[dxModel.UpOdds floatValue]] forState:UIControlStateNormal];
        [self.btnZhu setAttributedTitle:[RLSMethods withContent:self.btnZhu.titleLabel.text WithContColor:UIColorHex(#151515) WithContentFont:font12 WithText:@"主" WithTextColor:UIColorHex(#151515) WithTextFont:font12] forState:UIControlStateNormal];
        [self.btnZhu setAttributedTitle:[RLSMethods withContent:self.btnZhu.titleLabel.text WithContColor:[UIColor whiteColor] WithContentFont:font12 WithText:self.btnZhu.titleLabel.text WithTextColor:[UIColor whiteColor] WithTextFont:font12] forState:UIControlStateSelected];
        
        
        [self.yaCenterBtn setTitle:[NSString stringWithFormat:@"%@",dxModel.Goal] forState:UIControlStateNormal];
        [self.yaCenterBtn setAttributedTitle:[RLSMethods withContent:self.yaCenterBtn.titleLabel.text WithContColor:UIColorHex(#151515) WithContentFont:font12 WithText:@"" WithTextColor:UIColorHex(#151515) WithTextFont:font12] forState:UIControlStateNormal];
        [self.yaCenterBtn setAttributedTitle:[RLSMethods withContent:self.yaCenterBtn.titleLabel.text WithContColor:[UIColor whiteColor] WithContentFont:font12 WithText:self.yaCenterBtn.titleLabel.text WithTextColor:[UIColor whiteColor] WithTextFont:font12] forState:UIControlStateSelected];
        [self.btnKe setTitle:[NSString stringWithFormat:@"客        %.2f",[dxModel.DownOdds floatValue]] forState:UIControlStateNormal];
        [self.btnKe setAttributedTitle:[RLSMethods withContent:self.btnKe.titleLabel.text WithContColor:UIColorHex(#151515) WithContentFont:font12 WithText:@"客" WithTextColor:UIColorHex(#151515) WithTextFont:font12] forState:UIControlStateNormal];
        [self.btnKe setAttributedTitle:[RLSMethods withContent:self.btnKe.titleLabel.text WithContColor:[UIColor whiteColor] WithContentFont:font12 WithText:self.btnKe.titleLabel.text WithTextColor:[UIColor whiteColor] WithTextFont:font12] forState:UIControlStateSelected];
    }
    
    if (model.dx.count > 0) {
        RLSDxModel *dxModel = model.dx[0];
        self.oddsLab.text = dxModel.company;
        [self.btnBig setTitle:[NSString stringWithFormat:@"大        %.2f", [dxModel.UpOdds floatValue]] forState:UIControlStateNormal];
        [self.btnBig setAttributedTitle:[RLSMethods withContent:self.btnBig.titleLabel.text WithContColor:UIColorHex(#151515) WithContentFont:font12 WithText:@"大" WithTextColor:UIColorHex(#151515) WithTextFont:font12] forState:UIControlStateNormal];
        [self.btnBig setAttributedTitle:[RLSMethods withContent:self.btnBig.titleLabel.text WithContColor:[UIColor whiteColor] WithContentFont:font12 WithText:self.btnBig.titleLabel.text WithTextColor:[UIColor whiteColor] WithTextFont:font12] forState:UIControlStateSelected];
        
        
        
        [self.dxCenterBtn setTitle:[NSString stringWithFormat:@"%@",dxModel.Goal] forState:UIControlStateNormal];
        [self.dxCenterBtn setAttributedTitle:[RLSMethods withContent:self.dxCenterBtn.titleLabel.text WithContColor:UIColorHex(#151515) WithContentFont:font12 WithText:@"" WithTextColor:UIColorHex(#151515) WithTextFont:font12] forState:UIControlStateNormal];
        [self.dxCenterBtn setAttributedTitle:[RLSMethods withContent:self.dxCenterBtn.titleLabel.text WithContColor:[UIColor whiteColor] WithContentFont:font12 WithText:self.dxCenterBtn.titleLabel.text WithTextColor:[UIColor whiteColor] WithTextFont:font12] forState:UIControlStateSelected];
        
        [self.btnLittle setTitle:[NSString stringWithFormat:@"小        %.2f", [dxModel.DownOdds floatValue]] forState:UIControlStateNormal];
        [self.btnLittle setAttributedTitle:[RLSMethods withContent:self.btnLittle.titleLabel.text WithContColor:UIColorHex(#151515) WithContentFont:font12 WithText:@"小" WithTextColor:UIColorHex(#151515) WithTextFont:font12] forState:UIControlStateNormal];
        [self.btnLittle setAttributedTitle:[RLSMethods withContent:self.btnLittle.titleLabel.text WithContColor:[UIColor whiteColor] WithContentFont:font12 WithText:self.btnLittle.titleLabel.text WithTextColor:[UIColor whiteColor] WithTextFont:font12] forState:UIControlStateSelected];
    }
    
    if (model.spf.count == 0) {
        if (model.rq.count == 0) {
            self.leftControl.isSelected = false;
            self.centerControl.isSelected = false;
            self.rightControl.isSelected = true;
            self.viewDetial.hidden = true;
            self.rqBaseView.hidden = true;
            self.dxBaseView.hidden = false;
            self.dxCenterBtn.userInteractionEnabled = false;
        } else {
            self.leftControl.isSelected = false;
            self.centerControl.isSelected = true;
            self.rightControl.isSelected = false;
            self.viewDetial.hidden = true;
            self.rqBaseView.hidden = false;
            self.dxBaseView.hidden = true;
            self.yaCenterBtn.userInteractionEnabled = false;
        }
    }
    
    /*
    if (model.spf.count == 0) {
        self.viewDetialTitle.hidden = YES;
        self.viewDetial.hidden = YES;
        self.rqBaseView.frame = CGRectMake(0,  10, Width, 44+20+20); 
        self.dxBaseView.frame = CGRectMake(0, self.rqBaseView.bottom + 10 , Width, 44+20+20);
        self.ViewTextTitle.frame = CGRectMake(0, self.dxBaseView.bottom, Width, 42);
        self.textView.frame = CGRectMake(15, self.ViewTextTitle.bottom, Width - 30, _textViewHeight);
        self.viewZhuma. frame = CGRectMake(0, self.textView.bottom + 20, Width, 145);
    }
    
    if (model.rq.count == 0) {
        self.rqBaseView.hidden = YES;
        self.dxBaseView.frame = CGRectMake(0, self.viewDetial.bottom + 10 , Width, 44+20+20);
        self.ViewTextTitle.frame = CGRectMake(0, self.dxBaseView.bottom, Width, 42);
        self.textView.frame = CGRectMake(15, self.ViewTextTitle.bottom, Width - 30, _textViewHeight);
        self.viewZhuma. frame = CGRectMake(0, self.textView.bottom + 20, Width, 145);
    }
    
    if (model.dx.count == 0) {
        self.dxBaseView.hidden = YES;
        self.ViewTextTitle.frame = CGRectMake(0, self.rqBaseView.bottom, Width, 42);
        self.textView.frame = CGRectMake(15, self.ViewTextTitle.bottom, Width - 30, _textViewHeight);
        self.viewZhuma. frame = CGRectMake(0, self.textView.bottom + 20, Width, 145);
    }
    
    if (model.spf.count == 0 && model.rq.count ==0) {
        self.viewDetialTitle.hidden = YES;
        self.viewDetial.hidden = YES;
        self.rqBaseView.hidden = YES;
        self.dxBaseView.frame = CGRectMake(0, _nav.bottom + 10 , Width, 44+20+20);
        self.ViewTextTitle.frame = CGRectMake(0, self.dxBaseView.bottom, Width, 42);
        self.textView.frame = CGRectMake(15, self.ViewTextTitle.bottom, Width - 30, _textViewHeight);
        self.viewZhuma. frame = CGRectMake(0, self.textView.bottom + 20, Width, 145);
    }
    
    if (model.spf.count == 0 && model.dx.count ==0) {
        self.viewDetialTitle.hidden = YES;
        self.viewDetial.hidden = YES;
        self.dxBaseView.hidden = YES;
        self.rqBaseView.frame = CGRectMake(0, _nav.bottom + 10, Width, 44+20+20);
        self.ViewTextTitle.frame = CGRectMake(0, self.rqBaseView.bottom, Width, 42);
        self.textView.frame = CGRectMake(15, self.ViewTextTitle.bottom, Width - 30, _textViewHeight);
        self.viewZhuma. frame = CGRectMake(0, self.textView.bottom + 20, Width, 145);
    }
    
    if (model.rq.count == 0 && model.dx.count == 0) {
        self.rqBaseView.hidden = YES;
        self.dxBaseView.hidden = YES;
        self.ViewTextTitle.frame = CGRectMake(0, self.viewDetial.bottom, Width, 42);
        self.textView.frame = CGRectMake(15, self.ViewTextTitle.bottom, Width - 30, _textViewHeight);
        self.viewZhuma. frame = CGRectMake(0, self.textView.bottom + 20, Width, 145);
    }
     
     */
}



- (void)fabuTuijian:(UIButton *)btn
{
    NSString *text = [_textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([_choiceMultiple floatValue] == 0) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请选择推荐内容"];
        return;
    }
    if (_user_Model.analyst == 1 && self.switchBtn.isOn) {
        if (text == nil || [text isEqualToString:@""]) {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"推荐理由最少30个字"];
            return;
        }
        if (text.length < 30 ) {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"推荐理由最少30个字"];
            return;
        }
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:@"确定提交该方案吗"];
    [hogan addAttribute:NSFontAttributeName value:font16 range:NSMakeRange(0, [[hogan string] length])];
    [hogan addAttribute:NSForegroundColorAttributeName value:color33 range:NSMakeRange(0, [[hogan string] length])];
    [alertController setValue:hogan forKey:@"attributedTitle"];
    UIAlertAction *alertOne = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self uploadImage];
    }];
    [alertOne setValue:color33 forKey:@"_titleTextColor"];
    UIAlertAction *alertTwo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alertTwo setValue:color33 forKey:@"_titleTextColor"];
    [alertController addAction:alertTwo];
    [alertController addAction:alertOne];
    if (!_isTouchedFabuBtn) {
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
- (void)leftBarButtonItem
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)testView {
    UIView *lineView  = [[UIView alloc] initWithFrame:CGRectMake(0, self.viewDescribe.bottom + 15, Width, 40)];
    lineView.backgroundColor = colorDD;
    return lineView;
}

- (UILabel *)labRQ {
    if (!_labRQ) {
        _labRQ = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, Width - 120, 20)];
        _labRQ.text = @"推荐选择";
        _labRQ.textColor = UIColorHex(#4D4D4D);
        _labRQ.font = [UIFont boldSystemFontOfSize:12];
    }
    return _labRQ;
}
- (UIButton *)btnZhu {
    if (!_btnZhu) {
        _btnZhu = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnZhu.frame = CGRectMake(75, 0, self.oddsBtnWidth, 34);
        _btnZhu.layer.cornerRadius = 2;
        _btnZhu.layer.borderWidth = 0.5;
        _btnZhu.layer.borderColor = colorDD.CGColor;
        [_btnZhu setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_btnZhu setTitleColor:color66 forState:UIControlStateNormal];
        [_btnZhu setBackgroundImage:[UIImage imageNamed:@"publish_odds_selected"] forState:UIControlStateSelected];
        [_btnZhu setBackgroundImage:[UIImage imageNamed:@"publish_odds_default"] forState:UIControlStateNormal];
        _btnZhu.titleLabel.font = font14;
        _btnZhu.tag = 4;
        [_btnZhu addTarget:self action:@selector(btnColickOdds:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnZhu;
}

- (UIButton *)btnKe {
    if (!_btnKe) {
        _btnKe = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnKe.frame = CGRectMake(self.yaCenterBtn.right + 5, 0, self.oddsBtnWidth, 34);
        _btnKe.layer.cornerRadius = 2;
        _btnKe.layer.borderWidth = 0.5;
        _btnKe.layer.borderColor = colorDD.CGColor;
        [_btnKe setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_btnKe setTitleColor:color66 forState:UIControlStateNormal];
        [_btnKe setBackgroundImage:[UIImage imageNamed:@"publish_odds_selected"] forState:UIControlStateSelected];
        [_btnKe setBackgroundImage:[UIImage imageNamed:@"publish_odds_default"] forState:UIControlStateNormal];
        _btnKe.titleLabel.font = font14;
        _btnKe.tag = 5;
        [_btnKe addTarget:self action:@selector(btnColickOdds:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnKe;
}

- (UIButton *)yaCenterBtn {
    if (!_yaCenterBtn) {
        _yaCenterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _yaCenterBtn.frame = CGRectMake(self.btnZhu.right + 5, 0, self.oddsBtnWidth, 34);
        _yaCenterBtn.layer.cornerRadius = 2;
        _yaCenterBtn.layer.borderWidth = 0.5;
        _yaCenterBtn.layer.borderColor = colorDD.CGColor;
        [_yaCenterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_yaCenterBtn setTitleColor:color66 forState:UIControlStateNormal];
        [_yaCenterBtn setBackgroundImage:[UIImage imageNamed:@"publish_odds_selected"] forState:UIControlStateSelected];
        [_yaCenterBtn setBackgroundImage:[UIImage imageNamed:@"publish_odds_white"] forState:UIControlStateNormal];
        _yaCenterBtn.titleLabel.font = font14;
        _yaCenterBtn.tag = 8;
        [_yaCenterBtn addTarget:self action:@selector(btnColickOdds:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _yaCenterBtn;
}

- (UILabel *)labDXQ {
    if (!_labDXQ) {
        _labDXQ = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, Width - 120, 30)];
        _labDXQ.text = @"进球数";
        _labDXQ.textColor = color33;
        _labDXQ.font = [UIFont boldSystemFontOfSize:13];
    }
    return _labDXQ;
}
- (UIButton *)btnBig {
    if (!_btnBig) {
        _btnBig = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnBig.frame = CGRectMake(75, 0, self.oddsBtnWidth, 34);
        _btnBig.layer.cornerRadius = 2;
        _btnBig.layer.borderWidth = 0.5;
        _btnBig.layer.borderColor = colorDD.CGColor;
        [_btnBig setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_btnBig setTitleColor:color66 forState:UIControlStateNormal];
        [_btnBig setBackgroundImage:[UIImage imageNamed:@"publish_odds_selected"] forState:UIControlStateSelected];
        [_btnBig setBackgroundImage:[UIImage imageNamed:@"publish_odds_default"] forState:UIControlStateNormal];
        _btnBig.titleLabel.font = font14;
        _btnBig.tag = 6;
        [_btnBig addTarget:self action:@selector(btnColickOdds:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnBig;
}
- (UIButton *)btnLittle {
    if (!_btnLittle) {
        _btnLittle = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnLittle.frame = CGRectMake(self.dxCenterBtn.right + 5, 0, self.oddsBtnWidth, 34);
        _btnLittle.layer.cornerRadius = 2;
        _btnLittle.layer.borderWidth = 0.5;
        _btnLittle.layer.borderColor = colorDD.CGColor;
        [_btnLittle setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_btnLittle setTitleColor:color66 forState:UIControlStateNormal];
        [_btnLittle setBackgroundImage:[UIImage imageNamed:@"publish_odds_selected"] forState:UIControlStateSelected];
        [_btnLittle setBackgroundImage:[UIImage imageNamed:@"publish_odds_default"] forState:UIControlStateNormal];
        _btnLittle.titleLabel.font = font14;
        _btnLittle.tag = 7;
        [_btnLittle addTarget:self action:@selector(btnColickOdds:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnLittle;
}

- (UIButton *)dxCenterBtn {
    if (!_dxCenterBtn) {
        _dxCenterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _dxCenterBtn.frame = CGRectMake(self.btnBig.right + 5, 0, self.oddsBtnWidth, 34);
        _dxCenterBtn.layer.cornerRadius = 2;
        _dxCenterBtn.layer.borderWidth = 0.5;
        _dxCenterBtn.layer.borderColor = colorDD.CGColor;
        [_dxCenterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_dxCenterBtn setTitleColor:color66 forState:UIControlStateNormal];
        [_dxCenterBtn setBackgroundImage:[UIImage imageNamed:@"publish_odds_selected"] forState:UIControlStateSelected];
        [_dxCenterBtn setBackgroundImage:[UIImage imageNamed:@"publish_odds_white"] forState:UIControlStateNormal];
        _dxCenterBtn.titleLabel.font = font14;
        _dxCenterBtn.tag = 9;
        [_dxCenterBtn addTarget:self action:@selector(btnColickOdds:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dxCenterBtn;
}

- (UIButton *)btnOne{
    if (!_btnOne) {
        _btnOne = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnOne.frame = CGRectMake(75, 0 , self.oddsBtnWidth, 34);
        _btnOne.layer.cornerRadius = 2;
        _btnOne.layer.borderWidth = 0.5;
        _btnOne.layer.borderColor = colorDD.CGColor;
        [_btnOne setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_btnOne setTitleColor:color66 forState:UIControlStateNormal];
         [_btnOne setBackgroundImage:[UIImage imageNamed:@"publish_odds_selected"] forState:UIControlStateSelected];
        [_btnOne setBackgroundImage:[UIImage imageNamed:@"publish_odds_default"] forState:UIControlStateNormal];
        _btnOne.titleLabel.font = font14;
        _btnOne.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _btnOne.tag = 3;
        [_btnOne addTarget:self action:@selector(btnColickOdds:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnOne;
}
- (UIButton *)btnTwo{
    if (!_btnTwo) {
        _btnTwo = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnTwo.frame = CGRectMake(self.btnOne.right + 5 , 0, self.oddsBtnWidth, 34);
        _btnTwo.layer.cornerRadius = 2;
        _btnTwo.layer.borderWidth = 0.5;
        _btnTwo.layer.borderColor = colorDD.CGColor;
        [_btnTwo setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_btnTwo setTitleColor:color66 forState:UIControlStateNormal];
        [_btnTwo setBackgroundImage:[UIImage imageNamed:@"publish_odds_selected"] forState:UIControlStateSelected];
        [_btnTwo setBackgroundImage:[UIImage imageNamed:@"publish_odds_default"] forState:UIControlStateNormal];
        _btnTwo.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _btnTwo.titleLabel.font = font14;
        _btnTwo.tag = 1;
        [_btnTwo addTarget:self action:@selector(btnColickOdds:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnTwo;
}
- (UIButton *)btnThree{
    if (!_btnThree) {
        _btnThree = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnThree.frame = CGRectMake(self.btnTwo.right + 5, 0, self.oddsBtnWidth, 34);
        _btnThree.layer.cornerRadius = 2;
        _btnThree.layer.borderWidth = 0.5;
        _btnThree.layer.borderColor = colorDD.CGColor;
        [_btnThree setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_btnThree setTitleColor:color66 forState:UIControlStateNormal];
        [_btnThree setBackgroundImage:[UIImage imageNamed:@"publish_odds_selected"] forState:UIControlStateSelected];
        [_btnThree setBackgroundImage:[UIImage imageNamed:@"publish_odds_default"] forState:UIControlStateNormal];
        _btnThree.titleLabel.font = font14;
        _btnThree.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _btnThree.tag = 0;
        [_btnThree addTarget:self action:@selector(btnColickOdds:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnThree;
}
- (void)btnColickOdds:(UIButton *)btn{
    RLSDxModel *dxModel;
    switch (btn.tag) {
        case 3:{
            dxModel = self.model.spf[0];
            _choice = @"3";
            _play = @"spf";
            _playContent = [NSString stringWithFormat:@"[%@,\"%@\",%@]",dxModel.UpOdds,dxModel.Goal,dxModel.DownOdds];
            if (btn.selected == NO) {
                self.btnOne.selected = YES;
                self.btnTwo.selected = NO;
                self.btnThree.selected = NO;
                self.btnZhu.selected = NO;
                self.btnKe.selected = NO;
                self.btnBig.selected = NO;
                self.btnLittle.selected = NO;
                self.yaCenterBtn.selected = false;
                self.dxCenterBtn.selected = false;
                _choiceMultiple = dxModel.UpOdds;
            }else{
                self.btnOne.selected = NO;
                self.btnTwo.selected = NO;
                self.btnThree.selected = NO;
                self.btnZhu.selected = NO;
                self.btnKe.selected = NO;
                self.btnBig.selected = NO;
                self.btnLittle.selected = NO;
                self.yaCenterBtn.selected = false;
                self.dxCenterBtn.selected = false;
                _choiceMultiple = @"";
            }
        }
            break;
        case 1:{
            dxModel = self.model.spf[0];
            _choice = @"1";
            _play = @"spf";
            _playContent = [NSString stringWithFormat:@"[%@,\"%@\",%@]",dxModel.UpOdds,dxModel.Goal,dxModel.DownOdds];
            if (btn.selected == NO) {
                self.btnOne.selected = NO;
                self.btnThree.selected = NO;
                self.btnZhu.selected = NO;
                self.btnKe.selected = NO;
                self.btnBig.selected = NO;
                self.btnLittle.selected = NO;
                self.btnTwo.selected = YES;
                self.yaCenterBtn.selected = false;
                self.dxCenterBtn.selected = false;
                _choiceMultiple = dxModel.Goal;
            }else{
                self.btnOne.selected = NO;
                self.btnTwo.selected = NO;
                self.btnThree.selected = NO;
                self.btnZhu.selected = NO;
                self.btnKe.selected = NO;
                self.btnBig.selected = NO;
                self.btnLittle.selected = NO;
                self.yaCenterBtn.selected = false;
                self.dxCenterBtn.selected = false;
                _choiceMultiple = @"";
            }
        }
            break;
        case 0:{
            dxModel = self.model.spf[0];
            _choice = @"0";
            _play = @"spf";
            _playContent = [NSString stringWithFormat:@"[%@,\"%@\",%@]",dxModel.UpOdds,dxModel.Goal,dxModel.DownOdds];
            if (btn.selected == NO) {
                self.btnOne.selected = NO;
                self.btnTwo.selected = NO;
                self.btnZhu.selected = NO;
                self.btnKe.selected = NO;
                self.btnBig.selected = NO;
                self.btnLittle.selected = NO;
                self.btnThree.selected = YES;
                self.yaCenterBtn.selected = false;
                self.dxCenterBtn.selected = false;
                _choiceMultiple = dxModel.DownOdds;
            }else{
                self.btnOne.selected = NO;
                self.btnTwo.selected = NO;
                self.btnThree.selected = NO;
                self.btnZhu.selected = NO;
                self.btnKe.selected = NO;
                self.btnBig.selected = NO;
                self.btnLittle.selected = NO;
                self.yaCenterBtn.selected = false;
                self.dxCenterBtn.selected = false;
                _choiceMultiple = @"";
            }
        }
            break;
        case 4:
            dxModel = self.model.rq[0];
            _choice = @"3";
            _play = @"ya";
            _playContent = [NSString stringWithFormat:@"[%@,\"%@\",%@]",dxModel.UpOdds,dxModel.Goal,dxModel.DownOdds];
            if (btn.selected == NO) {
                self.btnZhu.selected = YES;
                self.btnOne.selected = NO;
                self.btnTwo.selected = NO;
                self.btnThree.selected = NO;
                self.btnKe.selected = NO;
                self.btnBig.selected = NO;
                self.btnLittle.selected = NO;
                _choiceMultiple = dxModel.UpOdds;
                self.yaCenterBtn.selected = false;
                self.dxCenterBtn.selected = false;
            }else{
                self.btnOne.selected = NO;
                self.btnTwo.selected = NO;
                self.btnThree.selected = NO;
                self.btnZhu.selected = NO;
                self.btnKe.selected = NO;
                self.btnBig.selected = NO;
                self.btnLittle.selected = NO;
                self.yaCenterBtn.selected = false;
                self.dxCenterBtn.selected = false;
                _choiceMultiple = @"";
            }
            break;
        case 5:
            dxModel = self.model.rq[0];
            _choice = @"0";
            _play = @"ya";
            _playContent = [NSString stringWithFormat:@"[%@,\"%@\",%@]",dxModel.UpOdds,dxModel.Goal,dxModel.DownOdds];
            if (btn.selected == NO) {
                self.btnKe.selected = YES;
                self.btnOne.selected = NO;
                self.btnTwo.selected = NO;
                self.btnThree.selected = NO;
                self.btnZhu.selected = NO;
                self.btnBig.selected = NO;
                self.btnLittle.selected = NO;
                self.yaCenterBtn.selected = false;
                self.dxCenterBtn.selected = false;
                _choiceMultiple = dxModel.DownOdds;
            }else{
                self.btnOne.selected = NO;
                self.btnTwo.selected = NO;
                self.btnThree.selected = NO;
                self.btnZhu.selected = NO;
                self.btnKe.selected = NO;
                self.btnBig.selected = NO;
                self.yaCenterBtn.selected = false;
                self.dxCenterBtn.selected = false;
                self.btnLittle.selected = NO;
                _choiceMultiple = @"";
            }
            break;
        case 6:
            dxModel = self.model.dx[0];
            _choice = @"3";
            _play = @"dx";
            _playContent = [NSString stringWithFormat:@"[%@,\"%@\",%@]",dxModel.UpOdds,dxModel.Goal,dxModel.DownOdds];
            if (btn.selected == NO) {
                self.btnBig.selected = YES;
                self.btnOne.selected = NO;
                self.btnTwo.selected = NO;
                self.btnThree.selected = NO;
                self.btnZhu.selected = NO;
                self.btnKe.selected = NO;
                self.btnLittle.selected = NO;
                self.yaCenterBtn.selected = false;
                self.dxCenterBtn.selected = false;
                _choiceMultiple = dxModel.UpOdds;
            }else{
                self.btnOne.selected = NO;
                self.btnTwo.selected = NO;
                self.btnThree.selected = NO;
                self.btnZhu.selected = NO;
                self.btnKe.selected = NO;
                self.btnBig.selected = NO;
                self.yaCenterBtn.selected = false;
                self.dxCenterBtn.selected = false;
                self.btnLittle.selected = NO;
                _choiceMultiple = @"";
            }
            break;
        case 7:
            dxModel = self.model.dx[0];
            _choice = @"0";
            _play = @"dx";
            _playContent = [NSString stringWithFormat:@"[%@,\"%@\",%@]",dxModel.UpOdds,dxModel.Goal,dxModel.DownOdds];
            if (btn.selected == NO) {
                self.btnLittle.selected = YES;
                self.btnOne.selected = NO;
                self.btnTwo.selected = NO;
                self.btnThree.selected = NO;
                self.btnZhu.selected = NO;
                self.btnKe.selected = NO;
                self.btnBig.selected = NO;
                self.yaCenterBtn.selected = false;
                self.dxCenterBtn.selected = false;
                _choiceMultiple = dxModel.DownOdds;
            }else{
                self.btnOne.selected = NO;
                self.btnTwo.selected = NO;
                self.btnThree.selected = NO;
                self.btnZhu.selected = NO;
                self.btnKe.selected = NO;
                self.btnBig.selected = NO;
                self.btnLittle.selected = NO;
                self.yaCenterBtn.selected = false;
                self.dxCenterBtn.selected = false;
                _choiceMultiple = @"";
            }
            break;
            
        case 8:
            dxModel = self.model.rq[0];
            _choice = @"1";
            _play = @"ya";
            _playContent = [NSString stringWithFormat:@"[%@,\"%@\",%@]",dxModel.UpOdds,dxModel.Goal,dxModel.DownOdds];
            btn.selected = !btn.selected;
            self.btnLittle.selected = false;
            self.btnOne.selected = NO;
            self.btnTwo.selected = NO;
            self.btnThree.selected = NO;
            self.btnZhu.selected = NO;
            self.btnKe.selected = NO;
            self.btnBig.selected = NO;
            break;
            
        case 9:
            dxModel = self.model.dx[0];
            _choice = @"1";
            _play = @"dx";
            _playContent = [NSString stringWithFormat:@"[%@,\"%@\",%@]",dxModel.UpOdds,dxModel.Goal,dxModel.DownOdds];
             btn.selected = !btn.selected;
            self.btnLittle.selected = false;
            self.btnOne.selected = NO;
            self.btnTwo.selected = NO;
            self.btnThree.selected = NO;
            self.btnZhu.selected = NO;
            self.btnKe.selected = NO;
            self.btnBig.selected = NO;
    
            break;
            
        default:
            break;
    }
}
- (RLSZhumaViewOfFabuTuijian *)viewZhuma
{
    if (!_viewZhuma) {
        _viewZhuma = [[RLSZhumaViewOfFabuTuijian alloc] initWithFrame:CGRectMake(0, self.describeLab.bottom + 10, Width, 145)];
        _viewZhuma.backgroundColor = [UIColor whiteColor];
        _viewZhuma.delegate = self;
    }
    return _viewZhuma;
}
- (void)didselectedZhumaAtIndex:(NSInteger)index
{
    NSLog(@"%zd",index);
        if(index == 1){
        _multiple = @"1";
    }else if (index == 2) {
        _multiple = @"2";
    }else if (index == 3 ) {
        _multiple = @"4";
    }
    if (index == 4) {
        [self fabuTuijian:nil];
    }
}
- (void)didselectedPriceViewWithModel:(RLSPriceListModel *)price
{
    _projectPrice = price.amount;
}
- (UIView *)ViewTextTitle
{
    if (!_ViewTextTitle) {
        _ViewTextTitle = [[UIView alloc] initWithFrame:CGRectMake(0, self.oddsBgView.bottom, Width, 42)];
        [_ViewTextTitle setBackgroundColor:[UIColor whiteColor]];
        UIView *yellowView = [[UILabel alloc] initWithFrame:CGRectMake(15,0 , 0, 8)];
        yellowView.center = CGPointMake(yellowView.center.x, _viewDetialTitle.center.y);
        yellowView.backgroundColor = colorf99c07;
        [_ViewTextTitle addSubview:yellowView];
       UILabel *textViewTitle = [[UILabel alloc] initWithFrame:CGRectMake(yellowView.right + 0, 0, 60, 42)];
        textViewTitle.textColor = color33;
        textViewTitle.font = [UIFont boldSystemFontOfSize:13];
        textViewTitle.text = @"发布内容";
        [_ViewTextTitle addSubview:textViewTitle];
        UISwitch *textSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(textViewTitle.right - 5, 5, 0, 0)];
        self.switchBtn = textSwitch;
        textSwitch.onTintColor = redcolor;
        [textSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];   
        textSwitch.transform = CGAffineTransformMakeScale( 0.7, 0.7);
        textSwitch.on = false;
        self.currentSwitch = textSwitch;
        self.textViewPlaceholder.text = @"有价值的深度分析内容才会推送到推荐首页";
        [_ViewTextTitle addSubview:textSwitch];
    }
    return _ViewTextTitle;
}
-(void)switchAction:(id)sender {
    UISwitch *switchButton = (UISwitch*)sender;
    if (_user_Model.analyst == 1) {
        BOOL isButtonOn = [switchButton isOn];
        if (isButtonOn) {
            self.textViewPlaceholder.text = @"有价值的深度分析内容将会被推送到推荐大厅";
            self.coverView.hidden = true;
            [self setLayout:_textViewHeight];
        }else {
            self.textViewPlaceholder.text = @"有价值的深度分析内容将会被推送到推荐大厅";
            self.coverView.hidden = false;
            [self setLayout:140];
        }
    
    } else {
        switchButton.on = false;
        [self toapplyAnalasis];
    }
}
- (void)toapplyAnalasis
{
    RLSUserModel *user = [RLSMethods getUserModel];
    NSString *strTitle = @"您尚未认证分析师";
    NSString *str_content = @"申请分析师";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:strTitle];
    [hogan addAttribute:NSFontAttributeName value:font16 range:NSMakeRange(0, [[hogan string] length])];
    [hogan addAttribute:NSForegroundColorAttributeName value:color33 range:NSMakeRange(0, [[hogan string] length])];
    [alertController setValue:hogan forKey:@"attributedTitle"];
    UIAlertAction *alertOne = [UIAlertAction actionWithTitle:str_content style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        RLSToAnalystsVC *analysts = [[RLSToAnalystsVC alloc] init];
        analysts.hidesBottomBarWhenPushed = YES;
        analysts.type = user.analyst;
        analysts.model = user;
        [APPDELEGATE.customTabbar pushToViewController:analysts animated:YES];
    }];
    [alertOne setValue:redcolor forKey:@"_titleTextColor"];
    UIAlertAction *alertTwo = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alertTwo setValue:color33 forKey:@"_titleTextColor"];
    [alertController addAction:alertTwo];
    [alertController addAction:alertOne];
    [self presentViewController:alertController animated:YES completion:nil];
}


- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(15, self.adaDetaiLab.bottom + 10, Width - 30, _textViewHeight)];
        _textView.layer.borderColor = colorCellLine.CGColor;
        _textView.layer.borderWidth = 0.5;
        _textView.layer.cornerRadius = 3;
        _textView.layer.masksToBounds= YES;
        _textView.scrollEnabled = NO;
        _textView.delegate = self;
        _textView.allowsEditingTextAttributes = YES;
        _textView.backgroundColor = [UIColor whiteColor];
        [_textView addSubview:self.textViewPlaceholder];
        _textView.userInteractionEnabled = true;
    }
    return _textView;
}

- (UITextField *)textFiled {
    if (_textFiled == nil) {
        _textFiled = [[UITextField alloc]initWithFrame:CGRectMake(15, self.ViewTextTitle.bottom, Width - 30, 44)];
         _textFiled.layer.borderColor = colorCellLine.CGColor;
        _textFiled.layer.borderWidth = 0.5;
        _textFiled.layer.cornerRadius = 3;
        _textFiled.layer.masksToBounds= YES;
        NSString *placeText = @"     一句话宣传你的推荐";
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:placeText];
        [att addAttribute:NSFontAttributeName value:font12 range:[placeText rangeOfString:placeText]];
        [att addAttribute:NSForegroundColorAttributeName value:color999999 range:[placeText rangeOfString:placeText]];
        _textFiled.attributedPlaceholder = att;
        _textFiled.delegate = self;
    }
    return _textFiled;
}

- (UILabel *)adaDetaiLab {
    if (_adaDetaiLab == nil) {
        _adaDetaiLab = [[UILabel alloc]initWithFrame:CGRectMake(15, self.textFiled.bottom + 10, 100, 20)];
        _adaDetaiLab.textColor = color33;
        _adaDetaiLab.font = [UIFont boldSystemFontOfSize:13];
        _adaDetaiLab.text = @"分析详情";
    }
    return _adaDetaiLab;
}

- (UILabel *)describeLab {
    if (_describeLab == nil) {
        _describeLab = [[UILabel alloc]initWithFrame:CGRectMake(self.warningIV.right + 5, self.textView.bottom + 10, Width - 48, 40)];
        _describeLab.textColor = UIColorHex(#898989);
        _describeLab.font = [UIFont boldSystemFontOfSize:10];
        _describeLab.text = @"分析内容与本场比赛无关、滥用标点符号与无意义字符、以任何形式留下 联系方式或发布其他违规内容，以及被发现或举报有抄袭、转载行为者，将 直接取消分析师资格！";
        _describeLab.numberOfLines = 0;
    }
    return _describeLab;
}

- (BaseImageView *)warningIV {
    if (_warningIV == nil) {
        _warningIV = [[BaseImageView alloc]initWithFrame:CGRectMake(15,  self.textView.bottom + 15, 13, 13)];
        _warningIV.image = [UIImage imageNamed:@"Warning"];
    }
    return _warningIV;
}

- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc]initWithFrame:CGRectMake(0, self.ViewTextTitle.bottom, self.view.width, self.describeLab.bottom - self.ViewTextTitle.bottom)];
        _coverView.backgroundColor = [UIColor whiteColor];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, Width - 30, 30)];
        lab.textColor = color999999;
        lab.font = font12;
        lab.numberOfLines = 2;
        lab.text = @"有价值的深度分析才会推送到推荐首页";
        [_coverView addSubview:lab];
        _coverView.hidden = false;
    }
    return _coverView;
}


- (UILabel *)textViewPlaceholder
{
    if (!_textViewPlaceholder) {
        _textViewPlaceholder = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, Width - 60, 50)];
        _textViewPlaceholder.textColor = color999999;
        _textViewPlaceholder.font = font12;
        _textViewPlaceholder.numberOfLines = 2;
        _textViewPlaceholder.attributedText = [RLSMethods setTextStyleWithString:@"推荐内容需原创，请提供详细分析或盘赔解读，涉及广告、抄袭等违规或过于简单将取消分析师资格哦！" WithLineSpace:4 WithHeaderIndent:0];
    }
    return _textViewPlaceholder;
}

- (UIView *)buttomView{
    if (!_buttomView) {
        _buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, Height, Width, 45)];
        _buttomView.backgroundColor = ColorWithRGBA(245, 245, 245, 1);
        _buttomView.layer.borderColor = grayColor2.CGColor;
        _buttomView.layer.borderWidth = 0.5;
        [_buttomView addSubview:self.btnPhoto];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(Width - 15 - 30, 0, 30, 45)];
        lab.font = font14;
        lab.textColor = color66;
        lab.text = @"完成";
        [_buttomView addSubview:lab];
    }
    return _buttomView;
}
- (void)tapButtomView
{
    [self.textView resignFirstResponder];
    [self.textFiled  resignFirstResponder];
}
- (UIButton *)btnPhoto{
    if (!_btnPhoto) {
        _btnPhoto = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnPhoto.frame = CGRectMake(15, 10, 30, 25);
        [_btnPhoto setImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
        [_btnPhoto addTarget:self action:@selector(AddPic:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnPhoto;
}
- (void)textViewDidChange:(UITextView *)textView
{
    _textView.textColor = grayColor4;
    _textView.font = font16;
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    if (size.height <140) {
        size.height = 140;
    }
    if (_textViewHeight != size.height) {
        _textViewHeight = size.height;
         [self setLayout:size.height];
        if (self.ScrollView.contentSize.height >self.ScrollView.height) {
             [self.ScrollView setContentOffset:CGPointMake(0, self.ScrollView.contentSize.height - self.ScrollView.height - ( 10 + self.viewZhuma.height+ 15 +  20 + 15 ))];
        }
    }
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _textViewPlaceholder.hidden = YES;
    _textView.textColor = grayColor4;
    _textView.font = font16;
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    if (size.height <140) {
        size.height = 140;
    }
    if (_textViewHeight != size.height) {
        _textViewHeight = size.height;
        [self setLayout:size.height];
        if (self.ScrollView.contentSize.height >self.ScrollView.height) {
            [self.ScrollView setContentOffset:CGPointMake(0, self.ScrollView.contentSize.height - self.ScrollView.height - ( 10 + self.viewZhuma.height+ 15  + 20 + 15 ))];
        }
    }
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    _textViewSelectedRange = textView.selectedRange;
    if ([textView.text isEqualToString:@""])
    {
        _textViewPlaceholder.hidden = NO;
    }else{
        _textViewPlaceholder.hidden = YES;
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
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
- (void)KeyboardShow:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    CGRect rect =
    [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = CGRectGetHeight(rect);
    CGFloat keyboardDuration =
    [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:keyboardDuration animations:^{
        self.ScrollView.frame = CGRectMake(0, _nav.bottom, Width, Height - keyboardHeight  - _nav.bottom - self.buttomView.height );
            if (self.ScrollView.height <self.ScrollView.contentSize.height) {
                 if (self.ScrollView.contentSize.height >self.ScrollView.height) {
                 }
               
                  self.buttomView.frame = CGRectMake(0, Height - self.buttomView.height - keyboardHeight, Width, self.buttomView.height);
    
            }
        }];
}
- (void)KeyboardHide:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    CGFloat keyboardDuration =[userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:keyboardDuration animations:^{
        self.ScrollView.frame = CGRectMake(0, _nav.bottom, Width, Height - _nav.bottom);
        self.buttomView.frame = CGRectMake(0, Height , Width, self.buttomView.height);
    }];
}
- (void)AddPic:(UIButton *)btn
{
    if (self.textFiled.isFirstResponder) {
        [SVProgressHUD showErrorWithStatus:@"宣传语不可发表图片"];
        return;
    }
    UIImagePickerController *pickerVC = [[UIImagePickerController alloc] init];
    pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerVC.delegate = self;
    pickerVC.allowsEditing = YES;
    [APPDELEGATE.customTabbar presentToViewController:pickerVC animated:YES completion:^{
    }];
}
#pragma  mark -- 把相册里面的图片转换为富文本放到textView里面
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (self.textView.textStorage.length>0) {
        [self appenReturn];
    }
    [self setImageText:image withRange:_textViewSelectedRange appenReturn:YES];
    _textView.textColor = grayColor4;
    _textView.font = font16;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}

-(void)setImageText:(UIImage *)img withRange:(NSRange)range appenReturn:(BOOL)appen
{
    UIImage * image=img;
    if (image == nil)
    {
        return;
    }
    if (![image isKindOfClass:[UIImage class]])           
    {
        return;
    }
    CGFloat ImgeHeight=image.size.height*IMAGE_MAX_SIZE/image.size.width;
    if (ImgeHeight>IMAGE_MAX_SIZE*2) {
        ImgeHeight=IMAGE_MAX_SIZE*2;
    }
    ImageTextAttachment *imageTextAttachment = [ImageTextAttachment new];
    imageTextAttachment.imageTag = RICHTEXT_IMAGE;
    imageTextAttachment.image =image;
    imageTextAttachment.imageSize = CGSizeMake(IMAGE_MAX_SIZE, ImgeHeight);
    if (appen) {
        [_textView.textStorage insertAttributedString:[NSAttributedString attributedStringWithAttachment:imageTextAttachment] atIndex:range.location];
    }
    else
    {
        if (_textView.textStorage.length>0) {
            [_textView.textStorage replaceCharactersInRange:range withAttributedString:[NSAttributedString attributedStringWithAttachment:imageTextAttachment]];
        }
    }
    [self setInitLocation];
    if(appen)
    {
        [self appenReturn];
    }
    CGRect frame = _textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [_textView sizeThatFits:constraintSize];
    if (size.height>140 && _textViewHeight != size.height) {
         _textViewHeight = size.height;
        [self setLayout:size.height];
        if (self.ScrollView.contentSize.height >self.ScrollView.height) {
            [self.ScrollView setContentOffset:CGPointMake(0, self.ScrollView.contentSize.height - self.ScrollView.height)];
        }
    }
    [self.textView becomeFirstResponder];
}

-(void)appenReturn
{
    NSAttributedString * returnStr=[[NSAttributedString alloc]initWithString:@"\n"];
    NSMutableAttributedString * att=[[NSMutableAttributedString alloc]initWithAttributedString:_textView.attributedText];
    [att appendAttributedString:returnStr];
    _textView.attributedText=att;
    _textViewSelectedRange = _textView.selectedRange;
}

-(void)setInitLocation
{
    self.locationStr=nil;
    self.locationStr=[[NSMutableAttributedString alloc]initWithAttributedString:self.textView.attributedText];
    if (self.textView.textStorage.length>0) {
        self.textViewPlaceholder.hidden=YES;
    }
}
#pragma mark -- 发不，先上传图片
- (void)uploadImage{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:@(3) forKey:@"flag"];
    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_ZiXunUrl] ArrayFile:[_textView.attributedText getImgaeArray] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        NSLog(@"图片上传=%@",responseOrignal);
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            NSArray *arr = [responseOrignal objectForKey:@"data"];
            _arrPhoto = [NSMutableArray array];
            for (int i = 0; i < arr.count; i ++) {
                PictureModel *photoModel = [[PictureModel alloc] init];
                photoModel.imgthumburl = responseOrignal[@"data"][i][@"thumb"];
                photoModel.imageurl = responseOrignal[@"data"][i][@"image"];
                [_arrPhoto addObject:photoModel];
            }
            [self replacetagWithImageArray:[_textView.attributedText getImgaeArray]];
        }else{
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
            _isTouchedFabuBtn = NO;
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
        _isTouchedFabuBtn = NO;
    }];
}
#pragma mark -- 拼接图片地址
-(NSString *)replacetagWithImageArray:(NSArray *)picArr
{
    NSMutableAttributedString * contentStr=[[NSMutableAttributedString alloc]initWithAttributedString:_textView.attributedText];
    [contentStr enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, contentStr.length)
                           options:0
                        usingBlock:^(id value, NSRange range, BOOL *stop) {
                            if (value && [value isKindOfClass:[ImageTextAttachment class]]) {
                                [contentStr replaceCharactersInRange:range withString:RICHTEXT_IMAGE];
                            }
                        }];
    NSMutableString * mutableStr=[[NSMutableString alloc]initWithString:[contentStr toHtmlString]];
    NSArray * strArr=[mutableStr  componentsSeparatedByString:RICHTEXT_IMAGE];
    NSString * newContent=@"";
    for (int i=0; i<strArr.count; i++) {
        NSString * imgTag=@"";
        if (i<picArr.count) {
            PictureModel *  picture=[_arrPhoto objectAtIndex:i];
            if ([picture isKindOfClass:[PictureModel class]]) {
                imgTag=[NSString stringWithFormat:@"<img src=\"%@\" style='max-width:100%%'/>",picture.imageurl];
            }
            else if([picture isKindOfClass:[NSString class]]){
                imgTag=picArr[i];
            }
        }
        NSString * cutStr=[strArr objectAtIndex:i];
        newContent=[NSString stringWithFormat:@"%@%@%@",newContent,cutStr,imgTag];
    }
    [self getPPP:newContent];
    return newContent;
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
    [self fabuTuijianWithHtml:[arrayTwo objectAtIndex:0] withContent:[self filterHTML:[arrayTwo objectAtIndex:0]]];
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
#pragma mark -- 最后发布推荐

- (void)fabuTuijianWithHtml:(NSString *)htmlStr withContent:(NSString *)contentStr
{
    
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:[NSString stringWithFormat:@"%ld",self.model.sid] forKey:@"matchId"];
    [parameter setObject:_playContent forKey:_play];
    [parameter setObject:_choice forKey:@"choice"];
    [parameter setObject:_multiple forKey:@"multiple"];
    [parameter setObject:contentStr forKey:@"contentInfo"];
    [parameter setObject:@(_projectPrice) forKey:@"amount"];
    [parameter setObject:PARAM_IS_NIL_ERROR(self.textFiled.text) forKey:@"slogan"];
    [parameter setObject:PARAM_IS_NIL_ERROR([_textView.text stringByReplacingOccurrencesOfString:@"\ufffc" withString:@""])  forKey:@"content"];
    [parameter setObject:@(1) forKey:@"ignore"];
    [RLSLodingAnimateView showLodingView];
    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server, url_addrecommend] ArrayFile:nil Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        [RLSLodingAnimateView dissMissLoadingView];
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _isTouchedFabuBtn = YES;
            _tuijianBackID = [[responseOrignal objectForKey:@"data"] intValue];
            int stauts = [[responseOrignal objectForKey:@"isReview"] intValue];
            RLSFaBuSucceedVCViewController *fabuVC = [RLSFaBuSucceedVCViewController new];
            fabuVC.status = stauts;
            fabuVC.backtuijianID = self.tuijianBackID;
            fabuVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:fabuVC animated:YES];
        }else{
            _isTouchedFabuBtn = NO;
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        _isTouchedFabuBtn = NO;
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
        [RLSLodingAnimateView dissMissLoadingView];
    }];
}
- (void)updateModel
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:@(_model.sid) forKey:@"ScheduleID"];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_SingalRecommendMatch] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _model.rq = [RLSDxModel arrayOfEntitiesFromArray:[[[responseOrignal objectForKey:@"data"] objectForKey:@"instantOdds"] objectForKey:@"rq"]];
            _model.spf = [RLSDxModel arrayOfEntitiesFromArray:[[[responseOrignal objectForKey:@"data"] objectForKey:@"instantOdds"] objectForKey:@"spf"]];
            _model.dx = [RLSDxModel arrayOfEntitiesFromArray:[[[responseOrignal objectForKey:@"data"] objectForKey:@"instantOdds"] objectForKey:@"dx"]];
            _model.priceList = [RLSPriceListModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"priceList"]];
            if (_model.rq.count == 0 && _model.dx.count == 0 && _model.spf.count == 0) {
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"该场比赛未开盘"];
                [self.navigationController popViewControllerAnimated:YES];
            }
            [self setupModel:_model];
        }else{
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:responseOrignal[@"msg"]];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
