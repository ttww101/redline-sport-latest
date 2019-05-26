#import "RLSAnQuanCenterVC.h"
#import "RLSRealNameCerVC.h"
#import "RLSChangePassWordVC.h"
#import "RLSMyProfileVC.h"
#import "RLSBangAccountVC.h"
@interface RLSAnQuanCenterVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *tableView;
@end
@implementation RLSAnQuanCenterVC
- (void)viewWillAppear:(BOOL)animated{
    _model = [RLSMethods getUserModel];
    [self.tableView reloadData];
     [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavView];
    [self.view addSubview:self.tableView];
}
#pragma mark -- setnavView
- (void)setNavView{
        RLSNavView *nav = [[RLSNavView alloc] init];
        nav.delegate = self;
        nav.labTitle.text = @"安全中心";
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
    }else if(index == 2){
    }
}
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
    return 1; 
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 2;
        }
            break;
        default:
            break;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
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
    UIImageView *imageMore = [[UIImageView alloc] initWithFrame:CGRectMake(Width - 15 - 7, 0, 7, 14)];
    imageMore.center = CGPointMake(imageMore.center.x, lab.center.y);
    imageMore.image = [UIImage imageNamed:@"meRight"];
    [cell.contentView addSubview:imageMore];
    UIView *viewline = [[UIView alloc] initWithFrame:CGRectMake(20, 43, Width - 20, 0.5)];
    viewline.backgroundColor = colorCellLine;
    [cell.contentView addSubview:viewline];
    UILabel *labStr = [[UILabel alloc] init];
    labStr.font = font12;
    labStr.textAlignment = NSTextAlignmentRight;
    labStr.textColor = color99;
    [cell.contentView addSubview:labStr];
    [labStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(imageMore.mas_left).offset(-15);
        make.top.mas_equalTo(cell.contentView.mas_top);
        make.height.mas_offset(44);
        make.width.mas_offset(50);
    }];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
//            case 0:
//            {
//                lab.text = @"实名认证";
//                if (self.model.autonym == 1) {
//                    labStr.text = @"已认证";
//                }else{
//                    labStr.text = @"未认证";
//                }
//            }
//                break;
            case 0:
            {
                lab.text = @"账户绑定";
                if (_model.mobile.length > 0) {
                    labStr.text = @"修改";
                }else{
                    labStr.text = @"绑定";
                }
            }
                break;
            case 1:
            {
                lab.text = @"修改密码";
                labStr.text = @"修改";
                viewline.backgroundColor = [UIColor clearColor];
            }
                break;
            default:
                break;
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                RLSRealNameCerVC *realNameVC = [[RLSRealNameCerVC alloc] init];
                realNameVC.type = 0;
                realNameVC.hidesBottomBarWhenPushed = YES;
                [APPDELEGATE.customTabbar pushToViewController:realNameVC animated:YES];
            }
                break;
            case 1:{
                RLSBangAccountVC *bangVC = [[RLSBangAccountVC alloc] init];
                bangVC.hidesBottomBarWhenPushed = YES;
                [APPDELEGATE.customTabbar pushToViewController:bangVC animated:YES];
            }
                break;
            case 2:{
                RLSChangePassWordVC *psssWordVC = [[RLSChangePassWordVC alloc] init];
                psssWordVC.hidesBottomBarWhenPushed = YES;
                [APPDELEGATE.customTabbar pushToViewController:psssWordVC animated:YES];
            }
                break;
            default:
                break;
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
