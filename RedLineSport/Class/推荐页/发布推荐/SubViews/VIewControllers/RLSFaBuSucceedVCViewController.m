#import "RLSFaBuSucceedVCViewController.h"
#import "UIColor+HEX.h"
#import "RLSTuijianDTViewController.h"
#import "RLSDan_StringGuanVC.h"
#import "RLSFenxiPageVC.h"
#import "RLSTuijianDetailVC.h"
@interface RLSFaBuSucceedVCViewController ()
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel * labelUp;
@property (nonatomic, strong) UILabel * labelDown;
@property (nonatomic, strong) UIButton *btnJiXv;
@property (nonatomic, strong) UIButton *btnChaKan;
@end
@implementation RLSFaBuSucceedVCViewController
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavView];
    [self setUpView];
}
#pragma mark -- setnavView
- (void)setNavView{
    RLSNavView *nav = [[RLSNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"发布成功";
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew2"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew2"] forState:UIControlStateHighlighted];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [self.view addSubview:nav];
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        NSLog(@"%@",self.navigationController.viewControllers);
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }else if(index == 2){
    }
}
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sucess"]];
    }
    return _iconView;
}
- (UILabel *)labelUp {
    if (!_labelUp) {
        _labelUp = [[UILabel alloc] init];
        _labelUp.text = @"发布推荐成功";
        _labelUp.font = font20;
        _labelUp.textAlignment = NSTextAlignmentCenter;
        [_labelUp setTextColor:color33];
    }
    return _labelUp;
}
- (UILabel *)labelDown {
    if (!_labelDown) {
        _labelDown = [[UILabel alloc] init];
        _labelDown.text = @"你可以在我的推荐查看推荐记录";
        _labelDown.font = font14;
        _labelDown.textAlignment = NSTextAlignmentCenter;
        [_labelDown setTextColor:color99];
    }
    return _labelDown;
}
- (UIButton *)btnJiXv {
    if (!_btnJiXv) {
        _btnJiXv = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnJiXv setTitle:@"继续发布" forState:UIControlStateNormal];
        [_btnJiXv setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnJiXv.backgroundColor = redcolor;
        _btnJiXv.layer.borderWidth = 0.06;
        _btnJiXv.layer.cornerRadius = 3;
        _btnJiXv.layer.masksToBounds = YES;
        _btnJiXv.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_btnJiXv addTarget:self action:@selector(jiXvClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnJiXv;
}
- (UIButton *)btnChaKan {
    if (!_btnChaKan) {
        _btnChaKan = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnChaKan.layer.borderColor = [UIColor darkGrayColor].CGColor;
        _btnChaKan.layer.borderWidth = 0.6;
        _btnChaKan.layer.cornerRadius = 3;
        _btnChaKan.layer.masksToBounds = YES;
        [_btnChaKan setTitle:@"查看推荐" forState:UIControlStateNormal];
        [_btnChaKan setTitleColor:color33 forState:UIControlStateNormal];
        [_btnChaKan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btnChaKan addTarget:self action:@selector(chaKanClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnChaKan;
}
- (void)setUpView {
    [self.view addSubview:self.iconView];
    [self.view addSubview:self.labelUp];
    [self.view addSubview:self.labelDown];
    [self.view addSubview:self.btnJiXv];
    [self.view addSubview:self.btnChaKan];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(90);
        make.center.equalTo(self.view).centerOffset(CGPointMake(0, -150));
    }];
    [self.labelUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(self.view.width);
        make.center.equalTo(self.iconView).centerOffset(CGPointMake(0, 75));
    }];
    [self.labelDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view.width);
        make.height.mas_equalTo(20);
        make.center.equalTo(self.labelUp).centerOffset(CGPointMake(0, 25));
    }];
    [self.btnJiXv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view.width - 70);
        make.height.mas_equalTo(45);
        make.center.equalTo(self.labelDown).centerOffset(CGPointMake(0, 70));
    }];
    [self.btnChaKan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view.width - 70);
        make.height.mas_equalTo(45);
        make.center.equalTo(self.view).centerOffset(CGPointMake(0, 90));
    }];
}
- (void)chaKanClick {
    [self loadTuiJianDetailView];
}
- (void)jiXvClick {
    NSArray *array = self.navigationController.viewControllers;
    if ([array[1] isKindOfClass:NSClassFromString(@"RLSFabuTuijianSelectedItemVC")]) {
        [self.navigationController popToViewController:array[1] animated:YES];
    } else {
         [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
- (void)loadTuiJianDetailView {
    RLSTuijianDetailVC *tuijianDetailVC = [RLSTuijianDetailVC new];
    tuijianDetailVC.status = _status +1;
    tuijianDetailVC.modelId = self.backtuijianID;
    [self.navigationController pushViewController:tuijianDetailVC animated:YES];
}
@end
