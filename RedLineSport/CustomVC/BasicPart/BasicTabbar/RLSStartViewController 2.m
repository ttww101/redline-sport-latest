#import "RLSStartViewController.h"
@interface RLSStartViewController ()
@property (nonatomic, strong)  UIImageView *launchImageView;
@end
@implementation RLSStartViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.launchImageView];
    [self.launchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
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
#pragma mark - Setter
- (UIImageView *)launchImageView {
    if (_launchImageView == nil) {
        _launchImageView = [UIImageView new];
        _launchImageView.image = [self launchImage];
        _launchImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _launchImageView;
}
@end
