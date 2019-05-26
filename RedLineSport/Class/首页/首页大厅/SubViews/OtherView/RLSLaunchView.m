#import "RLSLaunchView.h"
#import "RLSToolWebViewController.h"
#import "RLSWebModel.h"
@interface RLSLaunchView()
@property (nonatomic, strong) UIImageView *imageB;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UIImageView *bottomImage;
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, strong) UIButton *skipBtn;
@end
@implementation RLSLaunchView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.imageB];
        [self addSubview:self.imageV];
        [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.right.equalTo(self.mas_right);
            make.left.equalTo(self.mas_left);
            make.bottom.equalTo(self.mas_bottom).offset(-135);
        }];
        [self addSubview:self.bottomImage];
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic {
    _dataDic = dataDic;
    if ([_dataDic isKindOfClass:[NSDictionary class]]) {
        [_imageV sd_setImageWithURL:[NSURL URLWithString:PARAM_IS_NIL_ERROR(_dataDic[@"pic"])] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (!error) {
                [self addSubview:self.bottomImage];
                [self addSubview:self.skipBtn];
                [self scheduledGCDTimerWithSeconds:[_dataDic[@"watingtime"] integerValue]];
            }else{
                [self dismiss];
            }
        }];
    }
}

- (void)scheduledGCDTimerWithSeconds:(NSInteger)seconds
{
    [self cancleGCDTimer];
    __block NSInteger timeLeave = seconds; 
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); 
    __typeof (self) __weak weakSelf = self;
    dispatch_source_set_event_handler(_timer, ^{
        if(timeLeave <= 0){ 
            dispatch_source_cancel(weakSelf.timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dismiss];
            });
        }else{
            NSInteger curTimeLeave = timeLeave;
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *timeLeaveStr = [NSString stringWithFormat:@"%ld秒 点击跳过",(long)curTimeLeave];
                [self.skipBtn setTitle:timeLeaveStr forState:UIControlStateNormal];
            });
            --timeLeave;
        }
    });
    dispatch_resume(_timer);
}
- (void)cancleGCDTimer
{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}
#pragma mark -Private Method
- (void)dismiss {
    [self cancleGCDTimer];
    [UIView animateWithDuration:1.f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark - Events
- (void)skipAction {
    [self dismiss];
}
- (void)advAction {
    NSInteger type = [self.dataDic[@"linkType"] integerValue];
    if (type == 0) {
    } else if (type == 1) {
        [self dismiss];
        RLSWebModel *model = [[RLSWebModel alloc]init];
        model.title = PARAM_IS_NIL_ERROR(self.dataDic[@"title"]);
        model.webUrl = PARAM_IS_NIL_ERROR(self.dataDic[@"url"]);
        model.hideNavigationBar = false;
        RLSToolWebViewController *webDetailVC = [[RLSToolWebViewController alloc] init];
        webDetailVC.model = model;
        [APPDELEGATE.customTabbar pushToViewController:webDetailVC animated:YES];
    }
}
#pragma mark - Lazy Load
- (UIImageView *)imageB
{
    if (!_imageB) {
        _imageB = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageB.image = [self launchImage];
    }
    return _imageB;
}
- (UIImageView *)imageV
{
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
        _imageV.contentMode = UIViewContentModeScaleAspectFill;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(advAction)];
        [_imageV addGestureRecognizer:tap];
        _imageV.userInteractionEnabled = YES;
    }
    return _imageV;
}
#pragma mark - Private Method
-(UIImage *)launchImage{
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString *viewOrientation = @"Portrait";
    NSString *launchImageName = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary* dict in imagesDict){
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]){
            launchImageName = dict[@"UILaunchImageName"];
            UIImage *image = [UIImage imageNamed:launchImageName];
            return image;
        }
    }
    return nil;
}
- (UIImageView *)bottomImage {
    if (_bottomImage == nil) {
        _bottomImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.height - 135, self.width, 135)];
        _bottomImage.image = [UIImage imageNamed:@"company"];
        _bottomImage.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bottomImage;
}
- (UIButton *)skipBtn {
    if (_skipBtn == nil) {
        _skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_skipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _skipBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _skipBtn.frame = CGRectMake(self.width - 120, 20, 100, 30);
        _skipBtn.alpha = 0.92;
        _skipBtn.layer.cornerRadius = 10.0;
        _skipBtn.clipsToBounds = YES;
        [_skipBtn setBackgroundColor:UIColorFromRGBWithOX(0x19093F)];
        [_skipBtn addTarget:self action:@selector(skipAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _skipBtn;
}
@end
