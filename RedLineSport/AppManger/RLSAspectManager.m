#import "RLSAspectManager.h"
@implementation RLSAspectManager
+ (void)GQ_SavePageDic {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [dic setObject:version forKey:@"appVersion"];
    NSDictionary *pageDic = @{@"RLSFirstViewController"                :@"首页",
                              @"RLSPanwangZhishuVC"                    :@"盘王指数",
                              @"RLSJiXianVC"                           :@"极限拐点",
                              @"RLSBettingVC"                          :@"投注异常",
                              @"RLSJiaoYiViewController"               :@"交易冷热",
                              @"RLSTongpeiTongjiVC"                    :@"同赔统计",
                              @"RLSTongPeiDetailVC"                    :@"同赔统计详情",
                              @"RLSTongPeiPeiLvDTVC"                   :@"同赔统计指数",
                              @"RLSBaolengZhishuVC"                    :@"爆冷指数",
                              @"RLSBaolengDetailVC"                    :@"爆冷指数详情",
                              @"RLSPeilvYichangVC"                     :@"指数异常",
                              @"RLSYapanZhoushouVC"                    :@"亚指助手",
                              @"RLSLiveViewController"                 :@"动画",
                              @"RLSLiveListViewController"             :@"动画详情",
                              @"RLSLiveQuizViewController"             :@"直播答题",
                              @"RLSCouponListViewController"           :@"优惠券",
                              @"RLSLiveQuizWithDrawalViewController"   :@"直播答题提现",
                              @"RLSBifenSetingViewController"          :@"比分页设置",
                              @"RLSSaishiSelecterdVC"                  :@"比分筛选",
                              @"RLSSelectedAllVC"                      :@"所有筛选",
                              @"RLSSelectedChupanVC"                   :@"初指筛选",
                              @"RLSSelectedJincaiVC"                   :@"竞猜筛选",
                              @"RLSSearchMatchVC"                      :@"比分页搜索",
                              @"RLSBifenViewController"                :@"比分大厅",
                              @"RLSGuanzhuViewController"              :@"关注",
                              @"RLSJishiViewController"                :@"即时",
                              @"RLSSaichengViewController"             :@"赛程",
                              @"RLSSaiguoViewController"               :@"赛果",
                              @"RLSFenxiPageVC"                        :@"比赛详情",
                              @"RLSPeiLvDetailVC"                      :@"指数详情",
                              @"RLSJiShiPeiLvVC"                       :@"即时指数",
                              @"RLSDoubleBattleVC"                     :@"双赔",
                              @"RLSFabuTuijianSelectedItemVC"          :@"发布推荐",
                              @"RLSRelRecNewVC"                        :@"选择指数",
                              @"RLSBuyRecordsVC"                       :@"购买记录",
                              @"RLSFaBuSucceedVCViewController"        :@"发布成功",
                              @"RLSTuijianDTViewController"            :@"推荐大厅",
                              @"RLSTuijianDetailVC"                    :@"推荐详情",
                              @"RLSSearchViewController"               :@"搜索专家",
                              @"RLSNewRecommandVC"                     :@"榜单",
                              @"RLSQBNavigationVC"                     :@"情报导航",
                              @"RLSNewQingBaoViewController"           :@"情报大厅",
                              @"RLSMyBuyTuijianVC"                     :@"我的购买",
                              @"RLSUserViewController"                 :@"个人主页",
                              @"RLSFeedbackNewVC"                      :@"意见反馈",
                              @"RLSSettingVC"                          :@"设置",
                              @"RLSPushSettingVC"                      :@"推送设置",
                              @"RLSChangePassWordVC"                   :@"修改密码",
                              @"RLSAnQuanCenterVC"                     :@"安全中心",
                              @"RLSRealNameCerVC"                      :@"实名认证",
                              @"RLSFriendsVC"                          :@"我的关注",
                              @"RLSMineViewController"               :@"个人中心",
                              @"RLSUserTuijianVC"                      :@"我的推荐",
                              @"RLSTongjiVC"                           :@"我的统计",
                              @"RLSMyProfileVC"                        :@"我的资料",
                              @"RLSSignatureVC"                        :@"个人签名",
                              @"RLSAnalystsEventFilterVC"              :@"申请分析师",
                              @"RLSToAnalystsVC"                       :@"成为分析师",
                              @"RLSForgetPswViewController"            :@"忘记密码",
                              @"RLSLoginViewController"                :@"登陆",
                              @"RLSRegisterViewController"             :@"注册",
                              @"RLSChangePhoneNumVC"                   :@"绑定手机",
                              @"RLSLotteryWebViewController"           :@"活动web",
                              };
    [dic setObject:pageDic forKey:@"pageDic"];
    NSString*doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString*path=[doc stringByAppendingPathComponent:PAGE_PATH];
    [dic writeToFile:path atomically:YES];
}
+ (NSMutableDictionary *)GQ_PathForPageDic {
    NSString*doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString*path=[doc stringByAppendingPathComponent:PAGE_PATH];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    return dic;
}
@end
