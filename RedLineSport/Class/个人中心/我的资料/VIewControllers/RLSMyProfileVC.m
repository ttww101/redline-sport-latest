#import "RLSMyProfileVC.h"
#import "RLSSignatureVC.h"
@interface RLSMyProfileVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
@property (nonatomic, strong)UITableView *tableView;
@end
@implementation RLSMyProfileVC
- (void)viewWillAppear:(BOOL)animated{
    _model = [RLSMethods getUserModel];
    [self.tableView reloadData];
    [super viewWillAppear:animated];
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavView];
}
- (void)setNavView{
    RLSNavView *nav = [[RLSNavView alloc] init];
    nav.delegate = self;
    nav.labTitle.text = @"个人信息";
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateNormal];
    [nav.btnLeft setBackgroundImage:[UIImage imageNamed:@"backNew"] forState:UIControlStateHighlighted];
    [self.view addSubview:nav];
    [self.view addSubview:self.tableView];
}
- (void)navViewTouchAnIndex:(NSInteger)index
{
    if (index == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if(index == 2){
    }
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, APPDELEGATE.customTabbar.height_myNavigationBar, Width, Height - APPDELEGATE.customTabbar.height_myNavigationBar) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _tableView.backgroundColor = colorTableViewBackgroundColor;
        _tableView.delegate =self;
        _tableView.dataSource = self;
        _tableView.sectionFooterHeight = 10;
        _tableView.sectionHeaderHeight = 0;
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3; 
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 70;
    }
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *acell = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:acell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:acell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    while ([cell.contentView.subviews lastObject]!= nil) {
        [[cell.contentView.subviews lastObject] removeFromSuperview];
    }
    UILabel *labName = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 80, 44)];
    labName.font = font16;
    labName.textColor = color33;
    [cell.contentView addSubview:labName];
    UILabel *labStr = [[UILabel alloc] initWithFrame:CGRectMake(Width - 215, 0, 200, 44)];
    labStr.font = font12;
    labStr.textColor = color99;
    labStr.textAlignment = NSTextAlignmentRight;
    [cell.contentView addSubview:labStr];
    UIImageView *imageMore = [[UIImageView alloc] initWithFrame:CGRectMake(Width - 15 - 7, 0, 7, 14)];
    imageMore.center = CGPointMake(imageMore.center.x, labName.center.y);
    imageMore.image = [UIImage imageNamed:@"meRight"];
    [cell.contentView addSubview:imageMore];
    UIView *viewline = [[UIView alloc] initWithFrame:CGRectMake(20, 43, Width - 20, 0.5)];
    viewline.backgroundColor = colorCellLine;
    [cell.contentView addSubview:viewline];
    switch (indexPath.row) {
        case 0:{
            labName.height = 70;
            imageMore.center = CGPointMake(imageMore.center.x, labName.center.y);
            UIImageView *imgPic = [[UIImageView alloc] initWithFrame:CGRectMake(Width - 50 - 30 - 7 , 0, 50, 50)];
            imgPic.center = CGPointMake(imgPic.center.x, labName.center.y);
            imgPic.layer.cornerRadius = 25;
            imgPic.layer.masksToBounds = YES;
            imgPic.image = [UIImage imageNamed:@"defaultPic"];
            imgPic.layer.borderWidth = 0.5f;
            imgPic.layer.borderColor = [UIColor whiteColor].CGColor;
            [cell.contentView addSubview:imgPic];
            labName.text = @"我的头像";
            labStr.text = @"";
            viewline.y = 69;
            [imgPic sd_setImageWithURL:[NSURL URLWithString:_model.pic] placeholderImage:[UIImage imageNamed:@"defaultPic"]];
        }
            break;
        case 1:{ 
            imageMore.hidden = YES;
            labName.text = @"昵称";
            labStr.text = _model.nickname;
        }
            break;
        case 2:{ 
            labName.text = @"个人简介";
            if (_model.userinfo.length > 0) {
                labStr.text = _model.userinfo;
            }else{
                labStr.text = @"设置个性简介，让大家认识你";
            }
            labStr.x = labStr.x - 15;
            viewline.backgroundColor = [UIColor clearColor];
        }
            break;
        default:
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            [self login];
        }
            break;
        case 1:{
        }
            break;
        case 2:{
            RLSSignatureVC *siVC = [[RLSSignatureVC alloc] init];
            siVC.labContent = _model.userinfo;
            siVC.hidesBottomBarWhenPushed = YES;
            [APPDELEGATE.customTabbar pushToViewController:siVC animated:YES];
        }
            break;
        default:
            break;
    }
}
- (void)login
{
    if (![RLSMethods login]) {
        [RLSMethods toLogin];
        return;
    }else{
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相册" otherButtonTitles:@"拍照", nil];
        [actionSheet showInView:APPDELEGATE.customTabbar.view];
    }
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
    UIImage *imagef = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    imagef = [self compressImage:imagef toTargetWidth:240];
    NSData*imageData =UIImageJPEGRepresentation(imagef,0.7);
    imagef = [UIImage imageWithData:imageData];
    [[RLSDCHttpRequest shareInstance]sendRequestByMethod:@"post" WithParamaters:@{@"type":@"avatar"} PathUrlL:[NSString stringWithFormat:@"http://mobile.gunqiu.com:8897%@",url_uploadAliyun] ArrayFile:[NSArray arrayWithObjects:imagef, nil] Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
            NSDictionary *dic = responseOrignal;
            NSDictionary *contentDic = dic[@"data"];
            NSString *picUrl = contentDic[@"picurl"];
            picUrl = [NSString stringWithFormat:@"%@%@",url_pic,picUrl];
            NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
            [parameter setObject:picUrl forKey:@"pic"];
            [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_uploadpic] ArrayFile:nil Start:^(id requestOrignal) {
            } End:^(id responseOrignal) {
            } Success:^(id responseResult, id responseOrignal) {
                if ([[responseOrignal objectForKey:@"code"] isEqualToString:@"200"]) {
                    _model.pic = picUrl;
                    [RLSMethods updateUsetModel:_model];
                    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"userPic"]) {
                        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"userPic"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                    }
                    [self.tableView reloadData];
                }else{
                    [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
                }
            } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
                [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
            }];
        }else{
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:[responseOrignal objectForKey:@"msg"]];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:errorDict];
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}
- (UIImage*)compressImage:(UIImage*)sourceImage toTargetWidth:(CGFloat)targetWidth {
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetHeight = (targetWidth / width) * height;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0, targetWidth, targetHeight)];
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
