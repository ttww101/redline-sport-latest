//
//  HeaderView.m
//  GQZhiBo
//
//  Created by genglei on 2018/11/21.
//  Copyright © 2018年 GQXX. All rights reserved.
//

#import "HeaderView.h"
#import "ItemCell.h"
#import "ForumTypeViewController.h"
#import "RLSToolWebViewController.h"
#import "RLSTuijianDetailVC.h"
#import "RLSUserViewController.h"

@interface HeaderView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *championView;
@property (nonatomic, strong) BaseImageView *championIV;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *verticalView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, assign) BOOL isToFenxi;
@property (nonatomic, strong) UIControl *actionControl;



@end

NSString *const idenfitier = @"cellID";

@implementation HeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
        self.userInteractionEnabled = true;
    }
    return self;
}

#pragma mark - Setter

- (void)setModules:(NSArray<ModulesInfo *> *)modules {
    _modules = modules;
    [self.collectionView reloadData];
}

- (void)setChampions:(NSArray<ChampionModel *> *)champions {
    _champions = champions;
    if (_champions.count > 0) {
         [_championIV setImageWithUrl:[NSURL URLWithString:PARAM_IS_NIL_ERROR([_champions firstObject].pic)] placeholder:[UIImage imageNamed:@"placeHolder"]];
    }
}

#pragma mark - Config UI

- (void)configUI {
    self.backgroundColor = UIColorHex(#EBEBEB);
    [self addSubview:self.collectionView];
    [self addSubview:self.championView];
    self.championView.top = self.collectionView.bottom + 10;
    [self.championView addSubview:self.championIV];
    [self.championView addSubview:self.actionControl];
    [self addSubview:self.bottomView];
    self.bottomView.top = self.championView.bottom + 10;
    [self.bottomView addSubview:self.lineView];
    [self.bottomView addSubview:self.verticalView];
    [self.bottomView addSubview:self.nameLabel];
    [self.collectionView registerClass:NSClassFromString(@"ItemCell") forCellWithReuseIdentifier:idenfitier];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modules.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:idenfitier forIndexPath:indexPath];
    cell.model = self.modules[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ForumTypeViewController *control = [[ForumTypeViewController alloc]init];
    control.moduleId = self.modules[indexPath.row].moduleId;
    [[RLSMethods help_getCurrentVC].navigationController pushViewController:control animated:true];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.width / 4, collectionView.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - Events

- (void)championAction {
    if (_champions.count > 0) {
        UIViewController *currentControl = [RLSMethods help_getCurrentVC];
        ChampionModel *model = [_champions firstObject];
        switch (model.linkType) {
            case 0: {
                
            }
                break;
                
            case 1: {
                RLSWebModel *webModel = [[RLSWebModel alloc]init];
                webModel.title = model.title;
                webModel.webUrl = model.url2;
                RLSToolWebViewController *control = [[RLSToolWebViewController alloc]init];
                control.model = webModel;
                [currentControl.navigationController pushViewController:control animated:YES];
            }
                break;
            case 2: {
                [self toFenxiWithMatchId:model.url2 toPageindex:model.tabType toItemIndex:0];
            }
                break;
                
            case 3: {
                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.url]];
            }
                break;
            case 4: {
                RLSTuijianDetailVC *tuijianDT = [[RLSTuijianDetailVC alloc] init];
                tuijianDT.modelId = [model.url2 integerValue];
                tuijianDT.typeTuijianDetailHeader = typeTuijianDetailHeaderCellDanchang;
                [APPDELEGATE.customTabbar pushToViewController:tuijianDT animated:YES];
            }
                break;
                
            case 5: {
                RLSUserViewController *userVC = [[RLSUserViewController alloc] init];
                userVC.userId =  [model.url2 integerValue];
                userVC.hidesBottomBarWhenPushed = YES;
                userVC.Number=1;
                [APPDELEGATE.customTabbar pushToViewController:userVC animated:YES];
            }
                break;
            case 6: {
                RLSWebModel *webModel = [[RLSWebModel alloc]init];
                webModel.title = model.title;
                webModel.webUrl = model.url2;
                RLSToolWebViewController *control = [[RLSToolWebViewController alloc]init];
                control.model = webModel;
                [currentControl.navigationController pushViewController:control animated:YES];
            }
                break;
                
            case 7: {
                RLSWebModel *webModel = [[RLSWebModel alloc]init];
                webModel.title = @"进球数";
                webModel.webUrl = [NSString stringWithFormat:@"%@/%@/dxmode.html", APPDELEGATE.url_ip,H5_Host];
                webModel.showBuyBtn = YES;
                RLSToolWebViewController *control = [[RLSToolWebViewController alloc]init];
                control.model = webModel;
                [currentControl.navigationController pushViewController:control animated:YES];
            }
                break;
            case 8: {
                RLSWebModel *webModel = [[RLSWebModel alloc]init];
                webModel.title = @"临场胜平负";
                webModel.webUrl =  [NSString stringWithFormat:@"%@/%@/spfmode.html", APPDELEGATE.url_ip,H5_Host];
                webModel.showBuyBtn = YES;
                RLSToolWebViewController *control = [[RLSToolWebViewController alloc]init];
                control.model = webModel;
                [currentControl.navigationController pushViewController:control animated:YES];
            }
                break;
                
            case 9: {
                RLSWebModel *webModel = [[RLSWebModel alloc]init];
                webModel.title = @"临场亚指";
                webModel.webUrl =  [NSString stringWithFormat:@"%@/%@/yamode.html", APPDELEGATE.url_ip,H5_Host];
                webModel.showBuyBtn = YES;
                RLSToolWebViewController *control = [[RLSToolWebViewController alloc]init];
                control.model = webModel;
                [currentControl.navigationController pushViewController:control animated:YES];
            }
                break;
            case 10: {
                
            }
                break;
                
            case 11: {
                
            }
                break;
            case 12: {
                RLSWebModel *webModel = [[RLSWebModel alloc]init];
                webModel.title = @"初指胜平负";
                webModel.webUrl =  [NSString stringWithFormat:@"%@/%@/cpspfmode.html", APPDELEGATE.url_ip,H5_Host];
                webModel.showBuyBtn = YES;
                RLSToolWebViewController *control = [[RLSToolWebViewController alloc]init];
                control.model = webModel;
                [currentControl.navigationController pushViewController:control animated:YES];
            }
                break;
                
            case 13: {
                RLSWebModel *webModel = [[RLSWebModel alloc]init];
                webModel.title = @"初指亚指";
                webModel.webUrl =  [NSString stringWithFormat:@"%@/%@/cpyamode.html", APPDELEGATE.url_ip,H5_Host];
                webModel.showBuyBtn = YES;
                RLSToolWebViewController *control = [[RLSToolWebViewController alloc]init];
                control.model = webModel;
                [currentControl.navigationController pushViewController:control animated:YES];
            }
                break;
            case 14: {
                
            }
                break;
                
            case 15: {
                
            }
                break;
            case 16: {
                RLSWebModel *webModel = [[RLSWebModel alloc]init];
                webModel.title = @"爆冷模型";
                webModel.webUrl =  [NSString stringWithFormat:@"%@/%@/blmode.html", APPDELEGATE.url_ip,H5_Host];
                webModel.showBuyBtn = YES;
                RLSToolWebViewController *control = [[RLSToolWebViewController alloc]init];
                control.model = webModel;
                [currentControl.navigationController pushViewController:control animated:YES];
            }
                break;
                
            case 17: {
               
            }
                break;
            case 18: {
                RLSWebModel *webModel = [[RLSWebModel alloc]init];
                webModel.title = @"滚球独家";
                webModel.webUrl =  [NSString stringWithFormat:@"%@/%@/fastnews-show.html?id=%@", APPDELEGATE.url_ip,H5_Host,model.url2];
                webModel.showBuyBtn = YES;
                RLSToolWebViewController *control = [[RLSToolWebViewController alloc]init];
                control.model = webModel;
                [currentControl.navigationController pushViewController:control animated:YES];
            }
                break;
                
            case 23: {
                RLSWebModel *webModel = [[RLSWebModel alloc]init];
                webModel.title = @"主题贴";
                webModel.webUrl =  [NSString stringWithFormat:@"%@/%@/board-show.html?id=%@", APPDELEGATE.url_ip,H5_Host,model.url2];
                webModel.showBuyBtn = YES;
                RLSToolWebViewController *control = [[RLSToolWebViewController alloc]init];
                control.model = webModel;
                [currentControl.navigationController pushViewController:control animated:YES];
            }
                break;
                
            default:
                break;
        }
    }
}

- (void)toFenxiWithMatchId:(NSString *)idID toPageindex:(NSInteger)pageIndex toItemIndex:(NSInteger)itemIndex;
{
    if (!(_isToFenxi == YES)) {
        _isToFenxi = YES;
        NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
        if (idID== nil) {
            idID = @"";
        }
        [parameter setObject:@"3" forKey:@"flag"];
        [parameter setObject:idID forKey:@"sid"];
        [[RLSDCHttpRequest shareInstance] sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_liveScores] Start:^(id requestOrignal) {
        } End:^(id responseOrignal) {
        } Success:^(id responseResult, id responseOrignal) {
            if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
                RLSLiveScoreModel *model = [RLSLiveScoreModel entityFromDictionary:[responseOrignal objectForKey:@"data"]];
                model.neutrality = NO;
                RLSFenxiPageVC *fenxiVC = [[RLSFenxiPageVC alloc] init];
                fenxiVC.model = model;
                fenxiVC.segIndex = itemIndex;
                fenxiVC.currentIndex = pageIndex;
                UIViewController *currentControl = [RLSMethods help_getCurrentVC];
                [currentControl.navigationController pushViewController:fenxiVC animated:YES];
            }
            _isToFenxi = NO;
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
            _isToFenxi = NO;
        }];
    }else{
    }
}
#pragma mark - Lazy Load

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.width, 96) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = false;
        _collectionView.pagingEnabled = true;
    }
    return _collectionView;
}

- (UIView *)championView {
    if (_championView == nil) {
        _championView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 85)];
        _championView.backgroundColor = [UIColor whiteColor];
        _championView.userInteractionEnabled = true;
    }
    return _championView;
}

- (BaseImageView *)championIV {
    if (_championIV == nil) {
        _championIV = [[BaseImageView alloc]initWithFrame:CGRectMake(15, 5, self.width - 30, self.championView.height - 10)];
        _championIV.layer.cornerRadius = 5;
        _championIV.layer.masksToBounds = true;
        _championIV.contentMode = UIViewContentModeScaleAspectFill;
        [_championIV setUserInteractionEnabled:YES];
    }
    return _championIV;
}

- (UIControl *)actionControl {
    if (_actionControl == nil) {
        _actionControl = [[UIControl alloc]initWithFrame:self.championIV.frame];
        [_actionControl addTarget:self action:@selector(championAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionControl;
}

- (UIView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 44)];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}

- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bottomView.height - ONE_PX_LINE, self.width, ONE_PX_LINE)];
        _lineView.backgroundColor = UIColorHex(#eeeeee);
    }
    return _lineView;
}

- (UIView *)verticalView {
    if (_verticalView == nil) {
        _verticalView = [[UIView alloc]initWithFrame:CGRectMake(15, (self.bottomView.height - 15) / 2, 3, 15)];
        _verticalView.backgroundColor = UIColorHex(#EF4131);
    }
    return _verticalView;
}

- (UILabel *)nameLabel {
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.verticalView.right + 5, 12, 100, 20)];
        _nameLabel.font = [UIFont systemFontOfSize:14.f];;
        _nameLabel.textColor = UIColorFromRGBWithOX(0x333333);
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.text = @"精彩推荐";
    }
    return _nameLabel;
}

@end
