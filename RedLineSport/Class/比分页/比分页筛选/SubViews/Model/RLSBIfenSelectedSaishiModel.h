#import "RLSBasicModel.h"
@interface RLSBIfenSelectedSaishiModel : RLSBasicModel
@property (nonatomic, copy) NSString *index;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, copy) NSString *idId;
@property (nonatomic, assign) NSInteger order;
@property (nonatomic, assign) BOOL isSelected;
@end

@interface FilterModel: NSObject

@property (nonatomic , copy) NSArray<RLSBIfenSelectedSaishiModel *> *hot_items;
@property (nonatomic , copy) NSArray<RLSBIfenSelectedSaishiModel *> *other_items;
@property (nonatomic , copy) NSArray<RLSBIfenSelectedSaishiModel *> *items;

@end

@interface FilterData: NSObject

@property (nonatomic, copy) NSArray<RLSBIfenSelectedSaishiModel *> *dataList;
@property (nonatomic , copy) NSString *title;

@end
