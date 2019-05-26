#import "RLSDCPlaySound.h"
static SystemSoundID shake_sound_id = 0;
#import "RLSBifenSetingViewController.h"
#import "RLSDCPlaySound.h"
#define Setcell @"Setcell"
@interface RLSBifenSetingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *setTableView;
@property (nonatomic, strong) NSMutableArray *arrPeilvBtns;
@property (nonatomic, strong) NSMutableArray *btnXianshiFS;
@property (nonatomic, strong) NSMutableArray *btnMoRenBF;
@property (nonatomic, strong) NSMutableArray *btnJinQiuTS;
@property (nonatomic, strong) NSMutableArray *btnHongPaiTS;
@property (nonatomic, strong) NSMutableArray *btnTiShiSY;
@property (nonatomic, strong) NSMutableArray *btnTiShiFW;
@property (nonatomic, strong) NSMutableArray *btnYuYan;
@property (nonatomic, strong) NSMutableArray *btnPanKou;
@property (nonatomic, strong) UIImageView *imageMatchtime;
@property (nonatomic, strong) UIImageView *imageLeaguename;
@property (nonatomic, strong) UIButton *btnoupei;
@property (nonatomic, strong) UIButton *btndaxiao;
@property (nonatomic, strong) UIButton *btnyapan;
@property (nonatomic, assign) BOOL changedShowSortType;
@end
@implementation RLSBifenSetingViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
#pragma mark -- setnavView
- (void)setNavView
{
    RLSNavView *nav = [[RLSNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"设置";
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [self.view addSubview:nav];
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        NSMutableArray *arrPeilv = [NSMutableArray array];
        for (UIButton *btn in _arrPeilvBtns) {
            if (btn.selected) {
                [arrPeilv addObject:[NSString stringWithFormat:@"%ld",btn.tag]];
            }
        }
        [[NSUserDefaults standardUserDefaults]setObject:arrPeilv forKey:@"befenSetingPeilv"];
        NSMutableArray *arrXianShi = [NSMutableArray array];
        for (UIButton *btn in _btnXianshiFS) {
            if (btn.selected) {
                [arrXianShi addObject:[NSString stringWithFormat:@"%ld",btn.tag]];
            }
        }
        [[NSUserDefaults standardUserDefaults] setObject:arrXianShi forKey:@"beforeXianShi"];
        NSMutableArray *arrMoRenBF = [NSMutableArray array];
        for (UIButton *btn in _btnMoRenBF) {
            if (btn.selected) {
                [arrMoRenBF addObject:[NSString stringWithFormat:@"%ld",btn.tag]];
            }
        }
        [[NSUserDefaults standardUserDefaults] setObject:arrMoRenBF forKey:@"BeforeMoRenBF"];
        NSMutableArray *arrTiShiFW = [NSMutableArray array];
        for (UIButton *btn in _btnTiShiFW) {
            if (btn.selected) {
                [arrTiShiFW addObject:[NSString stringWithFormat:@"%ld",btn.tag]];
            }
        }
        [[NSUserDefaults standardUserDefaults] setObject:arrTiShiFW forKey:@"BeforeTiShiFW"];
        NSMutableArray *arrTiShiSY = [NSMutableArray array];
        for (UIButton *btn in _btnTiShiSY) {
            if (btn.selected) {
                [arrTiShiSY addObject:[NSString stringWithFormat:@"%ld",btn.tag]];
            }
        }
        [[NSUserDefaults standardUserDefaults] setObject:arrTiShiSY forKey:@"BeforeTiShiSY"];
        NSMutableArray *arrJinQiuTS = [NSMutableArray array];
        for (UIButton *btn in _btnJinQiuTS) {
            if (btn.selected) {
                [arrJinQiuTS addObject:[NSString stringWithFormat:@"%ld",btn.tag]];
            }
        }
        [[NSUserDefaults standardUserDefaults] setObject:arrJinQiuTS forKey:@"BeforeJinQiuTS"];
        NSMutableArray *arrHongPaiTS = [NSMutableArray array];
        for (UIButton *btn in _btnHongPaiTS) {
            if (btn.selected) {
                [arrHongPaiTS addObject:[NSString stringWithFormat:@"%ld",btn.tag]];
            }
        }
        [[NSUserDefaults standardUserDefaults] setObject:arrHongPaiTS forKey:@"BeforeHongPaiTS"];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"hasSetted"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if (_changedListType) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NSNotificationchangeShowType" object:nil];
        }
        if (_changedShowSortType) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NSNotificationCenterupdateWhetherShowSort" object:nil];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else if(index == 2){
    }
}
- (void)baseArrWithName:(NSMutableArray *)arrName inArr:(NSMutableArray *)arr setObjForkey:(NSString *)keyName {
    arrName = [NSMutableArray array];
    for (UIButton *btn in arr) {
        if (btn.selected) {
            [arrName addObject:[NSString stringWithFormat:@"%ld",btn.tag]];
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:arrName forKey:keyName];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.setTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStyleGrouped];
    self.setTableView.backgroundColor = colorF5;
    self.setTableView.delegate = self;
    self.setTableView.dataSource = self;
    self.setTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.setTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Setcell];
    self.navigationItem.title = @"设置";
    [self.view addSubview:self.setTableView];
    [self setNavView];
}
#pragma mark -- UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 4; 
            break;
        case 2:
            return 5; 
            break;
        case 3:
            return 2;
            break;
        default:
            break;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Setcell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Setcell];
    }
    while (cell.contentView.subviews.lastObject != nil) {
        [cell.contentView.subviews.lastObject removeFromSuperview];
    }
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 43, Width, 0.5)];
    viewLine.backgroundColor = colorDD;
    [cell.contentView addSubview:viewLine];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, Width - 80, 44)];
    lab.font = font15;
    lab.textColor = color33;
    [cell.contentView addSubview:lab];
    UISwitch *switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(Width - 60, 0, 51, 28)];
    switchBtn.center = CGPointMake(switchBtn.center.x, 22);
    switchBtn.onTintColor = redcolor;
    [switchBtn addTarget:self action:@selector(switchBtn:) forControlEvents:UIControlEventValueChanged];
    [cell.contentView addSubview:switchBtn];
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    lab.text = @"显示方式(即时)";
                    switchBtn.tag = 0;
                    switchBtn.hidden = YES;
                    NSArray *arrXianShi = [[NSUserDefaults standardUserDefaults] arrayForKey:@"beforeXianShi"];
                    _btnXianshiFS = [NSMutableArray array];
                    for (int i = 1; i < 3; i++) {
                        UIButton *btnXianShi = [UIButton buttonWithType:UIButtonTypeCustom];
                        btnXianShi.frame = CGRectMake(Width - 30 - 68*(i) - 10*(i-1), 0, 68, 44);
                        [btnXianShi setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"xianshifangshi%d",i]] forState:UIControlStateNormal];
                        [btnXianShi setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"xianshifangshisel%d",i]] forState:UIControlStateSelected];
                        btnXianShi.tag = i + 1000;
;
                        if (![[NSUserDefaults standardUserDefaults] arrayForKey:@"beforeXianShi"]) {
                            if (btnXianShi.tag == 1002) {
                                btnXianShi.selected = YES;
                                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kaisaishijian"];
                                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kaisaisaishi"];
                                _changedListType = YES;
                                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loadedBifenData"];
                                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"youjinqiu"];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                            }
                        }else{
                            for (NSString *numP in arrXianShi) {
                                if (i+1000 == [numP intValue]) {
                                    btnXianShi.selected = YES;
                                }
                            }
                        }
                        [btnXianShi addTarget:self action:@selector(xianshiClick:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.contentView addSubview:btnXianShi];
                        [_btnXianshiFS addObject:btnXianShi];
                    }
                }
                    break;
                case 1:
                {
                    lab.text = @"默认比分";
                    switchBtn.tag = 1;
                    switchBtn.hidden = YES;
                    NSArray *arrMoRenBF = [[NSUserDefaults standardUserDefaults] arrayForKey:@"BeforeMoRenBF"];
                    _btnMoRenBF = [NSMutableArray array];
                    for (int i = 1; i < 3; i++) {   
                        UIButton *btnMoRenBF = [UIButton buttonWithType:UIButtonTypeCustom];
                        btnMoRenBF.frame = CGRectMake(Width - 10 - 68*(i), 0, 68, 44);
                        [btnMoRenBF setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"morenbifen%d",i]] forState:UIControlStateNormal];
                        [btnMoRenBF setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"morenbifensel%d",i]] forState:UIControlStateSelected];
                        btnMoRenBF.selected = NO;
                        btnMoRenBF.tag = i + 2000;
                        if (![[NSUserDefaults standardUserDefaults] arrayForKey:@"BeforeMoRenBF"]) {
                            if (btnMoRenBF.tag == 2002) {
                                btnMoRenBF.selected = YES;
                            }
                        }else{
                            for (NSString *numP in arrMoRenBF) {
                                if (i+2000 == [numP intValue]) {
                                    btnMoRenBF.selected = YES;
                                }
                            }
                        }
                        [btnMoRenBF addTarget:self action:@selector(moRenBFClick:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.contentView addSubview:btnMoRenBF];
                        [_btnMoRenBF addObject:btnMoRenBF];
                    }
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    lab.text = @"球队排名";
                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"qiuduipaiming"]) {   
                        switchBtn.on = YES;
                    }else{
                        switchBtn.on = NO;
                    }
                    switchBtn.tag = 10;
                }
                    break;
                case 2:
                    lab.text = @"角球数";
                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jiaoqiu"]) {
                        switchBtn.on = YES;
                    }else{
                        switchBtn.on = NO;
                    }
                    switchBtn.tag = 11;
                    break;
                case 3:
                    lab.text = @"红黄牌";
                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hongpai"]) {       
                        switchBtn.on = YES;
                    }else{
                        switchBtn.on = NO;
                    }
                    switchBtn.tag = 12;
                    break;
                case 1:
                    lab.text = @"编号(竞彩、北单、足彩)";
                    [lab setAttributedText:[RLSMethods withContent:@"编号(竞彩、北单、足彩)" WithColorText:@"(竞彩、北单、足彩)" textColor:grayColor3 strFont:font11]];
                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"bianhao"]) {
                        switchBtn.on = YES;
                    }else{
                        switchBtn.on = NO;
                    }
                    switchBtn.tag = 14;
                    break;
                case 4: 
                {
                    lab.text = @"盘赔";     
                    switchBtn.tag = 15;
                    switchBtn.hidden = YES;
                    NSArray *arrPeilv = [[NSUserDefaults standardUserDefaults] arrayForKey:@"befenSetingPeilv"];
                    _arrPeilvBtns = [NSMutableArray array];
                    self.btnoupei= [UIButton buttonWithType:UIButtonTypeCustom];
                    self.btnoupei.frame = CGRectMake(Width - 10 - 68, 0, 68, 44);
                    [self.btnoupei setBackgroundImage:[UIImage imageNamed:@"pankou1"] forState:UIControlStateNormal];
                    [self.btnoupei setBackgroundImage:[UIImage imageNamed:@"pankousel1"] forState:UIControlStateSelected];
                    self.btnoupei.tag = 8000;
                    [self.btnoupei addTarget:self action:@selector(selectedPeilv:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:self.btnoupei];
                    [_arrPeilvBtns addObject:self.btnoupei];
                    self.btndaxiao = [UIButton buttonWithType:UIButtonTypeCustom];
                    self.btndaxiao.frame = CGRectMake(Width - 10 - 68*2, 0, 68, 44);
                    [self.btndaxiao setBackgroundImage:[UIImage imageNamed:@"pankou2"] forState:UIControlStateNormal];
                    [self.btndaxiao setBackgroundImage:[UIImage imageNamed:@"pankousel2"] forState:UIControlStateSelected];
                    self.btndaxiao.tag = 8001;
                    [self.btndaxiao addTarget:self action:@selector(selectedPeilv:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:self.btndaxiao];
                    [_arrPeilvBtns addObject:self.btndaxiao];
                    self.btnyapan = [UIButton buttonWithType:UIButtonTypeCustom];
                    self.btnyapan.frame = CGRectMake(Width - 10 - 68*3, 0, 68, 44);
                    [self.btnyapan setBackgroundImage:[UIImage imageNamed:@"pankou3"] forState:UIControlStateNormal];
                    [self.btnyapan setBackgroundImage:[UIImage imageNamed:@"pankousel3"] forState:UIControlStateSelected];
                    self.btnyapan.tag = 8002;
                    [self.btnyapan addTarget:self action:@selector(selectedPeilv:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:self.btnyapan];
                    [_arrPeilvBtns addObject:self.btnyapan];
                        for (NSString *numP in arrPeilv) {
                            if (8000 == [numP intValue]) {
                                self.btnoupei.selected =  YES;
                            }
                            if (8001 == [numP intValue]) {
                                self.btndaxiao.selected =  YES;
                            }
                            if (8002 == [numP intValue]) {
                                self.btnyapan.selected =  YES;
                            }
                    }
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 2:
                {
                    lab.text = @"提示声音";
                    switchBtn.hidden = YES;
                    NSArray *arrTiShiSY = [[NSUserDefaults standardUserDefaults] arrayForKey:@"BeforeTiShiSY"];
                    _btnTiShiSY = [NSMutableArray array];
                    for (int i = 1; i < 4; i++) {
                        UIButton *btnTiShiSY = [UIButton buttonWithType:UIButtonTypeCustom];
                        btnTiShiSY.frame = CGRectMake(Width - 10 - 68*(i), 0, 68, 44);
                        [btnTiShiSY setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"tishishengyin%d",i]] forState:UIControlStateNormal];
                        [btnTiShiSY setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"tishishengyinsel%d",i]] forState:UIControlStateSelected];
                        btnTiShiSY.selected = NO;
                        btnTiShiSY.tag = i + 5000;
                        if (![[NSUserDefaults standardUserDefaults] arrayForKey:@"BeforeTiShiSY"]) {
                            if (btnTiShiSY.tag == 5001) {
                                btnTiShiSY.selected = YES;
                                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"koushao"];
                                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"huanhu"];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                            }
                        }else{
                            for (NSString *numP in arrTiShiSY) {
                                if (i+5000 == [numP intValue]) {
                                    btnTiShiSY.selected = YES;
                                }
                            }
                        }
                        [btnTiShiSY addTarget:self action:@selector(tiShiSYClick:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.contentView addSubview:btnTiShiSY];
                        [_btnTiShiSY addObject:btnTiShiSY];
                    }
                }
                    break;
                case 0:
                {
                    lab.text = @"进球提示";
                    switchBtn.hidden = YES;
                    NSArray *arrJinQiuTS = [[NSUserDefaults standardUserDefaults] arrayForKey:@"BeforeJinQiuTS"];
                    _btnJinQiuTS = [NSMutableArray array];
                    for (int i = 1; i < 4; i++) {
                        UIButton *btnJinQiuTS = [UIButton buttonWithType:UIButtonTypeCustom];
                        btnJinQiuTS.frame = CGRectMake(Width - 10 - 68*(i), 0, 68, 44);
                        [btnJinQiuTS setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"jingqiu%d",i]] forState:UIControlStateNormal];
                        [btnJinQiuTS setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"jingqiusel%d",i]] forState:UIControlStateSelected];
                        btnJinQiuTS.tag = i + 3000;
                        if (![[NSUserDefaults standardUserDefaults] arrayForKey:@"BeforeJinQiuTS"]) {
                            if (btnJinQiuTS.tag == 3001 || btnJinQiuTS.tag == 3003) {
                                btnJinQiuTS.selected = YES;
                                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"jinqiutanchuan"];
                                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"jinqiushengying"];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                            }
                        }else{
                            for (NSString *numP in arrJinQiuTS) {
                                if (i+3000 == [numP intValue]) {
                                    btnJinQiuTS.selected = YES;
                                }
                            }
                        }
                        [btnJinQiuTS addTarget:self action:@selector(jinQiuTSClick:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.contentView addSubview:btnJinQiuTS];
                        [_btnJinQiuTS addObject:btnJinQiuTS];
                    }
                }
                    break;
                case 3:
                {
                    lab.text = @"提示范围";
                    switchBtn.hidden = YES;
                    NSArray *arrTiShiFW = [[NSUserDefaults standardUserDefaults] arrayForKey:@"BeforeTiShiFW"];
                    _btnTiShiFW = [NSMutableArray array];
                    for (int i = 1; i < 3; i++) {
                        UIButton *btnTiShiFW = [UIButton buttonWithType:UIButtonTypeCustom];
                        btnTiShiFW.frame = CGRectMake(Width - 15 - 81.5*(i) - 10*(i -1), 0, 81.5, 44);
                        [btnTiShiFW setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"tishifanwei%d",i]] forState:UIControlStateNormal];
                        [btnTiShiFW setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"tishifanweisel%d",i]] forState:UIControlStateSelected];
                        btnTiShiFW.selected = NO;
                        btnTiShiFW.tag = i + 6000;
                        if (![[NSUserDefaults standardUserDefaults] arrayForKey:@"BeforeTiShiFW"]) {
                            if (btnTiShiFW.tag == 6001) {
                                btnTiShiFW.selected = YES;
                                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"attentionMe"];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                            }
                        }else{
                            for (NSString *numP in arrTiShiFW) {
                                if (i+6000 == [numP intValue]) {
                                    btnTiShiFW.selected = YES;
                                }
                            }
                        }
                        [btnTiShiFW addTarget:self action:@selector(tiShiFWClick:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.contentView addSubview:btnTiShiFW];
                        [_btnTiShiFW addObject:btnTiShiFW];
                    }
            }
                    break;
                case 1:
                {
                    lab.text = @"红牌提示";
                    switchBtn.hidden = YES;
                    NSArray *arrHongPaiTS = [[NSUserDefaults standardUserDefaults] arrayForKey:@"BeforeHongPaiTS"];
                    _btnHongPaiTS = [NSMutableArray array];
                    for (int i = 1; i < 4; i++) {
                        UIButton *btnHongPaiTS = [UIButton buttonWithType:UIButtonTypeCustom];
                        btnHongPaiTS.frame = CGRectMake(Width - 10 - 68*(i), 0, 68, 44);
                        [btnHongPaiTS setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"jingqiu%d",i]] forState:UIControlStateNormal];
                        [btnHongPaiTS setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"jingqiusel%d",i]] forState:UIControlStateSelected];
                        btnHongPaiTS.tag = i + 4000;
                        if (![[NSUserDefaults standardUserDefaults] arrayForKey:@"BeforeHongPaiTS"]) {
                            if (btnHongPaiTS.tag == 4001 || btnHongPaiTS.tag == 4003) {
                                btnHongPaiTS.selected = YES;
                                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hongpaitanchuang"];
                                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hongpaitishi"];
                                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hongpaishenying"];
                                [[NSUserDefaults standardUserDefaults] synchronize];
                            }
                        }else{
                            for (NSString *numP in arrHongPaiTS) {
                                if (i+4000 == [numP intValue]) {
                                    btnHongPaiTS.selected = YES;
                                }
                            }
                        }
                        [btnHongPaiTS addTarget:self action:@selector(hongPaiTSClick:) forControlEvents:UIControlEventTouchUpInside];
                        [cell.contentView addSubview:btnHongPaiTS];
                        [_btnHongPaiTS addObject:btnHongPaiTS];
                    }
            }
                    break;
                default:
                    break;
            }
        }
            break;
        case 3: 
        {
            switch (indexPath.row) {
                case 0: 
                    lab.text = @"屏幕防休眠";
                    switchBtn.tag = 31;
                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"screenSleep"]) {
                        switchBtn.on = YES;
                    }else{
                        switchBtn.on = NO;
                    }
                    break;
                case 1: 
                    lab.text = @"夜间免打扰";
                    switchBtn.tag = 32;
                    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"nightStop"]) {
                        switchBtn.on = YES;
                    }else{
                        switchBtn.on = NO;
                    }
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return  10;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        return 32 + 40;
    }
    return 0.00001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 44)];
    view.backgroundColor = colorF5;
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 44/2 - 6, Width - 40, 12)];
    lab.textAlignment = NSTextAlignmentLeft;
    lab.font = font15;
    lab.textColor = redcolor;
    switch (section) {
        case 0:
            lab.text = @"比分设置";
            break;
        case 1:
            lab.text = @"";
            break;
        case 2:
            lab.text = @"显示设置";
            break;
        case 3:
            lab.text = @"其他设置";
            break;
        default:
            break;
    }
    [view addSubview:lab];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 3) { 
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 32 + 40)];
        footer.backgroundColor = colorTableViewBackgroundColor;
        UILabel *labDetail = [[UILabel alloc] initWithFrame:CGRectMake(20, 72 / 2, Width-40, 32)];
        labDetail.numberOfLines = 0;
        labDetail.font = font11;
        labDetail.textColor = grayColor34;
        labDetail.text = @"提示:开启夜间免打扰，滚球APP只会在早上8:00---晚上23：00提醒和推送内容";
        [footer addSubview:labDetail];
        return footer;
    }
    return nil;
}
- (void)switchBtn:(UISwitch *)switchBtn
{
    NSLog(@"%ld,%d",(long)switchBtn.tag,switchBtn.on);
    switch (switchBtn.tag) {
        case 0:
        {
        }
            break;
        case 1:
        {
        }
            break;
        case 2:
        {
        }
            break;
        case 3:
        {
        }
            break;
        case 4:
        {
        }
            break;
        case 5:
        {
        }
            break;
        case 10:
        {
            _changedShowSortType = YES;
            if (switchBtn.on) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"qiuduipaiming"];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"qiuduipaiming"];
            }
        }
            break;
        case 11:
        {
            _changedShowSortType = YES;
            if (switchBtn.on) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"jiaoqiu"];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"jiaoqiu"];
            }
        }
            break;
        case 12:
        {
            _changedShowSortType = YES;
            if (switchBtn.on) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hongpai"];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"hongpai"];
            }
        }
            break;
        case 13:
        {
            _changedShowSortType = YES;
        }
            break;
        case 14:
        {
            _changedShowSortType = YES;
            if (switchBtn.on) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"bianhao"];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"bianhao"];
            }
        }
            break;
        case 15:
        {
            _changedShowSortType = YES;
            if (switchBtn.on) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"peilv"];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"peilv"];
            }
        }
            break;
        case 20:
        {
            if (switchBtn.on) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"shengyin"];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"shengyin"];
            }
        }
            break;
        case 21:
        {
            if (switchBtn.on) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"jinqiu"];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"jinqiu"];
            }
        }
            break;
        case 22:
        {
            if (switchBtn.on) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"zhendong"];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"zhendong"];
            }
        }
            break;
        case 23:
        {
            if (switchBtn.on) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hongpaitishi"];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"hongpaitishi"];
            }
        }
            break;
        case 24:
        {
            if (switchBtn.on) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"6666666666"];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"6666666666"];
            }
        }
            break;
        case 25:
        {
            if (switchBtn.on) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"6666666666"];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"6666666666"];
            }
        }
            break;
        case 30:
        {
            if (switchBtn.on) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"attentionMe"];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"attentionMe"];
            }
        }
            break;
        case 31:
        {
            if (switchBtn.on) {
                [UIApplication sharedApplication].idleTimerDisabled =YES;
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"screenSleep"];
            }else{
                [UIApplication sharedApplication].idleTimerDisabled =NO;
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"screenSleep"];
            }
        }
            break;
        case 32:
        {
            if (switchBtn.on) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"nightStop"];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"nightStop"];
            }
        }
            break;
        case 33:
        {
            if (switchBtn.on) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"6666666666"];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"6666666666"];
            }
        }
            break;
        case 34:
        {
            if (switchBtn.on) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"6666666666"];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"6666666666"];
            }
        }
            break;
        case 35:
        {
            if (switchBtn.on) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"6666666666"];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"6666666666"];
            }
        }
            break;
        default:
            break;
    }
}
- (void)selectedPeilv:(UIButton *)btn
{
    switch (btn.tag) {
        case 8000:
            if (!self.btnoupei.selected) {
                self.btnoupei.selected = YES;
                self.btnyapan.selected = NO;
                self.btndaxiao.selected = YES;
            }
            break;
        case 8001:
            if (!self.btndaxiao.selected) {
                self.btndaxiao.selected = YES;
                self.btnoupei.selected = NO;
                self.btnyapan.selected = YES;
            }
            break;
        case 8002:
            if (!self.btnyapan.selected) {
                self.btnyapan.selected = YES;
                self.btndaxiao.selected = NO;
                self.btnoupei.selected = YES;
            }
            break;
        default:
            break;
    }
}
- (void)xianshiClick:(UIButton *)btn {
    int count = 0;
    for (UIButton *yYBtn in _btnXianshiFS) {
        if (yYBtn.selected) {
            count ++;
            yYBtn.selected = NO;
            if (count == 1) {
                btn.selected = NO;
            }
        }
    }
    btn.selected = !btn.selected;
    switch (btn.tag) {
        case 1001:
            if (btn.selected == YES) {
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kaisaishijian"];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kaisaisaishi"];
                _changedListType = YES;
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loadedBifenData"];
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"youjinqiu"];
[[NSUserDefaults standardUserDefaults] synchronize];
                if ([[NSUserDefaults standardUserDefaults] boolForKey:@"loadedBifenData"]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationTogetAllJishibifen" object:nil];
                }
            }else{
            }
            break;
        case 1002:
            if (btn.selected == YES) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"kaisaishijian"];
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"kaisaisaishi"];
                _changedListType = YES;
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loadedBifenData"];
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"youjinqiu"];
[[NSUserDefaults standardUserDefaults] synchronize];
                if ([[NSUserDefaults standardUserDefaults] boolForKey:@"loadedBifenData"]) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationTogetAllJishibifen" object:nil];
                }
            }else{
            }
            break;
        default:
            break;
    }
}
- (void)moRenBFClick:(UIButton *)btn {
    int count = 0;
    for (UIButton *yYBtn in _btnMoRenBF) {
        if (yYBtn.selected) {
            count ++;
            yYBtn.selected = NO;
            if (count == 1) {
                btn.selected = NO;
            }
        }
    }
    btn.selected = !btn.selected;
    switch (btn.tag) {
        case 2001:
        {
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"allbifen"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"jingcaibifen"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
            break;
        case 2002:
        {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"allbifen"];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"jingcaibifen"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
            break;
        default:
            break;
    }
}
- (void)jinQiuTSClick:(UIButton *)btn {
    switch (btn.tag) {
        case 3001:
        {
            if (btn.selected == YES) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"jinqiutanchuan"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"jinqiutanchuan"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
            break;
        case 3002:
        {
            if (btn.selected == YES) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"jinqiuzhendong"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"jinqiuzhendong"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            }
        }
            break;
        case 3003:
        {
            if (btn.selected == YES) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"jinqiushengying"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"jinqiushengying"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
            break;
        default:
            break;
    }
    btn.selected = !btn.selected;
}
- (void)hongPaiTSClick:(UIButton *)btn {
    switch (btn.tag) {
        case 4001:
        {
            if (btn.selected == YES) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hongpaitanchuang"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"hongpaitanchuang"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
            break;
        case 4002:
        {
            if (btn.selected == YES) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hongpaizhendong"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"hongpaizhendong"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            }
        }
            break;
        case 4003:
        {
            if (btn.selected == YES) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hongpaishenying"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }else{
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"hongpaishenying"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
            break;
        default:
            break;
    }
    btn.selected = !btn.selected;
}
- (void)tiShiSYClick:(UIButton *)btn {
    int count = 0;
    for (UIButton *yYBtn in _btnTiShiSY) {
        if (yYBtn.selected) {
            count ++;
            yYBtn.selected = NO;
            if (count == 1) {
                btn.selected = NO;
            }
        }
    }
    btn.selected = !btn.selected;
    switch (btn.tag) {
        case 5001:
        {
            if (btn.selected == YES) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"koushao"];
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"huanhu"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self setMusicFunc];
            }
        }
            break;
        case 5002:
        {
            if (btn.selected == YES) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"huanhu"];
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"koushao"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self setMusicFunc];
            }
        }
            break;
        default:
            break;
            }
}
- (void)tiShiFWClick:(UIButton *)btn {
    int count = 0;
    for (UIButton *yYBtn in _btnTiShiFW) {
        if (yYBtn.selected) {
            count ++;
            yYBtn.selected = NO;
            if (count == 1) {
                btn.selected = NO;
            }
        }
    }
    btn.selected = !btn.selected;
    switch (btn.tag) {
        case 6001:
        {
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"attentionMe"];
        }
            break;
        case 6002:
        {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"attentionMe"];
        }
            break;
        default:
            break;
    }
}
- (void)yuYanClick:(UIButton *)btn {
    int count = 0;
    for (UIButton *yYBtn in _btnYuYan) {
        if (yYBtn.selected) {
            count ++;
            yYBtn.selected = NO;
            if (count == 1) {
                btn.selected = NO;
            }
        }
    }
    btn.selected = !btn.selected;
}
- (void)musicShowJinqiu
    {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jinqiushengying"]) {
            NSString *path = nil;
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"huanhu"]) {
                path = [[NSBundle mainBundle] pathForResource:@"music11" ofType:@"wav"];
            }else if([[NSUserDefaults standardUserDefaults] boolForKey:@"koushao"]){
                path = [[NSBundle mainBundle] pathForResource:@"music1" ofType:@"wav"];
            }
            if (path) {
                AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&shake_sound_id);
                AudioServicesPlaySystemSound(shake_sound_id);
            }
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jinqiuzhendong"]) {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);   
            }
        }else{
            if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jinqiuzhendong"]) {
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);   
            }
        }
    }
- (void)setMusicFunc {
    NSString *path = nil;
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"huanhu"]) {
        path = [[NSBundle mainBundle] pathForResource:@"music11" ofType:@"wav"];
    }else if([[NSUserDefaults standardUserDefaults] boolForKey:@"koushao"]){
        path = [[NSBundle mainBundle] pathForResource:@"music1" ofType:@"wav"];
    }
    if (path) {
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&shake_sound_id);
        AudioServicesPlaySystemSound(shake_sound_id);
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"jinqiuzhendong"]) {
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
