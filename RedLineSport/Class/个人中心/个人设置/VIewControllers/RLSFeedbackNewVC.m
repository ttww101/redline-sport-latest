#import "RLSFeedbackNewVC.h"
#import "RLSFeedBackHeaderView.h"
@interface RLSFeedbackNewVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property (nonatomic, strong) RLSNavView                           *nav;
@property (nonatomic, strong) UITableView                       *feedBackTableView;
@property (nonatomic, strong) NSMutableArray                    *commentArr;
@property (nonatomic, strong) UITextView                        *commentTextView;
@property (nonatomic, strong) RLSFeedBackHeaderView                *feedBackHeaderView;
@end
@implementation RLSFeedbackNewVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavView];
    [self.view addSubview:self.feedBackTableView];
}
#pragma mark -- setnavView
- (void)setNavView
{
    _nav = [[RLSNavView alloc] init];
    _nav.delegate = self;
    _nav.labTitle.text = @"意见反馈";
    [_nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [_nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [_nav.btnRight setTitle:@"提交  " forState:UIControlStateNormal];
    _nav.tag = 10;
    _nav.btnRight.titleLabel.font = font14;
    [_nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_nav.btnRight setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [self.view addSubview:_nav];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScrollView)];
    [_nav addGestureRecognizer:tap];
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    [self.view endEditing:YES];
    if (index == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(index == 2){
    }
}
- (UITableView *)feedBackTableView {
    if (!_feedBackTableView) {
        _feedBackTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStyleGrouped];
        _feedBackTableView.delegate = self;
        _feedBackTableView.dataSource = self;
        [_feedBackTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"commentCell"];
    }
    return _feedBackTableView;
}
- (RLSFeedBackHeaderView *)feedBackHeaderView {
    if (!_feedBackHeaderView) {
        _feedBackHeaderView = [[RLSFeedBackHeaderView alloc] initWithFrame:CGRectMake(12, APPDELEGATE.customTabbar.height_myNavigationBar + 10, Width - 30, 331)];
    }
    return _feedBackHeaderView;
}
#pragma mark - UITableViewFunc -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
        default:
            break;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"commentCell" forIndexPath:indexPath];
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            return self.feedBackHeaderView;
        }
            break;
        default:
            break;
    }
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            return 10;
        }
            break;
        case 1:
        {
            return 10;
        }
            break;
        default:
            break;
    }
    return 10;
}
#pragma mark - UITextViewDelegate -
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
}
- (void)textViewDidChange:(UITextView *)textView {
}
#pragma mark - Action -
- (void)tapScrollView {
    [self.view endEditing:YES];
}
@end
