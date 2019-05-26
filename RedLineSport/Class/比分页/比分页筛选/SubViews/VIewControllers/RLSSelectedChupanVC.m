#import "RLSSelectedChupanVC.h"
#import "RLSAllSelectedView.h"
#import "RLSBIfenSelectedSaishiModel.h"
#import "RLSSelectedCCell.h"
#define cellCollectioneSlectedChupan @"cellCollectioneSlectedChupan"
#define headerCollectioneSlectedChupan @"cellCollectioneSlectedChupan"
#define cellCollectionHeight (29)
#define cellCollectionWidth ((Width - 30 - 10)/2)
@interface RLSSelectedChupanVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,AllSelectedViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) RLSAllSelectedView *allselectedV;
@property (nonatomic, strong) NSMutableArray *arrSectionData;
@property (nonatomic, strong) NSMutableArray *arrItemData;
@property (nonatomic, assign) BOOL allBtnIsSelected;
@end
@implementation RLSSelectedChupanVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.allselectedV];
    self.allselectedV.btnAll.selected = _allBtnIsSelected;
    [self.view addSubview:self.collectionView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)setArrData:(NSArray *)arrData
{
    _arrData = arrData;
    if (_arrData.count>0) {
        [self seperateData];
    }
}
- (void)seperateData
{
    _arrSectionData = [NSMutableArray array];
    _arrItemData = [NSMutableArray array];
    NSString *documentPath = [RLSMethods getDocumentsPath];
    NSString *PatharrSaveAll = @"";
    if (_type == typeSaishiSelecterdVCBifen) {
        PatharrSaveAll = [documentPath stringByAppendingPathComponent:arrSaveBifenChupanSelectedPath];
    }else if (_type == typeSaishiSelecterdVCTuijian)
    {
        PatharrSaveAll = [documentPath stringByAppendingPathComponent:arrSaveChupanSelectedPathTuijianJingcai];
    }else if (_type == typeSaishiSelecterdVCInfo)
    {
        PatharrSaveAll = [documentPath stringByAppendingPathComponent:arrSaveChupanSelectedPathinfo];
    }
    NSArray *arrsaveSaishi = [NSKeyedUnarchiver unarchiveObjectWithFile:PatharrSaveAll];
    for (int i = 0; i<_arrData.count; i++) {
        RLSBIfenSelectedSaishiModel *model = [_arrData objectAtIndex:i];
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"loadedBifenData"]) {
            model.isSelected = NO;
            _allBtnIsSelected = NO;
        }else{
            if (arrsaveSaishi.count == 0) {
                model.isSelected = NO;
                _allBtnIsSelected = NO;
            }else{
            model.isSelected = NO;
            for (int j = 0; j<arrsaveSaishi.count; j++) {
                RLSBIfenSelectedSaishiModel *Savemodel = [arrsaveSaishi objectAtIndex:j];
                if ([model.name isEqualToString:Savemodel.name]) {
                    model.isSelected = YES;
                    break;
                }else{
                    model.isSelected = NO;
                }
            }
            }
        }
        if (![_arrSectionData containsObject:model.index]) {
            [_arrSectionData addObject:model.index];
            NSMutableArray *arrItem = [NSMutableArray array];
            [arrItem addObject:model];
            [_arrItemData addObject:arrItem];
        }else{
            NSInteger index = [_arrSectionData indexOfObject:model.index];
            NSMutableArray *arrItem = [_arrItemData objectAtIndex:index];
            [arrItem addObject:model];
        }
    }
}
- (RLSAllSelectedView *)allselectedV
{
    if (!_allselectedV) {
        _allselectedV = [[RLSAllSelectedView alloc] initWithFrame:CGRectMake(0, Height - 44, Width, 44)];
        _allselectedV.delegate = self;
    }
    return _allselectedV;
}
- (void)didSelectedAtBtnIndex:(NSInteger)index whtherSelected:(BOOL)selected
{
    if (index == 0) {
        for (int i = 0; i<_arrData.count; i++) {
            RLSBIfenSelectedSaishiModel *model = [_arrData objectAtIndex:i];
            model.isSelected = YES;
        }
        [self.collectionView reloadData];
    }else if (index == 1) {
        for (int i = 0; i<_arrData.count; i++) {
            RLSBIfenSelectedSaishiModel *model = [_arrData objectAtIndex:i];
            model.isSelected = NO;
        }
        [self.collectionView reloadData];
    }else if (index == 2) {
        if (_delegate && [_delegate respondsToSelector:@selector(confirmSelectedChupanWithData:)]) {
            NSMutableArray *arrMemory = [NSMutableArray arrayWithArray:_arrData];
            NSMutableArray *arrSend = [NSMutableArray array];
            for (int i = 0 ;i<arrMemory.count; i++) {
                RLSBIfenSelectedSaishiModel *model = [arrMemory objectAtIndex:i];
                if (model.isSelected) {
                    [arrSend addObject:model];
                }
            }
            [_delegate confirmSelectedChupanWithData:arrSend];
        }
    }
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.headerReferenceSize = CGSizeMake(Width, 0);
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar + 44, Width,Height - APPDELEGATE.customTabbar.height_myNavigationBar - 44 - _allselectedV.height) collectionViewLayout:layout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.alwaysBounceVertical = YES;
        self.collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.collectionView];
        [self.view bringSubviewToFront:self.collectionView];
        [self.collectionView registerClass:[RLSSelectedCCell class] forCellWithReuseIdentifier:cellCollectioneSlectedChupan];
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerCollectioneSlectedChupan];
    }
    return _collectionView;
}
#pragma mark -- uicollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSLog(@"%ld",_arrSectionData.count);
    return _arrSectionData.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSMutableArray *arr = [_arrItemData objectAtIndex:section];
    return arr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RLSSelectedCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellCollectioneSlectedChupan forIndexPath:indexPath];
    if (!cell) {
        NSLog(@"无法创建cell");
    }
    else{
    }
    NSMutableArray *arr = [_arrItemData objectAtIndex:indexPath.section];
    RLSBIfenSelectedSaishiModel *model = [arr objectAtIndex:indexPath.row];
    cell.cellSize = CGSizeMake(cellCollectionWidth, cellCollectionHeight);
    cell.model = model;
    cell.selected = model.isSelected;
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerCollectioneSlectedChupan forIndexPath:indexPath];
    headerView.backgroundColor = colorTableViewBackgroundColor;
    return headerView;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    NSMutableArray *arr = [_arrItemData objectAtIndex:indexPath.section];
    RLSBIfenSelectedSaishiModel *model = [arr objectAtIndex:indexPath.row];
    model.isSelected = !model.isSelected;
    [_allselectedV changeBtnSelectedState:model.isSelected];
    [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil]];
}
#pragma mark --  UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(cellCollectionWidth,cellCollectionHeight);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 12, 12, 15);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 12;
}
@end
