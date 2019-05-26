#import "RLSBasicModel.h"
@interface RLSRecommandListModel : RLSBasicModel
@property (nonatomic, copy) NSString *rank;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *realnums;
@property (nonatomic, copy) NSString *casua;
@property (nonatomic, copy)NSString *casuatwo;
@property (nonatomic, copy) NSString *createtime;
@property (nonatomic, copy) NSString *datestr;
@property (nonatomic, copy) NSString *extension2;
@property (nonatomic, assign) NSInteger extension1;
@property (nonatomic, assign) NSInteger idId;
@property (nonatomic, assign) NSInteger play;
@property (nonatomic, assign) NSInteger ranktype;
@property (nonatomic, assign) NSInteger userid;
@property (nonatomic, assign) NSInteger sclassid;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, copy) NSString *usertitle;
@property (nonatomic, strong) NSArray *medals;
@property (nonatomic, assign) NSInteger winNum;
@property (nonatomic, assign) NSInteger goNum;
@property (nonatomic, assign) NSInteger loseNum;
@end
