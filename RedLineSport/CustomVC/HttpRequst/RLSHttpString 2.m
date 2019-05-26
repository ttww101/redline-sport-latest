#import "RLSHttpString.h"
@interface RLSHttpString()
@end
@implementation RLSHttpString
+ (NSString *)getBackStringByCode:(NSString *)code
{
    if ([code isEqualToString:@"200"]) {
        return @"成功";
    }
    if ([code isEqualToString:@"201"]) {
        return @"服务器处理异常";
    }
    if ([code isEqualToString:@"500"]) {
        return @"服务器处理错误";
    }
    if ([code isEqualToString:@"1000"]) {
        return @"请求参数不规范";
    }
    if ([code isEqualToString:@"1001"]) {
        return @"当前只支持1.0版本";
    }
    if ([code isEqualToString:@"1002"]) {
        return @"用户的key 不存在";
    }
    if ([code isEqualToString:@"1003"]) {
        return @"该url已过期";
    }
    if ([code isEqualToString:@"1004"]) {
        return @"用户签名无效";
    }
    if ([code isEqualToString:@"2000"]) {
        return @"用户不存在!";
    }
    if ([code isEqualToString:@"2001"]) {
        return @"密码有误!";
    }
    if ([code isEqualToString:@"2002"]) {
        return @"手机号格式不对!";
    }
    if ([code isEqualToString:@"2003"]) {
        return @"手机验证码发送失败!";
    }
    if ([code isEqualToString:@"2004"]) {
        return @"验证码有误";
    }
    if ([code isEqualToString:@"2005"]) {
        return @"注册失败";
    }
    if ([code isEqualToString:@"2006"]) {
        return @"该手机号已被注册过";
    }
    if ([code isEqualToString:@"2008"])
    {
        return @"用户没有登录";
    }
    if ([code isEqualToString:@"2009"])
    {
        return @"用户没有权限";
    }
    else{
    return @"加载失败";
    }
}
+ (NSDictionary *)getCommenParemeter
{
    NSString *version = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    if ([RLSMethods login]) {
        RLSUserModel *model =[RLSMethods getUserModel];
        return [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"platform",@"1",@"visit",[NSString stringWithFormat:@"%ld",(long)model.idId],@"cnickid",[NSString stringWithFormat:@"%ld",(long)model.idId],@"userId",version,@"version", nil];
    }
    return [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"platform",@"1",@"visit",version,@"version", nil];
}
@end
