#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, HerderStyle) {
    HerderStyleNone,
    HerderStyleTotal
};
@protocol FoldSectionHeaderViewDelegate <NSObject>
- (void)foldHeaderInSection:(NSInteger)SectionHeader;
@end
@interface RLSHSJFoldHeaderView : UITableViewHeaderFooterView
@property(nonatomic, assign) BOOL fold;
@property(nonatomic, assign) NSInteger section;
@property(nonatomic, weak) id<FoldSectionHeaderViewDelegate> delegate;
@property(nonatomic, strong) UIColor    *titleColor;
@property(nonatomic, assign) BOOL       lineHided;
@property(nonatomic, assign) BOOL       YLineHided;
@property(nonatomic, assign) BOOL       roViewHided;
@property(nonatomic, assign) BOOL       rightViewHided;
@property(nonatomic, strong) UIColor    *backGrColor;
@property (nonatomic, strong) UIImage    *clickView;
@property (nonatomic, assign) BOOL      isRedRo;
- (void)setFoldSectionHeaderViewWithTitle:(NSString *)title detail:(NSString *)detail type:(HerderStyle)type section:(NSInteger)section canFold:(BOOL)canFold;
@end
