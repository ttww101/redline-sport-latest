#define  cellSearchMatchVC @"cellSearchMatchVC"
#import "RLSSaiTableViewCell.h"
#import "RLSLiveScoreModel.h"
#import "RLSJSbifenModel.h"
#import "RLSSearchMatchVC.h"
@interface RLSSearchMatchVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrData;
@end
@implementation RLSSearchMatchVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_searchBar becomeFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavView];
    [self.view addSubview:self.tableView];
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
    [self.view addSubview:nav];
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, Width, 44)];
    _searchBar.backgroundColor = [UIColor whiteColor];
    _searchBar.barTintColor = redcolor;
    _searchBar.tintColor = [UIColor blackColor];
//    _searchBar.backgroundImage = [UIImage imageNamed:@"red"];
    _searchBar.scopeBarBackgroundImage = [UIImage imageNamed:@"white"];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"搜索比赛";
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
    _searchBar.frame = CGRectMake(0, nav.btnLeft.y, Width - nav.btnLeft.width, nav.btnLeft.height);
    [nav addSubview:_searchBar];
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
    }else if(index == 2){
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;   
{
}
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0); 
{
    return YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;                     
{
    [self searchMatchWithName:searchBar.text];
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
#pragma mark -- UITableViewDataSource
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerClass:[RLSSaiTableViewCell class] forCellReuseIdentifier:cellSearchMatchVC];
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_arrData.count > 0) {
        RLSLiveScoreModel *model = [_arrData objectAtIndex:indexPath.row];
        if (model.remark!= nil && ![model.remark isEqualToString:@""]) {
            return 108;
        }
    }
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RLSSaiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellSearchMatchVC];
    if (!cell) {
        cell = [[RLSSaiTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellSearchMatchVC];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_arrData.count >0) {
        cell.ScoreModel = [_arrData objectAtIndex:indexPath.row];
    }
    return cell;
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)searchMatchWithName:(NSString *)searchStr {
//    NSString *urlStage = @"http://120.55.30.173:8809/bifen/live";
    NSString *urlStage = [NSString stringWithFormat:@"%@/bifen2/live",APPDELEGATE.url_Server];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
   [parameter setValue:@(0) forKey:@"return_fmt"];
    [parameter setValue:PARAM_IS_NIL_ERROR(searchStr) forKey:@"query"];
    [parameter setValue:@"all" forKey:@"sub"];
    [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:urlStage Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
           _arrData = [[NSMutableArray alloc] initWithArray:[RLSLiveScoreModel arrayOfEntitiesFromArray:[[responseOrignal objectForKey:@"data"] objectForKey:@"matchs"]]];
            [self.tableView reloadData];
        }
        
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        self.defaultFailure = errorDict;
        [_arrData removeAllObjects];
        self.defaultFailure = default_noMatch;
        [self.tableView reloadData];
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
