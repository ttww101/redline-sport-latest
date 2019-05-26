#import "RLSSearchViewController.h"
#import "RLSTuijiandatingModel.h"
#import "RLSUserlistModel.h"
#import "RLSSearchVCZhujiaCell.h"
@interface RLSSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (strong, nonatomic)  UITableView *tableView;
@property (strong,nonatomic) NSMutableArray  *dataList;
@property (strong,nonatomic) NSMutableArray  *searchList;
@property (strong,nonatomic) NSArray  *arrZhunjia;
@property (nonatomic, strong) NSArray *arrData;
@end
@implementation RLSSearchViewController
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadHotZhuanjia];
    _dataList = [NSMutableArray array];
    _searchList = [NSMutableArray array];
    [_dataList addObjectsFromArray:[NSMutableArray arrayWithContentsOfFile:[self getLocalPath]]];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar,Width ,Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, Width, APPDELEGATE.customTabbar.height_myNavigationBar)];
    _searchBar.backgroundColor = [UIColor whiteColor];
    _searchBar.barTintColor = redcolor;
    _searchBar.tintColor = [UIColor blackColor];
    _searchBar.scopeBarBackgroundImage = [UIImage imageNamed:@"white"];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"搜索专家";
    UITextField *searchField = [_searchBar valueForKey:@"searchField"];
    searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchField.font = font14;
    if (searchField) {
        [searchField setBackgroundColor:[UIColor whiteColor]];
        searchField.layer.cornerRadius = 5.0f;
        searchField.layer.borderColor = redcolor.CGColor;
        searchField.layer.borderWidth = 1;
        searchField.layer.masksToBounds = YES;
    }
    [self.view addSubview:_tableView];
    self.view.backgroundColor = redcolor;
    [self setNavView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardShow) name:UIKeyboardWillShowNotification object:nil];
}
- (void)KeyboardShow
{
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", _searchBar.text];
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    self.searchList= [NSMutableArray arrayWithArray:[_dataList filteredArrayUsingPredicate:preicate]];
    [self.tableView reloadData];
}
#pragma mark -- setnavView
- (void)setNavView
{
    RLSNavView *nav = [[RLSNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"";
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [nav.btnRight setTitle:@"取消" forState:UIControlStateNormal];
    [nav.btnRight setTitle:@"取消" forState:UIControlStateHighlighted];
    nav.btnRight.titleLabel.font = font14;
    _searchBar.frame = CGRectMake(0, nav.btnLeft.y, Width - nav.btnLeft.width, nav.btnLeft.height);
    [nav addSubview:_searchBar];
    [self.view addSubview:nav];
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
    }else if(index == 2){
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_searchBar.isFirstResponder) {
        return 1;
    }else{
        return 2;
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_searchBar.isFirstResponder) {
        return [self.searchList count];
    }else{
        if (section == 0) {
            return [self.arrZhunjia count];
        }else{
            if (self.dataList.count == 0) {
                return 1;
            }
            return [self.dataList count];
        }
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_searchBar.isFirstResponder) {
        static NSString *acell = @"acell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:acell];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:acell];
        }
        while ([cell.contentView.subviews lastObject]!= nil) {
            [[cell.contentView.subviews lastObject] removeFromSuperview];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(15, 11, 20, 20)];
        img.image = [UIImage imageNamed:@"ic_mer_time"];
        [cell.contentView addSubview:img];
        UILabel *labName = [[UILabel alloc] initWithFrame:CGRectMake(img.right + 9,12, 200, 20)];
        labName.text = self.searchList[indexPath.row];
        labName.textColor = color52;
        labName.font = font14;
        [cell.contentView addSubview:labName];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 42, Width - 20, 0.5)];
        lineView.backgroundColor = colorCellLine;
        [cell.contentView addSubview:lineView];
        return cell;
    }else{
    if (indexPath.section == 0) {
        static NSString *flag=@"cell";
        RLSSearchVCZhujiaCell *cell = [tableView dequeueReusableCellWithIdentifier:flag];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"RLSSearchVCZhujiaCell" owner:nil options:nil] firstObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = [self.arrZhunjia objectAtIndex:indexPath.row];
        if (indexPath.row == self.arrZhunjia.count -1) {
            cell.viewBottom.backgroundColor = [UIColor whiteColor];
        }else{
            cell.viewBottom.backgroundColor = colorCellLine;
        }
        return cell;
    }
    static NSString *acell = @"acell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:acell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:acell];
    }
        while ([cell.contentView.subviews lastObject]!= nil) {
            [[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(15, 11, 20, 20)];
    [cell.contentView addSubview:img];
    UILabel *labName = [[UILabel alloc] initWithFrame:CGRectMake(img.right + 9,12, Width - (img.right + 9)*2, 20)];
    labName.textColor = color52;
    labName.font = font14;
    [cell.contentView addSubview:labName];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 42, Width - 0, 0.5)];
    lineView.backgroundColor = colorCellLine;
    if (self.dataList.count == 0) {
        img.image = [UIImage imageNamed:@"white"];
        labName.text = @"暂无搜索记录";
        labName.textAlignment = NSTextAlignmentCenter;
    }else{
        img.image = [UIImage imageNamed:@"ic_mer_time"];
        labName.text = self.dataList[indexPath.row];
        labName.textAlignment = NSTextAlignmentLeft;
    }
    [cell.contentView addSubview:lineView];
    return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_searchBar.isFirstResponder) {
        return 48;
    }
    if (indexPath.section == 0) {
        return 80;
    }
    return 48;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_searchBar.isFirstResponder) {
        if (indexPath.section == 0) {
            RLSUserlistModel *user = [_arrZhunjia objectAtIndex:indexPath.row];
            if (user.userid == 1) {
                return;
            }
            RLSUserViewController *userVC = [[RLSUserViewController alloc] init];
            userVC.userId = user.userid;
            userVC.userName = user.nickname;
            userVC.userPic = user.pic;
            userVC.hidesBottomBarWhenPushed = YES;
            [APPDELEGATE.customTabbar pushToViewController:userVC animated:YES];
        }else if (indexPath.section == 1){
            if (self.dataList.count == 0) {
                return;
            }
            [self searchTuijianInfoWithName:self.dataList[indexPath.row]];
        }
    }else{
        [self searchTuijianInfoWithName:self.searchList[indexPath.row]];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_searchBar.isFirstResponder) {
        return nil;
    }
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 44)];
    bgView.backgroundColor = [UIColor whiteColor];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 18, 8, 8)];
    lineView.backgroundColor =colorFBAF04;
    [bgView addSubview:lineView];
    UILabel *labHeader = [[UILabel alloc] initWithFrame:CGRectMake(lineView.right + 10, 12, Width, 20)];
    labHeader.text =section == 0? @"热门专家" : @"历史记录";
    labHeader.textColor = color33;
    labHeader.font = font14;
    [bgView addSubview:labHeader];
    UIView *lineViewBottom = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, Width, 0.5)];
    lineViewBottom.backgroundColor =colorCellLine;
    [bgView addSubview:lineViewBottom];
    return bgView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_searchBar.isFirstResponder) {
        return 0;
    }
    return 44;
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        if (!_searchBar.isFirstResponder) {
            UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 10)];
            footer.backgroundColor = colorTableViewBackgroundColor;
            return footer;
        }
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        if (!_searchBar.isFirstResponder) {
            return 10;
        }
    }
    return 0;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;   
{
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchText];
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    self.searchList= [NSMutableArray arrayWithArray:[_dataList filteredArrayUsingPredicate:preicate]];
    [self.tableView reloadData];
}
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0); 
{
    return YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;                     
{
    [self searchTuijianInfoWithName:searchBar.text];
    [_searchBar resignFirstResponder];
}
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED; 
{
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED;   
{
    [self.navigationController popViewControllerAnimated:YES];
    [_searchBar resignFirstResponder];
}
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar NS_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED; 
{
}
- (void)searchTuijianInfoWithName:(NSString *)nickName
{
    NSMutableDictionary *parmater = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [parmater setObject:nickName forKey:@"nickname"];
    [parmater setObject:@"14" forKey:@"flag"];
    [[RLSDCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:parmater PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_loginAndRegister] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _arrZhunjia = [NSArray arrayWithArray:[RLSUserlistModel  arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]]];
            [_searchBar resignFirstResponder];
            [self.tableView reloadData];
            if (_arrZhunjia.count > 0) {
                if (![self.dataList containsObject:nickName]) {
                    if (self.dataList.count>6) {
                        [self.dataList removeLastObject];
                    }
                    [self.dataList addObject:nickName];
                    [self.dataList writeToFile:[self getLocalPath] atomically:YES];
                }
            }else{
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"没有搜索结果"];
            }
        }else{
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"没有搜索结果"];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"没有搜索结果"];
    }];
}
- (void)loadHotZhuanjia
{
    NSMutableDictionary *parmater = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
    [[RLSDCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:parmater PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_speciallist_hot] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        NSLog(@"%@",responseOrignal);
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            _arrZhunjia = [NSArray arrayWithArray:[RLSUserlistModel  arrayOfEntitiesFromArray:[responseOrignal objectForKey:@"data"]]];
            [self.tableView reloadData];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
    }];
}
- (NSString *)getLocalPath{
    NSString*documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES)firstObject];
    return  [documentsPath stringByAppendingPathComponent:@"searchHistoryArray.plist"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
