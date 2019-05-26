#import <Foundation/Foundation.h>
@interface RLSWithdrawalModel : NSObject
@property (nonatomic , assign) NSUInteger created;
@property (nonatomic , copy) NSString *amount;
@property (nonatomic , copy) NSString *item_name;
@end
@interface WithdrawaListModel : NSObject
@property (nonatomic , copy) NSString *total_winner_count;
@property (nonatomic , copy) NSString *note;
@property (nonatomic , copy) NSString *total_reward_amount;
@property (nonatomic , assign) BOOL is_allow;
@property (nonatomic , strong) NSMutableArray *items;
@end
