#define cellTuijianSelectedSaishi @"cellTuijianSelectedSaishi"
#define cellTuijianSelectedItem @"cellTuijianSelectedItem"
#define headerTuijianSelectedSaishi @"headerTuijianSelectedSaishi"
#import "RLSTuijianSelectedItemTitleView.h"
#import "RLSTuijianSelectedItemView.h"
@interface RLSTuijianSelectedItemView()<UIGestureRecognizerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,TuijianSelectedItemTitleViewDelegate>
@property (nonatomic, strong) UIView *basiView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) RLSTuijianSelectedItemTitleView *titleView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *arrPlay;
@property (nonatomic, strong) NSArray *arrState;
@property (nonatomic, strong) NSArray *arrList;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, assign) NSInteger list;
@end
@implementation RLSTuijianSelectedItemView
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (touch.view!= self.collectionView) {
        return NO;
    }
    return YES;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _play = 0;
        _state = 0;
        _list = 0;
        _currentIndex = 0;
        _arrPlay = @[@"全部玩法",@"胜平负",@"让球",@"进球数"];
        _arrState = @[@"全部状态",@"未开赛",@"已完场", @"比赛中",];
        _arrList = @[@"最近发布",@"按查看数",@"最近开赛"];
        [self addSubview:self.basiView];
    }
    return self;
}
- (void)setArrSaishi:(NSArray *)arrSaishi
{
    _arrSaishi = arrSaishi;
    [self.collectionView reloadData];
}
- (void)updateWithIndex:(NSInteger)index
{
    _currentIndex  =index;
    switch (_currentIndex) {
        case 0:
        {
            [_titleView updateSelectedIndexWithindex:_currentIndex WithTitle:[_arrPlay objectAtIndex:_play]];
        }
            break;
        case 1:
        {
            [_titleView updateSelectedIndexWithindex:_currentIndex WithTitle:[_arrState objectAtIndex:_state]];
        }
            break;
        case 2:
        {
            [_titleView updateSelectedIndexWithindex:_currentIndex WithTitle:[_arrList objectAtIndex:_list]];
        }
            break;
        case 3:
        {
        }
            break;
        default:
            break;
    }
    [self.collectionView reloadData];
}
- (void)updateWithIndexAttentioned:(BOOL)selected
{
    [_titleView attentionBtnSelected:selected];
}
- (UIView *)basiView
{
    if (!_basiView) {
        _basiView = [[UIView alloc] initWithFrame:self.bounds];
        _bgView = [[UIView alloc] initWithFrame:self.basiView.bounds];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0.5;
        [_basiView addSubview:_bgView];
        _titleView = [[RLSTuijianSelectedItemTitleView alloc] initWithFrame:CGRectMake(0, 0, Width, 44)];
        _titleView.backgroundColor = [UIColor whiteColor];
        _titleView.delegate = self;
        [_basiView addSubview:_titleView];
        UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, Width, 0.5)];
        viewLine.backgroundColor = colorCellLine;
        [_basiView addSubview:viewLine];
        [_basiView addSubview:self.collectionView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewBG)];
        tap.delegate = self;
        [_basiView addGestureRecognizer:tap];
    }
    return _basiView;
}
- (void)tapTuijianSelectedItemTitleViewAtindex:(NSInteger)index
{
    if (index == 3) {
        if (![RLSMethods login]) {
            [RLSMethods toLogin];
            return;
        }
        _currentIndex = index;
        [_delegate touchWithItem:_currentIndex WithIndex:0 WithTitle:@"我的关注"];
    }else{
        if (_currentIndex == index) {
            if (_delegate && [_delegate respondsToSelector:@selector(touchWithItem:WithIndex:WithTitle:)]) {
                switch (_currentIndex) {
                    case 0:
                    {
                        [_delegate touchWithItem:_currentIndex WithIndex:_play WithTitle:[_arrPlay objectAtIndex:_play]];
                    }
                        break;
                    case 1:
                    {
                        [_delegate touchWithItem:_currentIndex WithIndex:_state WithTitle:[_arrState objectAtIndex:_state]];
                    }
                        break;
                    case 2:
                    {
                        [_delegate touchWithItem:_currentIndex WithIndex:_list WithTitle:[_arrList objectAtIndex:_list]];
                    }
                        break;
                    case 3:
                    {
                    }
                        break;
                    default:
                        break;
                }
            }
        }else{
            _currentIndex = index;
            [self.collectionView reloadData];
        }
    }
}
- (void)tapViewBG
{
    if (_delegate && [_delegate respondsToSelector:@selector(touchWithItem:WithIndex:WithTitle:)]) {
        switch (_currentIndex) {
            case 0:
            {
                [_delegate touchWithItem:_currentIndex WithIndex:_play WithTitle:[_arrPlay objectAtIndex:_play]];
            }
                break;
            case 1:
            {
                [_delegate touchWithItem:_currentIndex WithIndex:_state WithTitle:[_arrState objectAtIndex:_state]];
            }
                break;
            case 2:
            {
                [_delegate touchWithItem:_currentIndex WithIndex:_list WithTitle:[_arrList objectAtIndex:_list]];
            }
                break;
            case 3:
            {
                [_delegate touchWithItem:_currentIndex WithIndex:0 WithTitle:@"我的关注"];
            }
                break;
            default:
                break;
        }
    }
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 44, Width,_basiView.height - 44 ) collectionViewLayout:layout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.alwaysBounceVertical = YES;
        self.collectionView.showsVerticalScrollIndicator = NO;
        self.collectionView.backgroundColor = [UIColor clearColor];
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellTuijianSelectedSaishi];
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellTuijianSelectedItem];
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerTuijianSelectedSaishi];
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerTuijianSelectedSaishi];
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:headerTuijianSelectedSaishi];
    }
    return _collectionView;
}
#pragma mark -- uicollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    switch (_currentIndex) {
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
            return 1;
        }
            break;
        case 3:
        {
            return 1;
        }
            break;
        default:
            break;
    }
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    switch (_currentIndex) {
        case 0:
        {
            return _arrPlay.count;
        }
            break;
        case 1:
        {
            return _arrState.count;
        }
            break;
        case 2:
        {
            return _arrList.count;
        }
            break;
        case 3:
        {
            return _arrSaishi.count;
        }
            break;
        default:
            break;
    }
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellTuijianSelectedItem forIndexPath:indexPath];
    if (!cell) {
        NSLog(@"无法创建cell");
    }
    else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    if (_currentIndex == 3) {
    }else{
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 45)];
        contentView.backgroundColor = [UIColor whiteColor];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, Width - 15, 45)];
        lab.textColor = color33;
        lab.font = font12;
        [contentView addSubview:lab];
        UIView *lineV = [[UIView alloc] initWithFrame:CGRectMake(0, 44.5, Width, 0.5)];
        lineV.backgroundColor = colorCellLine;
        [contentView addSubview:lineV];
        cell.backgroundView = contentView;
        UIView *contentViewSelected = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 45)];
        contentViewSelected.backgroundColor = colorCellLine;
        UILabel *labSelected = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, Width - 15, 45)];
        labSelected.textColor = redcolor;
        labSelected.font = font12;
        [contentViewSelected addSubview:labSelected];
        cell.selectedBackgroundView = contentViewSelected;
        switch (_currentIndex) {
            case 0:
            {
                lab.text = [_arrPlay objectAtIndex:indexPath.item];
                labSelected.text = [_arrPlay objectAtIndex:indexPath.item];
                if (indexPath.item == _play) {
                    cell.selected = YES;
                }else{
                    cell.selected = NO;
                }
            }
                break;
            case 1:
            {
                lab.text = [_arrState objectAtIndex:indexPath.item];
                labSelected.text = [_arrState objectAtIndex:indexPath.item];
                if (indexPath.item == _state) {
                    cell.selected = YES;
                }else{
                    cell.selected = NO;
                }
            }
                break;
            case 2:
            {
                lab.text = [_arrList objectAtIndex:indexPath.item];
                labSelected.text = [_arrList objectAtIndex:indexPath.item];
                if (indexPath.item == _list) {
                    cell.selected = YES;
                }else{
                    cell.selected = NO;
                }
            }
                break;
            default:
                break;
        }
    }
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerTuijianSelectedSaishi forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return headerView;
}
- (void)btncancelClick
{
    if (_delegate && [_delegate respondsToSelector:@selector(touchWithItem:WithIndex:WithTitle:)]) {
        switch (_currentIndex) {
            case 0:
            {
                [_delegate touchWithItem:_currentIndex WithIndex:_play WithTitle:[_arrPlay objectAtIndex:_play]];
            }
                break;
            case 1:
            {
                [_delegate touchWithItem:_currentIndex WithIndex:_state WithTitle:[_arrState objectAtIndex:_state]];
            }
                break;
            case 2:
            {
                [_delegate touchWithItem:_currentIndex WithIndex:_list WithTitle:[_arrList objectAtIndex:_list]];
            }
                break;
            case 3:
            {
                [_delegate touchWithItem:_currentIndex WithIndex:0 WithTitle:@"我的关注"];
            }
                break;
            default:
                break;
        }
    }
}
- (void)btnconfireClick
{
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    switch (_currentIndex) {
        case 0:
        {
            _play = indexPath.item;
            [_titleView updateSelectedIndexWithindex:0 WithTitle:[_arrPlay objectAtIndex:indexPath.item]];
            if (_delegate && [_delegate respondsToSelector:@selector(selectedWithItem:WithIndex:WithTitle:)]) {
                [_delegate selectedWithItem:_currentIndex WithIndex:indexPath.item WithTitle:[_arrPlay objectAtIndex:indexPath.item]] ;
            }
        }
            break;
        case 1:
        {
            _state = indexPath.item;
            [_titleView updateSelectedIndexWithindex:1 WithTitle:[_arrState objectAtIndex:indexPath.item]];
            if (_delegate && [_delegate respondsToSelector:@selector(selectedWithItem:WithIndex:WithTitle:)]) {
                [_delegate selectedWithItem:_currentIndex WithIndex:indexPath.item WithTitle:[_arrState objectAtIndex:indexPath.item]];
            }
        }
            break;
        case 2:
        {
            _list = indexPath.item;
            [_titleView updateSelectedIndexWithindex:2 WithTitle:[_arrList objectAtIndex:indexPath.item]];
            if (_delegate && [_delegate respondsToSelector:@selector(selectedWithItem:WithIndex:WithTitle:)]) {
                [_delegate selectedWithItem:_currentIndex WithIndex:indexPath.item WithTitle:[_arrList objectAtIndex:indexPath.item]];
            }
        }
        case 3:
        {
        }
            break;
            break;
        default:
            break;
    }
    [self.collectionView reloadData];
}
#pragma mark --  UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_currentIndex == 3) {
        return CGSizeMake(0, 45);
    }else{
        return CGSizeMake(Width, 45);
    }
    return CGSizeMake(0,0);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeZero;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y<0) {
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
    }
}
@end
