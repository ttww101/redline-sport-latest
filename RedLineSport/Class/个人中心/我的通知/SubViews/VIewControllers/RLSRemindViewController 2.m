#import "RLSRemindViewController.h"
#import "RLSRemindModel.h"
#import "RLSTuijianDetailVC.h"
#define cellRemindViewController @"cellRemindViewController"
@interface RLSRemindViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) RLSBasicTableView *tableView;
@property (nonatomic, strong) NSArray *arrData;
@end
@implementation RLSRemindViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.defaultFailure = @"";
    [self.view addSubview:self.tableView];
    [self loadUreadRemind];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark -- UITableViewDataSource
- (UITableView *)tableView
{
    if (!_tableView) {
        self.tableView = [[RLSBasicTableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellRemindViewController];
        self.tableView.delegate =self;
        self.tableView.dataSource = self;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
    }
    return _tableView;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.defaultFailure isEqualToString:@""]) {
        return [UIImage imageNamed:@"white"];
    }
    if ([self.defaultFailure isEqualToString:@"似乎已断开与互联网的连接。"]) {
        return [UIImage imageNamed:@"dNotnet"];
    }
    return [UIImage imageNamed:@"d1"];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    if ([self.defaultFailure isEqualToString:@""]) {
        NSString *text = @"暂无数据";
        NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor clearColor]};
        return [[NSAttributedString alloc] initWithString:text attributes:attributes];
    }
    NSString *text = self.defaultFailure;
    NSDictionary *attributes = @{NSFontAttributeName: font12, NSForegroundColorAttributeName: [UIColor grayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellRemindViewController];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellRemindViewController];
    }
    while ([cell.contentView.subviews lastObject]!= nil) {
        [[cell.contentView.subviews lastObject] removeFromSuperview];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    RLSRemindModel *model = [_arrData objectAtIndex:indexPath.row];
    UILabel *labNew = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 8, 8)];
    labNew.textColor = [UIColor clearColor];
    labNew.font = font12;
    labNew.layer.cornerRadius = 4;
    labNew.layer.masksToBounds = YES;
    labNew.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:labNew];
    UILabel *labtime = [[UILabel alloc] initWithFrame:CGRectMake(labNew.right + 10, 0, Width - labNew.right - 10 - 20, 18)];
    labtime.center = CGPointMake(labtime.center.x, labNew.center.y);
    labtime.textColor = color99;
    labtime.font = font10;
    labtime.text = [RLSMethods timeToNowWith:model.time];
    [cell.contentView addSubview:labtime];
    UILabel *labTitle = [[UILabel alloc] initWithFrame:CGRectMake(labtime.x, labtime.bottom, labtime.width, 20)];
    labTitle.font = font14;
    labTitle.text = [NSString stringWithFormat:@"%@ 发布新推荐",model.nickname];
    [cell.contentView addSubview:labTitle];
    UILabel *labcontent = [[UILabel alloc] initWithFrame:CGRectMake(labtime.x, labTitle.bottom, labtime.width, 24)];
    labcontent.font = font14;
    labcontent.text= [NSString stringWithFormat:@"%@ %@ %@ vs %@",model.mtime,model.league,model.hometeam,model.guestteam];
    [cell.contentView addSubview:labcontent];
    if (!model.iread) {
        labcontent.textColor = color33;
        labTitle.textColor = bluecolor;
        labNew.backgroundColor = redcolor;
        labTitle.attributedText = [RLSMethods withContent:labTitle.text WithColorText:@"发布新推荐" textColor:color66 strFont:font12];
    }else{
        labcontent.textColor = color66;
        labTitle.textColor = color66;
        labNew.backgroundColor = [UIColor clearColor];
        labTitle.attributedText = [RLSMethods withContent:labTitle.text WithColorText:@"发布新推荐" textColor:color66 strFont:font12];
    }
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(20, 89, Width- 20, 0.6)];
    viewLine.backgroundColor = colorCellLine;
    [cell.contentView addSubview:viewLine];
    return cell;
    return nil;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.arrData.count==0) {
        return;
    }
    RLSRemindModel *model = [_arrData objectAtIndex:indexPath.row];
    if (model.iread) {
    }else{
        [self updateNoticeWithNoticeId:model];
    }
    RLSTuijianDetailVC *tuijianDT = [[RLSTuijianDetailVC alloc] init];
    tuijianDT.modelId =model.newsid;
    tuijianDT.typeTuijianDetailHeader = model.type;
    tuijianDT.hidesBottomBarWhenPushed = YES;
    [APPDELEGATE.customTabbar pushToViewController:tuijianDT animated:YES];
}
-  (void)loadUreadRemind
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:@"4" forKey:@"flag"];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_noticedo] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _arrData = [[NSArray alloc] initWithArray:[RLSRemindModel arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]]];
            self.defaultFailure =@"暂无提醒";
            [self.tableView reloadData];
        }else{
            self.defaultFailure =[responseOrignal objectForKey:@"msg"];
            [self.tableView reloadData];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        self.defaultFailure =errorDict;
        [self.tableView reloadData];
    }];
}
-  (void)updateNoticeWithNoticeId:(RLSRemindModel *)model
{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parameter setObject:@"2" forKey:@"flag"];
    [parameter setObject:[NSString stringWithFormat:@"%ld",(long)model.mid] forKey:@"mid"];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_noticedo] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            model.iread = YES;
        }else{
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
    }];
}
@end
