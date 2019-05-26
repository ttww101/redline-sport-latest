#import "RLSPushSettingVC.h"
@interface RLSPushSettingVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrData;
@end
@implementation RLSPushSettingVC
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
    nav.labTitle.text = @"推送设置";
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [self.view addSubview:nav];
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        [self.navigationController popViewControllerAnimated:YES];
        [self requestPushSetting];
    }else if(index == 2){
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _arrData = [NSMutableArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0", nil];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavView];
    [self loadPushIndex];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePushSwitch) name:NotificationchangePushSwitch object:nil];
}
- (void)changePushSwitch
{
    [self.tableView reloadData];
}
#pragma mark -- UITableViewDataSource
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.backgroundColor = colorTableViewBackgroundColor;
        _tableView.delegate =self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 0)];
            return header;
        }
            break;
        case 1:
        {
            UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 44)];
            header.backgroundColor = colorTableViewBackgroundColor;
            UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, Width - 20, 44)];
            labTitle.font = font16;
            labTitle.textColor = redcolor;
            labTitle.text = @"我关注的分析师";
            [header addSubview:labTitle];
            return header;
        }
            break;
        case 2:
        {
            UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 44)];
            header.backgroundColor = colorTableViewBackgroundColor;
            UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, Width - 20, 44)];
            labTitle.font = font16;
            labTitle.textColor = redcolor;
            labTitle.text = @"我关注的比赛";
            [header addSubview:labTitle];
            return header;
        }
            break;
        default:
            break;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 0.00001;
        }
            break;
        case 1:
        {
            return 44;
        }
            break;
        case 2:
        {
            return 44;
        }
            break;
        default:
            break;
    }
    return 0.000001;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 30 + 15 + 15)];
            footer.backgroundColor = [UIColor whiteColor];
            UILabel *labDetail = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, Width-40, 30)];
            labDetail.numberOfLines = 2;
            labDetail.font = font10;
            labDetail.textColor = color66;
            labDetail.text = @"要开启或者关闭滚球体育的推送通知,请在iphone的\"设置\"-\"通知\"中找到滚球体育进行设置";
            NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:labDetail.text];
            NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:@"设置"].location, [[noteStr string] rangeOfString:@"设置"].length);
            [noteStr addAttribute:NSForegroundColorAttributeName value:color07BDEB range:redRange];
            [noteStr addAttribute:NSFontAttributeName value:font10 range:redRange];
            NSRange redRange1 = NSMakeRange([[noteStr string] rangeOfString:@"通知"].location, [[noteStr string] rangeOfString:@"通知"].length);
            [noteStr addAttribute:NSForegroundColorAttributeName value:color07BDEB range:redRange1];
            [noteStr addAttribute:NSFontAttributeName value:font10 range:redRange1];
            NSRange redRange2 = NSMakeRange([[noteStr string] rangeOfString:@"滚球"].location, [[noteStr string] rangeOfString:@"滚球"].length);
            [noteStr addAttribute:NSForegroundColorAttributeName value:color07BDEB range:redRange2];
            [noteStr addAttribute:NSFontAttributeName value:font10 range:redRange2];
            labDetail.attributedText = noteStr;
            UIView *viewline = [[UIView alloc] initWithFrame:CGRectMake(0, 59.5, Width - 0, 0.5)];
            viewline.backgroundColor = colorCellLine;
            [footer addSubview:viewline];
            [footer addSubview:labDetail];
            return footer;
        }
            break;
        case 1:
        {
            UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 0)];
            return header;
        }
            break;
        case 2:
        {
            UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 0)];
            return header;
        }
            break;
        default:
            break;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 60;
        }
            break;
        default:
            break;
    }
    return 0.000001;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 1;
        }
            break;
        case 1:
        {
            return 1;
        }
            break;
        case 2:
        {
            return 4;
        }
            break;
        default:
            break;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    while ([cell.contentView.subviews lastObject]!= nil) {
        [[cell.contentView.subviews lastObject] removeFromSuperview];
    }
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, Width - 40, 44)];
    lab.textColor = color33;
    lab.font = font16;
    [cell.contentView addSubview:lab];
    UIView *viewline = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, Width - 0, 0.5)];
    viewline.backgroundColor = colorCellLine;
    [cell.contentView addSubview:viewline];
    UISwitch *switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(Width - 60, 0, 51, 31)];
    switchBtn.center = CGPointMake(switchBtn.center.x, 22);
    switchBtn.onTintColor = redcolor;
    switchBtn.on = NO;
    [switchBtn addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
    [cell.contentView addSubview:switchBtn];
    if (indexPath.section == 0) {
        lab.text = @"接收推送通知";
        viewline.backgroundColor = [UIColor clearColor];
        switchBtn.userInteractionEnabled = NO;
        switchBtn.tag = 0;
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types == 0) {
            switchBtn.on = NO;
        }else{
            switchBtn.on = YES;
        }
    }else if (indexPath.section == 1){
        lab.text = @"分析师推荐";
        switchBtn.on = [[_arrData objectAtIndex:0] isEqualToString:@"1"]? YES:NO;
        switchBtn.tag = 10;
    }else{
        switch (indexPath.row) {
            case 0:
            {
                lab.text = @"开赛推送";
                switchBtn.tag = 20;
                switchBtn.on = [[_arrData objectAtIndex:1] isEqualToString:@"1"]? YES:NO;
            }
                break;
            case 1:
            {
                lab.text = @"进球推送";
                switchBtn.tag = 21;
                switchBtn.on = [[_arrData objectAtIndex:2] isEqualToString:@"1"]? YES:NO;
            }
                break;
            case 2:
            {
                lab.text = @"红牌推送";
                switchBtn.tag = 22;
                switchBtn.on = [[_arrData objectAtIndex:3] isEqualToString:@"1"]? YES:NO;
            }
                break;
            case 3:
            {
                lab.text = @"完场推送";
                switchBtn.tag = 23;
                switchBtn.on = [[_arrData objectAtIndex:4] isEqualToString:@"1"]? YES:NO;
            }
                break;
            default:
                break;
        }
   }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (void)changeSwitch:(UISwitch *)switchBtn
{
    switch (switchBtn.tag) {
        case 10:
        {
            [_arrData replaceObjectAtIndex:0 withObject:switchBtn.on?@"1":@"0"];
        }
            break;
        case 20:
        {
            [_arrData replaceObjectAtIndex:1 withObject:switchBtn.on?@"1":@"0"];
        }
            break;
        case 21:
        {
            [_arrData replaceObjectAtIndex:2 withObject:switchBtn.on?@"1":@"0"];
        }
            break;
        case 22:
        {
            [_arrData replaceObjectAtIndex:3 withObject:switchBtn.on?@"1":@"0"];
        }
            break;
        case 23:
        {
            [_arrData replaceObjectAtIndex:4 withObject:switchBtn.on?@"1":@"0"];
        }
            break;
        default:
            break;
    }
}
- (void)requestPushSetting
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    NSString *pushType = @"";
    for (int i = 0; i<_arrData.count; i++) {
        if ([[_arrData objectAtIndex:i] isEqualToString:@"1"]) {
            pushType = [NSString stringWithFormat:@"%@%d,",pushType,(int)powl(2, i)];
        }
    }
    if ([pushType isEqualToString:@""]) {
        pushType = @"0";
    }
    [parameter setObject:pushType forKey:@"pushTypes"];
    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post"  WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_push_setting]  ArrayFile:nil Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
        }else{
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
}
- (void)loadPushIndex
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post"  WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_push_index]  ArrayFile:nil Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            NSArray *arrIndex= [NSArray arrayWithArray:[responseOrignal objectForKey:@"data"]];
            for (int i = 0; i<arrIndex.count; i++) {
                NSInteger index = [[arrIndex objectAtIndex:i] integerValue];
                if (index == 1) {
                    [_arrData replaceObjectAtIndex:0 withObject:@"1"];
                }else if (index == 2) {
                    [_arrData replaceObjectAtIndex:1 withObject:@"1"];
                }else if (index == 4) {
                    [_arrData replaceObjectAtIndex:2 withObject:@"1"];
                }else if (index == 8) {
                    [_arrData replaceObjectAtIndex:3 withObject:@"1"];
                }else if (index == 16) {
                    [_arrData replaceObjectAtIndex:4 withObject:@"1"];
                }
            }
            [self.view addSubview:self.tableView];
            [self.tableView reloadData];
        }else{
            [self.view addSubview:self.tableView];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [self.view addSubview:self.tableView];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
