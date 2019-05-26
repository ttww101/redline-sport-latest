#import "RLSAnalystsEventFilterVC.h"
@interface RLSAnalystsEventFilterVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *arrData;
@property (nonatomic, strong) NSMutableArray *arrBtn;
@property (nonatomic, strong) NSMutableArray *selectBtn;
@end
@implementation RLSAnalystsEventFilterVC
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = colorTableViewBackgroundColor;
    _arrData = [[NSArray alloc] initWithObjects:@"英超",@"西甲",@"德甲",@"意甲",@"法甲",@"欧冠",@"欧罗巴",@"中超",@"日联",@"韩k",@"澳超",@"瑞典超",@"挪威超",@"比甲",@"阿甲",@"巴甲",@"美职联",@"其他", nil];
    _arrBtn = [[NSMutableArray alloc] initWithCapacity:0];
    _selectBtn = [[NSMutableArray alloc] initWithCapacity:0];
    [self setNavView];
    [self.view addSubview:self.collectionView];
}
#pragma mark -- setnavView
- (void)setNavView{
    RLSNavView *nav = [[RLSNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"赛事筛选";
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [nav.btnRight setTitle:@"确定 " forState:UIControlStateNormal];
    [self.view addSubview:nav];
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(index == 2){
        NSString *str =  [_selectBtn componentsJoinedByString:@","];
        if (self.delegate && [self.delegate respondsToSelector:@selector(backStr:)]) {
            [self.delegate backStr:str];
        }
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"%@",str);
    }
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setItemSize:CGSizeMake((Width - 50) / 3, 30)];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.sectionInset = UIEdgeInsetsMake(20, 15, 20, 15);
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar , Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar )collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _arrData.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"UICollectionViewCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, cell.contentView.width, cell.contentView.height);
    [btn setTitle:_arrData[indexPath.row] forState:UIControlStateNormal];
    btn.titleLabel.font = font12;
    [btn setTitleColor:color33 forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    btn.layer.borderWidth = 0.6;
    btn.layer.borderColor = colorCellLine.CGColor;
    btn.layer.cornerRadius = 3;
    [cell.contentView addSubview:btn];
    btn.tag = indexPath.row;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_arrBtn addObject:btn];
    return cell;
}
- (void)btnClick:(UIButton *)selebtn{
    selebtn.selected = !selebtn.selected;
    if (selebtn.selected) {
        if (_selectBtn.count == 5) {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"最多选择5个联赛"];
            return;
        }
        for (int i = 0; i < _arrBtn.count; i ++) {
            UIButton *btn = _arrBtn[i];
            if (selebtn.tag == btn.tag) {
                [selebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                selebtn.backgroundColor = redcolor;
                [_selectBtn addObject:btn.titleLabel.text];
            }
        }
    }else{
        for (int i = 0; i < _arrBtn.count; i ++) {
            UIButton *btn = _arrBtn[i];
            if (selebtn.tag == btn.tag) {
                [selebtn setTitleColor:color33 forState:UIControlStateNormal];
                selebtn.backgroundColor = [UIColor whiteColor];
            }
        }
        for (int  i = 0;  i < _selectBtn.count; i ++ ) {
            if ([_selectBtn[i] isEqualToString:selebtn.titleLabel.text] ) {
                [_selectBtn removeObject:selebtn.titleLabel.text];
            }
        }
    }
}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
