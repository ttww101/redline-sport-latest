#import "RLSDCHttpRequest.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import <CoreFoundation/CFURL.h>
static AFHTTPRequestOperationManager *_afnetManager;
@interface RLSDCHttpRequest ()
@property (nonatomic, strong) UIView *animateBasicView;
@end
@implementation RLSDCHttpRequest
{
}
+ (RLSDCHttpRequest *)shareInstance
{
    static RLSDCHttpRequest *dcHttpRequset = nil;
    static dispatch_once_t onceInitDCHttpRequest;
    dispatch_once(&onceInitDCHttpRequest, ^{
        dcHttpRequset = [[RLSDCHttpRequest alloc] init];
    });
    if ([RLSMethods login]) {
        [_afnetManager.requestSerializer setValue:[RLSMethods getTokenModel].token forHTTPHeaderField:@"token"];
    }else{
        [_afnetManager.requestSerializer setValue:@"" forHTTPHeaderField:@"token"];
    }
    NSString *version = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    [_afnetManager.requestSerializer setValue:[NSString stringWithFormat:@"gqapp/%@", version] forHTTPHeaderField:@"User-Agent"];
    return dcHttpRequset;
}

+ (RLSDCHttpRequest *)guestInstance {
    static RLSDCHttpRequest *dcHttpRequset = nil;
    static dispatch_once_t onceInitDCHttpRequest;
    dispatch_once(&onceInitDCHttpRequest, ^{
        dcHttpRequset = [[RLSDCHttpRequest alloc] init];
    });
    [_afnetManager.requestSerializer setValue:@"MTU1ODMzNjMyNTgzMV8xMDYyMDVfTU1DaG9jb2xhdGU=.TVRVMU9ETXpOak15TlRnek1WOHhNRFl5TURWZlRVMURhRzlqYjJ4aGRHVT10b2tlbkhwZEdyNks5TFR0OVJ1a0c=" forHTTPHeaderField:@"token"];
    NSString *version = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    [_afnetManager.requestSerializer setValue:[NSString stringWithFormat:@"gqapp/%@", version] forHTTPHeaderField:@"User-Agent"];
    return dcHttpRequset;
}

- (id)init
{
    self = [super init];
    if (self) {
        _afnetManager = [[AFHTTPRequestOperationManager  manager] init];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        _afnetManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _afnetManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        [_afnetManager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        _afnetManager.requestSerializer.timeoutInterval = 8.0;
    }
    return self;
}
- (void)sendRequestByMethod:(NSString *)post
             WithParamaters:(NSDictionary *)parameters
                   PathUrlL:(NSString *)pathUrl
                  ArrayFile:(NSArray *)arrayFile
                      Start:(requestStart)start
                        End:(requestEnd)end
                    Success:(requestSuccess)success
                    Failure:(requestFailure)failure
{
    if(start)
    {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMinimumDismissTimeInterval:1.5];
        [SVProgressHUD setCornerRadius:6];
        start(parameters);
        NSLog(@"pathUrl---\n%@",pathUrl);
        NSLog(@"parameters---\n%@",parameters);
        NSMutableString *str = [NSMutableString stringWithFormat:@"%@?",pathUrl];
        [parameters.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [str appendString:[NSString stringWithFormat:@"&%@=%@",obj,[parameters objectForKey:obj]]];
        }];
        NSLog(@"%@",str);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        start(parameters);
    }
    if (!arrayFile) {
        [_afnetManager POST:pathUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@\n返回数据%@",operation.request,operation.responseString);
            NSLog(@"%@",operation.request.allHTTPHeaderFields);
            if (end) {
                end(operation.responseObject);
            }
            NSString *str_response = [NSString stringWithString:operation.responseString];
            NSData *data_response = [NSData dataWithData:[[self clearWrongtextwithString:str_response] dataUsingEncoding:NSUTF8StringEncoding]];
            [self parseResponse:data_response Success:success Failure:failure];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (end) {
                end(operation.responseObject);
            }
            NSLog(@"error ----%@,opration ---%@",error,operation.responseString);
            failure(error,error.localizedFailureReason,operation.responseObject);
        }];
    }else{
        [_afnetManager POST:pathUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            for (int i = 0; i<arrayFile.count; i++) {
                UIImage *imagePic = [arrayFile objectAtIndex:i];
                NSData *imageData;
                imageData = UIImageJPEGRepresentation(imagePic, 1);
                if (imageData.length>10000000) {
                    imageData = UIImageJPEGRepresentation(imagePic, 0.3);
                }else if (imageData.length>5000000) {
                    imageData = UIImageJPEGRepresentation(imagePic, 0.5);
                }else if (imageData.length>2000000) {
                    imageData = UIImageJPEGRepresentation(imagePic, 0.7);
                }
                [formData appendPartWithFileData:imageData name:@"imagefile" fileName:@"pic.jpg" mimeType:@"image/jpg/png/jpeg"];
            }
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (end) {
                end(operation.responseObject);
            }
            NSString *str_response = [NSString stringWithString:operation.responseString];
            NSData *data_response = [NSData dataWithData:[[self clearWrongtextwithString:str_response] dataUsingEncoding:NSUTF8StringEncoding]];
            [self parseResponse:data_response Success:success Failure:failure];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (end) {
                end(operation.responseObject);
            }
            NSLog(@"error ----%@,opration ---%@",error,operation.responseString);
            failure(error,error.localizedDescription,operation.responseObject);
        }];
    }
}
- (void)sendGetRequestByMethod:(NSString *)post
                WithParamaters:(NSDictionary *)parameters
                      PathUrlL:(NSString *)pathUrl
                         Start:(requestStart)start
                           End:(requestEnd)end
                       Success:(requestSuccess)success
                       Failure:(requestFailure)failure
{
    if(start)
    {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMinimumDismissTimeInterval:1.5];
        [SVProgressHUD setCornerRadius:6];
        start(parameters);
//        NSLog(@"pathUrl---\n%@",pathUrl);
//        NSLog(@"parameters---\n%@",parameters);
        
        NSMutableString *str = [NSMutableString stringWithFormat:@"%@?",pathUrl];
        [parameters.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [str appendString:[NSString stringWithFormat:@"&%@=%@",obj,[parameters objectForKey:obj]]];
        }];
      
    }
    
    [_afnetManager GET:pathUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (end) {
            end(operation.responseObject);
        }
        NSString *str_response = [NSString stringWithString:operation.responseString];
        NSData *data_response = [NSData dataWithData:[[self clearWrongtextwithString:str_response] dataUsingEncoding:NSUTF8StringEncoding]];
        [self parseResponse:data_response Success:success Failure:failure];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (end) {
            end(operation.responseObject);
        }
        NSLog(@"error ----%@,opration ---%@",error,operation.response);
        failure(error,error.localizedDescription,operation.responseObject);
    }];
}
- (id)parseResponse:(id)responseObject
            Success:(requestSuccess)success
            Failure:(requestFailure)failure
{
    id dict = nil;
    @try {
        dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    }
    @catch (NSException *exception) {
        failure(nil,@"数据出错catch",nil);
        return nil;
    }
    @finally {
    }
    if (dict == nil) {
        failure(nil,@"数据出错catch",nil);
        return nil;
    }
    if ([dict isKindOfClass:[NSArray class]]) {
        if (success) {
            success(@"请求成功",dict);
        }
        return dict;
    }else{
        if (![dict isKindOfClass:[NSDictionary class]]) {
            failure(nil, @"数据错误",nil);
            NSLog(@"dict----%@",dict);
            return nil;
        }
        if ([dict isKindOfClass:[NSDictionary class]]) {
            if (success) {
                id code = [dict objectForKey:@"code"];
                if ([code isKindOfClass:[NSString class]]) {
                } else if ([code isKindOfClass:[NSNumber class]]) {
                    code = [code stringValue];
                }
                if ([code isEqualToString:@"2008"]) {
//                    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"login"];
//                    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationOpenMainTableBarTimer object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"close",@"timer", nil]];
//                    [RLSMethods toLogin];
                }
                success(@"请求成功",dict);
            }
            return dict;
        }else{
            if (failure) {
                failure(nil,@"请求失败",dict);
            }
            return [[NSMutableDictionary alloc] init];
        }
    }
    return nil;
}
- (void)sendHtmlGetRequestByMethod:(NSString *)post
                    WithParamaters:(NSDictionary *)parameters
                          PathUrlL:(NSString *)pathUrl
                             Start:(requestStart)start
                               End:(requestEnd)end
                           Success:(requestSuccess)success
                           Failure:(requestFailure)failure{
    if(start)
    {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMinimumDismissTimeInterval:1.5];
        [SVProgressHUD setCornerRadius:6];
        start(parameters);
        NSLog(@"pathUrl---\n%@",pathUrl);
        NSLog(@"parameters---\n%@",parameters);
        NSMutableString *str = [NSMutableString stringWithFormat:@"%@?",pathUrl];
       [parameters.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           [str appendString:[NSString stringWithFormat:@"&%@=%@",obj,[parameters objectForKey:obj]]];
       }];
        NSLog(@"%@",str);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }
    [_afnetManager GET:pathUrl parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (end) {
            end(operation.responseObject);
        }
        success(operation.responseString,operation.responseString);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (end) {
            end(operation.responseObject);
        }
        NSLog(@"error ----%@,opration ---%@",error,operation.response);
        failure(error,error.localizedDescription,operation.responseObject);
    }];
}
- (void)sendRequestByMethod:(NSString *)post
             WithParamaters:(NSDictionary *)parameters
                   PathUrlL:(NSString *)pathUrl
                  ArrayFile:(NSArray *)arrayFile
                   FileName:(NSString *)filename
                      Start:(requestStart)start
                        End:(requestEnd)end
                    Success:(requestSuccess)success
                    Failure:(requestFailure)failure
{
    if(start)
    {
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setMinimumDismissTimeInterval:1.5];
        [SVProgressHUD setCornerRadius:6];
        start(parameters);
        NSLog(@"pathUrl---\n%@",pathUrl);
        NSLog(@"parameters---\n%@",parameters);
        NSMutableString *str = [NSMutableString stringWithFormat:@"%@?",pathUrl];
        [parameters.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [str appendString:[NSString stringWithFormat:@"&%@=%@",obj,[parameters objectForKey:obj]]];
        }];
        NSLog(@"%@",str);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        start(parameters);
    }
        [_afnetManager POST:pathUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            for (int i = 0; i<arrayFile.count; i++) {
                UIImage *imagePic = [arrayFile objectAtIndex:i];
                NSData *imageData;
                imageData = UIImageJPEGRepresentation(imagePic, 1);
                if (imageData.length>10000000) {
                    imageData = UIImageJPEGRepresentation(imagePic, 0.3);
                }else if (imageData.length>5000000) {
                    imageData = UIImageJPEGRepresentation(imagePic, 0.5);
                }else if (imageData.length>2000000) {
                    imageData = UIImageJPEGRepresentation(imagePic, 0.7);
                }
                [formData appendPartWithFileData:imageData name:filename fileName:@"pic.jpg" mimeType:@"image/jpg/png/jpeg"];
            }
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (end) {
                end(operation.responseObject);
            }
            NSString *str_response = [NSString stringWithString:operation.responseString];
            NSData *data_response = [NSData dataWithData:[[self clearWrongtextwithString:str_response] dataUsingEncoding:NSUTF8StringEncoding]];
            [self parseResponse:data_response Success:success Failure:failure];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (end) {
                end(operation.responseObject);
            }
            NSLog(@"error ----%@,opration ---%@",error,operation.responseString);
            failure(error,error.localizedDescription,operation.responseObject);
        }];
}
- (NSMutableString *)clearWrongtextwithString:(NSString *)str
{
    NSMutableString *responseString = [NSMutableString stringWithString:str];
    return responseString;
    return nil;
}
@end
