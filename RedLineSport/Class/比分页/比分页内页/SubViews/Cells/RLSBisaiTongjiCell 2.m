
//
//  RLSBisaiTongjiCell.m
//  GQapp
//
//  Created by WQ on 2017/8/14.
//  Copyright © 2017年 GQXX. All rights reserved.
//

#import "RLSBisaiTongjiCell.h"
@interface RLSBisaiTongjiCell()
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, assign) BOOL isaddLayout;

//第一个cell和最后一个cell的内容
@property (nonatomic, strong) UIImageView *viewTopRound;
@property (nonatomic, strong) UIImageView *viewBootomRound;
@property (nonatomic, strong) UIImageView *imageTop;
@property (nonatomic, strong) UIImageView *imageBottom;
@property (nonatomic, strong) UIView *viewLineTimeTop;
@property (nonatomic, strong) UIView *viewLineTimeBottom;
@property (nonatomic, strong) UILabel *labTime;
@property (nonatomic, strong) UILabel *labhomeCenter;
@property (nonatomic, strong) UILabel *labhomeTop;
@property (nonatomic, strong) UILabel *labhomeBottom;
@property (nonatomic, strong) UILabel *labGuestCenter;
@property (nonatomic, strong) UILabel *labGuestTop;
@property (nonatomic, strong) UILabel *labGuestBottom;
@property (nonatomic, strong) UIImageView *imageHome;
@property (nonatomic, strong) UIImageView *imageGuest;

@end
@implementation RLSBisaiTongjiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)tongjimmodel:(RLSLiveEventMedel*)model{
    NSLog(@"tongjimmodemodel=%@",model);
//}
//- (void)setModel:(RLSLiveEventMedel *)model
//{
//    model = _model;
    [self.contentView addSubview:self.basicView];
    
    if (!_isaddLayout) {
        _isaddLayout = YES;
        [self addLayout];
    }
    
    
    _viewTopRound.image = [UIImage imageNamed:@"clear"];
    _imageTop.image =[UIImage imageNamed:@"clear"];
    _viewBootomRound.image = [UIImage imageNamed:@"clear"];
    _imageBottom.image = [UIImage imageNamed:@"clear"];
    
    _imageHome.image = [UIImage imageNamed:@"clear"];
    _imageGuest.image = [UIImage imageNamed:@"clear"];
    
    _viewLineTimeTop.backgroundColor = [UIColor clearColor];
    _viewLineTimeBottom.backgroundColor = [UIColor clearColor];
    _labTime.text = @"";
    
    _labhomeTop.text = @"";
    _labhomeCenter.text = @"";
    _labhomeBottom.text = @"";
    
    _labGuestTop.text = @"";
    _labGuestCenter.text = @"";
    _labGuestBottom.text = @"";
    
    if (model.ishome==99) {
//            第一个cell
        NSLog(@"model1=%@",model);
            _imageTop.image =[UIImage imageNamed:@"bisaiend"];
            _viewLineTimeTop.backgroundColor = [UIColor clearColor];
            }else if (model.ishome==100){
        //            最后一个cell
        NSLog(@"model2=%@",model);
            _imageBottom.image = [UIImage imageNamed:@"bisaistart"];
//            _viewLineTimeTop.backgroundColor = colorCC;
        _viewLineTimeBottom.backgroundColor = [UIColor clearColor];
        
    }else if(model.ishome==1){////主队
        NSLog(@"model3=%@",model);
        _labTime.text = [NSString stringWithFormat:@"%ld'",(long)model.time];
        switch (model.type) {
            case 1:
            {
                _imageHome.image = [UIImage imageNamed:@"bisaijinqiu"];
                _labhomeCenter.text = model.name;
            }break;
            case 2:
            {
                _imageHome.image = [UIImage imageNamed:@"bisairedCard"];
                _labhomeCenter.text = model.name;
                
            }break;
            case 3:
            {
                _imageHome.image = [UIImage imageNamed:@"bisaiyellowCard"];
                _labhomeCenter.text = model.name;
                
            }break;
            case 6:
            {
                _imageHome.image = [UIImage imageNamed:@""];
                _labhomeCenter.text = model.name;
                
            }break;
            case 7:
            {
                _imageHome.image = [UIImage imageNamed:@"bisaidianqiu"];
                _labhomeCenter.text = model.name;
                
            }break;
            case 8:
            {
                _imageHome.image = [UIImage imageNamed:@"bisaiwulongqiu"];
                _labhomeCenter.text = model.name;
                
            }break;
            case 9:
            {
                _imageHome.image = [UIImage imageNamed:@"bisaiyellowRedCard"];
                _labhomeCenter.text = model.name;
                
            }
                break;
            case 10:
            {
                NSArray *arr = [model.name componentsSeparatedByString:@","];
                _imageHome.image = [UIImage imageNamed:@"bisaiZhugong"];
                if (arr.count==2) {
                    _labhomeTop.text = [arr firstObject];
                    _labhomeBottom.text = [arr lastObject];
                }else if(arr.count==1){
                    _labhomeTop.text = [arr firstObject];
                }
                
                
            }
                break;
            case 11:
            {
                NSArray *arr = [model.name componentsSeparatedByString:@","];
                if (arr.count==2) {
                    _imageHome.image = [UIImage imageNamed:@"bisaichangePeople"];
                    if (arr.count==2) {
                        _labhomeTop.text = [arr objectAtIndex:1];
                        _labhomeBottom.text = [arr objectAtIndex:0];
                    }else if (arr.count==1){
                        _labhomeBottom.text = [arr objectAtIndex:0];
                    }

                }
                
            }
                break;
            case 20:
            {
                _imageHome.image = [UIImage imageNamed:@"bisaichangePeople"];
                _labhomeCenter.text = model.name;
                
            }
                
            default:
                break;
        }
        _viewLineTimeTop.backgroundColor = colorCC;
        _viewLineTimeBottom.backgroundColor = colorCC;

    }else if(model.ishome==0){////客队，显示在右侧
        _labTime.text = [NSString stringWithFormat:@"%ld'",(long)model.time];
        switch (model.type) {
            case 1:
            {
                _imageGuest.image = [UIImage imageNamed:@"bisaijinqiu"];
                _labGuestCenter.text = model.name;
            }break;
            case 2:
            {
                _imageGuest.image = [UIImage imageNamed:@"bisairedCard"];
                _labGuestCenter.text = model.name;
                
            }break;
            case 3:
            {
                _imageGuest.image = [UIImage imageNamed:@"bisaiyellowCard"];
                _labGuestCenter.text = model.name;
                
            }break;
            case 6:
            {
                _imageGuest.image = [UIImage imageNamed:@""];
                _labGuestCenter.text = model.name;
                
            }break;
            case 7:
            {
                _imageGuest.image = [UIImage imageNamed:@"bisaidianqiu"];
                _labGuestCenter.text = model.name;
                
            }break;
            case 8:
            {
                _imageGuest.image = [UIImage imageNamed:@"bisaiwulongqiu"];
                _labGuestCenter.text = model.name;
                
            }break;
            case 9:
            {
                _imageGuest.image = [UIImage imageNamed:@"bisaiyellowRedCard"];
                _labGuestCenter.text = model.name;
                
            }
                break;
            case 10:
            {
                NSArray *arr = [model.name componentsSeparatedByString:@","];
                _imageGuest.image = [UIImage imageNamed:@"bisaiZhugong"];
                if (arr.count==2) {
                    _labGuestTop.text = [arr firstObject];
                    _labGuestBottom.text = [arr lastObject];
                }else if(arr.count==1){
                    _labGuestTop.text = [arr firstObject];
                }
                
                
            }
                break;
            case 11:
            {
                NSArray *arr = [model.name componentsSeparatedByString:@","];
                if (arr.count==2) {
                    _imageGuest.image = [UIImage imageNamed:@"bisaichangePeople"];
                    if (arr.count==2) {
                        _labGuestTop.text = [arr objectAtIndex:1];
                        _labGuestBottom.text = [arr objectAtIndex:0];
                        
                    }else if (arr.count==1){
                        _labGuestBottom.text = [arr objectAtIndex:0];
                    }
 
                }
        }
                break;
            case 20:
            {
                _imageGuest.image = [UIImage imageNamed:@"bisaichangePeople"];
                _labGuestCenter.text = model.name;
                
            }
                
            default:
                break;
        }
        _viewLineTimeTop.backgroundColor = colorCC;
        _viewLineTimeBottom.backgroundColor = colorCC;

    }else{
    
        //            中间的cell
        _labTime.text = [NSString stringWithFormat:@"%ld'",(long)model.time];
        _viewLineTimeTop.backgroundColor = colorCC;
        _viewLineTimeBottom.backgroundColor = colorCC;
       /* //主队
        type==2   红牌
        type==3   黄牌
        type==7   点球
        type==8   乌龙球
        type==9   红黄牌
        type==10  助攻
        type==11  换人
        type==1   进球
        if (_model.ishome== 1) {
            
            switch (model.type) {
                case 1:
                {
                    _imageHome.image = [UIImage imageNamed:@"bisaijinqiu"];
                    _labhomeCenter.text = _model.name;
                }break;
                case 2:
                {
                    _imageHome.image = [UIImage imageNamed:@"bisairedCard"];
                    _labhomeCenter.text = _model.name;
                    
                }break;
                case 3:
                {
                    _imageHome.image = [UIImage imageNamed:@"bisaiyellowCard"];
                    _labhomeCenter.text = _model.name;
                    
                }break;
                case 6:
                {
                    _imageHome.image = [UIImage imageNamed:@""];
                    _labhomeCenter.text = _model.name;
                    
                }break;
                case 7:
                {
                    _imageHome.image = [UIImage imageNamed:@"bisaidianqiu"];
                    _labhomeCenter.text = _model.name;
                    
                }break;
                case 8:
                {
                    _imageHome.image = [UIImage imageNamed:@"bisaiwulongqiu"];
                    _labhomeCenter.text = _model.name;
                    
                }break;
                case 9:
                {
                    _imageHome.image = [UIImage imageNamed:@"bisaiyellowRedCard"];
                    _labhomeCenter.text = _model.name;
                    
                }
                    break;
                case 10:
                {
                    NSArray *arr = [_model.name componentsSeparatedByString:@","];
                    _imageHome.image = [UIImage imageNamed:@"bisaiZhugong"];
                    _labhomeTop.text = [arr firstObject];
                    _labhomeBottom.text = [arr lastObject];
                    
                }
                    break;
                case 11:
                {
                    NSArray *arr = [_model.name componentsSeparatedByString:@","];
                    _imageHome.image = [UIImage imageNamed:@"bisaichangePeople"];
                    _labhomeTop.text = [arr objectAtIndex:1];
                    _labhomeBottom.text = [arr objectAtIndex:0];
                }
                    break;
                case 20:
                {
                    _imageHome.image = [UIImage imageNamed:@"bisaichangePeople"];
                    _labhomeCenter.text = _model.name;
                    
                }
                    
                default:
                    break;
            }
            
            
        }else{
            
            switch (model.type) {
                case 1:
                {
                    _imageGuest.image = [UIImage imageNamed:@"bisaijinqiu"];
                    _labGuestCenter.text = _model.name;
                }break;
                case 2:
                {
                    _imageGuest.image = [UIImage imageNamed:@"bisairedCard"];
                    _labGuestCenter.text = _model.name;
                    
                }break;
                case 3:
                {
                    _imageGuest.image = [UIImage imageNamed:@"bisaiyellowCard"];
                    _labGuestCenter.text = _model.name;
                    
                }break;
                case 6:
                {
                    _imageGuest.image = [UIImage imageNamed:@""];
                    _labGuestCenter.text = _model.name;
                    
                }break;
                case 7:
                {
                    _imageGuest.image = [UIImage imageNamed:@"bisaidianqiu"];
                    _labGuestCenter.text = _model.name;
                    
                }break;
                case 8:
                {
                    _imageGuest.image = [UIImage imageNamed:@"bisaiwulongqiu"];
                    _labGuestCenter.text = _model.name;
                    
                }break;
                case 9:
                {
                    _imageGuest.image = [UIImage imageNamed:@"bisaiyellowRedCard"];
                    _labGuestCenter.text = _model.name;
                    
                }
                    break;
                case 10:
                {
                    NSArray *arr = [_model.name componentsSeparatedByString:@","];
                    _imageGuest.image = [UIImage imageNamed:@"bisaiZhugong"];
                    _labGuestTop.text = [arr firstObject];
                    _labGuestBottom.text = [arr lastObject];
                    
                }
                    break;
                case 11:
                {
                    NSArray *arr = [_model.name componentsSeparatedByString:@","];
                    _imageGuest.image = [UIImage imageNamed:@"bisaichangePeople"];
                    _labGuestTop.text = [arr objectAtIndex:1];
                    _labGuestBottom.text = [arr objectAtIndex:0];
                }
                    break;
                case 20:
                {
                    _imageGuest.image = [UIImage imageNamed:@"bisaichangePeople"];
                    _labGuestCenter.text = _model.name;
                    
                }
                    
                default:
                    break;
            }
            
            
        }
//        _viewLineTimeTop.backgroundColor = colorCC;
//        _viewLineTimeBottom.backgroundColor = colorCC;*/
        
        }
    
    
    
}


- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] init];
        [_basicView addSubview:self.viewTopRound];
        [_basicView addSubview:self.viewBootomRound];
        [_basicView addSubview:self.imageTop];
        [_basicView addSubview:self.imageBottom];
        [_basicView addSubview:self.viewLineTimeTop];
        [_basicView addSubview:self.viewLineTimeBottom];
        [_basicView addSubview:self.labTime];
        [_basicView addSubview:self.labhomeCenter];
        [_basicView addSubview:self.labhomeTop];
        [_basicView addSubview:self.labhomeBottom];
        [_basicView addSubview:self.labGuestCenter];
        [_basicView addSubview:self.labGuestTop];
        [_basicView addSubview:self.labGuestBottom];
        [_basicView addSubview:self.imageHome];
        [_basicView addSubview:self.imageGuest];

        
    }
    return _basicView;
}


- (UIImageView *)viewTopRound
{
    if (!_viewTopRound) {
        _viewTopRound = [[UIImageView alloc] init];
    }
    return _viewTopRound;
}
- (UIView *)viewBootomRound
{
    if (!_viewBootomRound) {
        _viewBootomRound = [[UIImageView alloc] init];
    }
    return _viewBootomRound;
}
- (UIView *)viewLineTimeTop
{
    if (!_viewLineTimeTop) {
        _viewLineTimeTop = [[UIView alloc] init];
    }
    return _viewLineTimeTop;
}
- (UIView *)viewLineTimeBottom
{
    if (!_viewLineTimeBottom) {
        _viewLineTimeBottom = [[UIView alloc] init];
    }
    return _viewLineTimeBottom;
}

- (UIImageView *)imageTop
{
    if (!_imageTop) {
        _imageTop = [[UIImageView alloc] init];
    }
    return _imageTop;
}
- (UIImageView *)imageBottom
{
    if (!_imageBottom) {
        _imageBottom = [[UIImageView alloc] init];
    }
    return _imageBottom;
}
- (UIImageView *)imageHome
{
    if (!_imageHome) {
        _imageHome = [[UIImageView alloc] init];
    }
    return _imageHome;
}
- (UIImageView *)imageGuest
{
    if (!_imageGuest) {
        _imageGuest = [[UIImageView alloc] init];
    }
    return _imageGuest;
}


- (UILabel *)labTime
{
    if (!_labTime) {
        _labTime = [[UILabel alloc] init];
        _labTime.font = font11;
        _labTime.textColor = color33;
    }
    return _labTime;
}

- (UILabel *)labhomeCenter
{
    if (!_labhomeCenter) {
        _labhomeCenter = [[UILabel alloc] init];
        _labhomeCenter.font = font13;
        _labhomeCenter.textColor = color33;
    }
    return _labhomeCenter;
}
- (UILabel *)labhomeTop
{
    if (!_labhomeTop) {
        _labhomeTop = [[UILabel alloc] init];
        _labhomeTop.font = font13;
        _labhomeTop.textColor = color33;
    }
    return _labhomeTop;
}
- (UILabel *)labhomeBottom
{
    if (!_labhomeBottom) {
        _labhomeBottom = [[UILabel alloc] init];
        _labhomeBottom.font = font13;
        _labhomeBottom.textColor = color99;
    }
    return _labhomeBottom;
}
- (UILabel *)labGuestCenter
{
    if (!_labGuestCenter) {
        _labGuestCenter = [[UILabel alloc] init];
        _labGuestCenter.font = font13;
        _labGuestCenter.textColor = color33;
    }
    return _labGuestCenter;
}
- (UILabel *)labGuestTop
{
    if (!_labGuestTop) {
        _labGuestTop = [[UILabel alloc] init];
        _labGuestTop.font = font13;
        _labGuestTop.textColor = color33;
    }
    return _labGuestTop;
}
- (UILabel *)labGuestBottom
{
    if (!_labGuestBottom) {
        _labGuestBottom = [[UILabel alloc] init];
        _labGuestBottom.font = font13;
        _labGuestBottom.textColor = color99;
    }
    return _labGuestBottom;
}


- (void)addLayout
{
    [self.basicView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
    }];
    
    [self.imageTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.basicView.mas_centerX);
       // make.centerY.equalTo(self.basicView.mas_centerY);
        make.top.mas_equalTo(self.basicView).offset(10);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    [self.viewTopRound mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.basicView.mas_bottom);
        make.centerX.equalTo(self.basicView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(5, 5));
    }];
    
    [self.imageBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.basicView.mas_centerX);
        make.centerY.equalTo(self.basicView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    [self.viewBootomRound mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.basicView.mas_top);
        make.centerX.equalTo(self.basicView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(5, 5));
    }];

    [self.viewLineTimeTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.basicView.mas_top);
        make.centerX.equalTo(self.basicView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(0.5, 20));
    }];
    
    [self.viewLineTimeBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.basicView.mas_bottom);
        make.centerX.equalTo(self.basicView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(0.5, 20));

    }];
    
    [self.labTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.basicView.mas_centerX);
        make.centerY.equalTo(self.basicView.mas_centerY);
        make.height.mas_equalTo(20);
    }];
    
    
    [self.imageHome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.viewLineTimeTop.mas_left).offset(-24);
        make.centerY.equalTo(self.basicView.mas_centerY);
//        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    [self.labhomeCenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imageHome.mas_left).offset(-10);
        make.centerY.equalTo(self.basicView.mas_centerY);
    }];
    
    [self.labhomeTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imageHome.mas_left).offset(-10);
        make.bottom.equalTo(self.imageHome.mas_centerY).offset(-6);
    }];
    
    [self.labhomeBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imageHome.mas_left).offset(-10);
        make.top.equalTo(self.imageHome.mas_centerY).offset(6);
    }];

    [self.imageGuest mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewLineTimeTop.mas_right).offset(24);
        make.centerY.equalTo(self.basicView.mas_centerY);
//        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    [self.labGuestCenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageGuest.mas_right).offset(10);
        make.centerY.equalTo(self.basicView.mas_centerY);
    }];
    
    [self.labGuestTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageGuest.mas_right).offset(10);
        make.bottom.equalTo(self.imageGuest.mas_centerY).offset(-6);
    }];
    
    [self.labGuestBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageGuest.mas_right).offset(10);
        make.top.equalTo(self.imageGuest.mas_centerY).offset(6);
    }];

    
    
}












@end
