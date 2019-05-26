#import "RLSTuijiandatingModel.h"
#import "RLSUsermarkModel.h"
#import "RLSMedalsModel.h"
#import "RLSpayUserModel.h"
@implementation RLSTuijiandatingModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"GuestTeam" : @"GuestTeam",
             @"comment_count" : @"comment_count",
             @"leagueName" : @"leagueName",
             @"Name_JS" : @"Name_JS",
             @"choice" : @"choice",
             @"nickName" : @"nickName", 
              @"nickname" : @"nickname", 
             @"fans" : @"fans",
             @"win_rate" : @" ",
             @"share_count" : @"share_count",
             @"HomeTeam" : @"HomeTeam",
             @"match_id" : @"match_id",
             @"share_weixin_count" : @"share_weixin_count",
             @"avatar" : @"avatar",
             @"pic" : @"pic",
             @"matchTime" : @"matchTime",
              @"MatchTime" : @"MatchTime",
             @"share_weibo_count" : @"share_weibo_count",
             @"newsId" : @"newsId",
             @"idId" : @"id",
             @"content" : @"content",
             @"title" : @"title",
             @"profit_rate" : @"profit_rate",
             @"recommend_count" : @"recommend_count",
             @"like_count" : @"like_count",
             @"create_time" : @"create_time",
             @"userId" : @"userId",
             @"user_id" : @"user_id",
             @"lotterySort" : @"lotterySort",
             @"follower_count" : @"follower_count",
             @"focus_count" : @"focus_count",
             @"info_count" : @"info_count",
             @"ya" : @"ya",
             @"spf" : @"spf",
             @"dx" : @"dx",
             @"focused" : @"focused",
             @"liked" : @"liked",
             @"recommendResult" : @"recommendResult",
             @"result" : @"result",
             @"hate_count" : @"hate_count",
             @"hated" : @"hated",
             @"matchState" : @"matchState",
              @"MatchState" : @"MatchState",
             @"GuestScore" : @"GuestScore",
             @"HomeScore" : @"HomeScore",
             @"multiple" : @"multiple",
             @"company" : @"company",
             @"usertitle" : @"usertitle",
             @"earn" : @"earn",
             @"arrUsermark" : @"usermark",
             @"medals" : @"medals",
             @"contentInfo" : @"contentInfo",
             @"leagueColor" : @"leagueColor",
             @"readCount" : @"readCount",
             @"dayRange" : @"dayRange",
             @"amount" : @"amount",
             @"oid" : @"oid",
             @"paytime" : @"paytime",
             @"paystatus" : @"paystatus",
             @"payUsers_count": @"payUsers_count",
             @"canSee": @"canSee",
             @"see": @"see",
             @"payUsers":@"payUsers",
             @"userinfo":@"userinfo",
             @"status":@"status",
             @"playtype":@"playtype",
             @"odds":@"odds",
             @"otype":@"otype",
             @"levelName": @"levelName",
             @"remark":@"remark",
             @"goodSclass":@"goodSclass",
             @"sclassWinRate":@"sclassWinRate",
             @"playWinRate":@"playWinRate",
             @"goodPlay":@"goodPlay",
             @"recommendTime":@"recommendTime",
             @"playType":@"playType",
             @"buyCount":@"buyCount",
             @"showPrice": @"showPrice",
             @"showBuyCount":@"showBuyCount",
             @"red":@"red",
             @"sclassRed":@"sclassRed",
             @"slogan":@"slogan",
             @"tenWinRate": @"tenWinRate",
             @"read_count":@"read_count"
             };
}
- (void)setHomeTeam:(NSString *)homeTeam {
    _homeTeam = homeTeam;
    if (_HomeTeam == nil) {
        _HomeTeam = _homeTeam;
    }
}
- (void)setGuestTeam:(NSString *)guestTeam {
    _guestTeam = guestTeam;
    if (_GuestTeam == nil) {
        _GuestTeam = _guestTeam;
    }
}
- (void)setGuestScore:(NSInteger)guestScore {
    _guestScore = guestScore;
    if (_GuestScore == 0 && _guestScore > 0) {
        _GuestScore = _guestScore;
    }
}
- (void)setHomeScore:(NSInteger)homeScore {
    _homeScore = homeScore;
    if (_HomeScore == 0 && _homeScore > 0) {
        _HomeScore = _homeScore;
    }
}
- (void)setGuestTeamID:(NSInteger)guestTeamID {
    _guestTeamID = guestTeamID;
    if (_GuestTeamID == 0 && _guestTeamID > 0) {
        _GuestTeamID = _guestTeamID;
    }
}
- (void)setHomeTeamID:(NSInteger)homeTeamID {
    _homeTeamID = homeTeamID;
    if (_HomeTeamID == 0 && _homeTeamID > 0) {
        _HomeTeamID = _homeTeamID;
    }
}
- (void)setLeagueName:(NSString *)leagueName {
    _leagueName = leagueName;
    _Name_JS = _leagueName;
}
- (void)setAvatar:(NSString *)avatar {
    _avatar = avatar;
    _pic = _avatar;
}
- (void)setNickName:(NSString *)nickName {
    _nickName = nickName;
    _nickname = _nickName;
}
- (void)setmatchTime:(NSString *)matchTime {
    _matchTime = matchTime;
    _MatchTime = _matchTime;
}
- (void)setNewsId:(NSInteger)newsId {
    _newsId = newsId;
    _idId = _newsId;
}
- (void)setRecommendResult:(NSString *)recommendResult {
    _recommendResult = recommendResult;
    _result = _recommendResult;
}
- (void)setUserId:(NSInteger)userId {
    _userId = userId;
    _user_id = _userId;
}
- (void)setmatchState:(NSInteger)matchState {
    _matchState = matchState;
    _MatchState = _matchState;
}
- (void)setCanSee:(BOOL)canSee {
    _canSee = canSee;
    _see = _canSee;
}
- (void)setPlayType:(NSInteger)playType {
    _playType = playType;
    _playtype = _playType;
}
+ (NSValueTransformer *)arrUsermarkJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSUsermarkModel class]];
}
+ (NSValueTransformer *)medalsJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSMedalsModel class]];
}
+ (NSValueTransformer *)payUsersJSONTransformer
{
    return [MTLValueTransformer mtl_JSONArrayTransformerWithModelClass:[RLSpayUserModel class]];
}
@end
