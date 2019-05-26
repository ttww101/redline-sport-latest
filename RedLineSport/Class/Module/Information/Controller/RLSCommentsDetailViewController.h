#import "RLSBasicViewController.h"
#import "RLSInfoModel.h"
@interface RLSCommentsDetailViewController : RLSBasicViewController
@property (nonatomic , strong) InfoGroupModel *dataModel;
@property (nonatomic , strong) NSString *ID;
@property (nonatomic , copy) NSString *commentsID;
@property (nonatomic , strong) NSString *module;
@end
