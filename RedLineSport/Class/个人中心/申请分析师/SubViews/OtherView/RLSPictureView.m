#import "RLSPictureView.h"
@interface RLSPictureView()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIView *basicView;
@property (nonatomic, strong) UIImageView *imagePic;
@property (nonatomic, strong) UIView *viewBottom;
@property (nonatomic, strong) UILabel *labImg;
@property (nonatomic, strong) UILabel *labDetail;
@end
@implementation RLSPictureView
- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
- (void)setDetailText:(NSString *)detailText
{
    _detailText = detailText;
    [self addSubview:self.basicView];
    _labDetail.text = _detailText;
    if ([detailText isEqualToString:@"手持身份证"]) {
        _imagePic.image = [UIImage imageNamed:@"shenfenzheng2"];
    }else if ([detailText isEqualToString:@"身份证正面"]) {
        _imagePic.image = [UIImage imageNamed:@"shenfenzheng3"];
    }else if ([detailText isEqualToString:@"身份证背面"]) {
        _imagePic.image = [UIImage imageNamed:@"shenfenzheng1"];
    }else{
        _imagePic.image = [UIImage imageNamed:@"shenfenzheng1"];
    }
}
- (void)setImagePicUrl:(NSString *)imagePicUrl
{
    _imagePicUrl = imagePicUrl;
}
- (UIView *)basicView
{
    if (!_basicView) {
        _basicView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (Width - 30 - 14)/3, 90)];
        [_basicView addSubview:self.imagePic];
        [_basicView addSubview:self.viewBottom];
        [_basicView addSubview:self.labImg];
        [_basicView addSubview:self.labDetail];
    }
    return _basicView;
}
- (UIImageView *)imagePic
{
    if (!_imagePic) {
        _imagePic = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _basicView.width, 60)];
        _imagePic.image = [UIImage imageNamed:@"defaultPic"];
        _imagePic.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getPhonePhoto)];
        [_imagePic addGestureRecognizer:tap];
        _imagePic.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imagePic;
}
- (UIView *)viewBottom
{
    if (!_viewBottom) {
        _viewBottom = [[UIView alloc] initWithFrame:CGRectMake(0, 40, _basicView.width, 20)];
        _viewBottom.backgroundColor = redcolor;
        _viewBottom.alpha = 0.8;
        _viewBottom.userInteractionEnabled = NO;
    }
    return _viewBottom;
}
- (UILabel *)labImg
{
    if (!_labImg) {
        _labImg = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, _basicView.width, 20)];
        _labImg.font  = font12;
        _labImg.textAlignment = NSTextAlignmentCenter;
        _labImg.textColor = [UIColor whiteColor];
        _labImg.text = @"点击上传";
        _labImg.userInteractionEnabled = NO;
    }
    return _labImg;
}
- (UILabel *)labDetail
{
    if (!_labDetail) {
        _labDetail = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, _basicView.width, 30)];
        _labDetail.font  = font12;
        _labDetail.textColor = color66;
        _labDetail.textAlignment = NSTextAlignmentCenter;
    }
    return _labDetail;
}
- (void)getPhonePhoto
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相册" otherButtonTitles:@"拍照", nil];
    [actionSheet showInView:APPDELEGATE.customTabbar.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        UIImagePickerController *pickerVC = [[UIImagePickerController alloc] init];
        pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerVC.delegate = self;
        pickerVC.allowsEditing = YES;
        [APPDELEGATE.customTabbar presentToViewController:pickerVC animated:YES completion:^{
        }];
    }else if (buttonIndex == 1){
        UIImagePickerController *pickerVC = [[UIImagePickerController alloc] init];
        pickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        pickerVC.delegate = self;
        pickerVC.allowsEditing = YES;
        [APPDELEGATE.customTabbar presentToViewController:pickerVC animated:YES completion:^{
        }];
    }else{
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    UIImage *imagef = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    _imagePic.image = imagef;
    _labImg.text = @"点击切换";
    self.imageSave = imagef;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}
@end
