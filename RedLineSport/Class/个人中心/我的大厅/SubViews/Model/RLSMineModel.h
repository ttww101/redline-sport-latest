#import <Foundation/Foundation.h>
@interface RLSMineModel : NSObject
@property (nonatomic, copy) NSString *leftContent;
@property (nonatomic, copy) NSString *rightContent;
@property (nonatomic, copy) NSString *leftImageName;
@property (nonatomic, copy) NSString *rightImageName;
@property (nonatomic, copy) NSString *numbers;
@end
@interface GQMineGroupModel : NSObject
@property (nonatomic, strong) NSMutableArray *groupArray;
@end
