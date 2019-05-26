#import "RLSAppConfig.h"
#import "ArchiveFile.h"
#import <AdSupport/AdSupport.h>
#import <WebKit/WebKit.h>
#define Config_Version @"configVersion"
@implementation RLSAppConfig

+ (instancetype)shareInstance {
    static RLSAppConfig *manger;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [[self alloc]init];
    });
    return manger;
}

- (void)initialize {
    NSLog(@"----SandBox     %@",[ArchiveFile LibraryDirectory]);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:[RLSHttpString getCommenParemeter]];
        [[RLSDCHttpRequest shareInstance]sendGetRequestByMethod:@"get" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_liveQuiz] Start:^(id requestOrignal) {
        } End:^(id responseOrignal) {
        } Success:^(id responseResult, id responseOrignal) {
            NSString *code = responseOrignal[@"code"];
            if ([code isEqualToString:@"200"]) {
                NSMutableArray *dataArray = responseOrignal[@"data"];
                if (dataArray.count == 0) {
                    [ArchiveFile clearCachesWithFilePath:Activity_Path];
                } else {
                   [ArchiveFile saveDataWithPath:Activity_Path data:dataArray];
                }
            }
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        }];
        NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        [parameter setObject:idfa forKey:@"idfa"];
        [[RLSDCHttpRequest shareInstance]sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_idfa] ArrayFile:nil Start:^(id requestOrignal) {
        } End:^(id responseOrignal) {
        } Success:^(id responseResult, id responseOrignal) {
            NSLog(@"sucess");
        } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
            NSLog(@"failure");
        }];
    });
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSString *oldAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSString *version = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    NSString *agent = [NSString stringWithFormat:@" gqapp/%@",version];
    NSString *newAgent = [oldAgent stringByAppendingString:agent];
    NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:newAgent, @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
    WKWebView *wkWeb = [[WKWebView alloc] initWithFrame:CGRectZero];
    [wkWeb evaluateJavaScript:@"navigator.userAgent" completionHandler:^(id result, NSError *error) {
        NSString *oldAgent = result;
        NSString *version = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
        NSString *agent = [NSString stringWithFormat:@" gqapp/%@",version];
        NSString *newAgent = [oldAgent stringByAppendingString:agent];
        NSDictionary *dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:newAgent, @"UserAgent", nil];
        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
    }];
}
@end
