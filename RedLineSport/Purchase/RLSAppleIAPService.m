#import "RLSAppleIAPService.h"
#import <StoreKit/StoreKit.h>
#import "ArchiveFile.h"
@interface RLSAppleIAPService () <SKProductsRequestDelegate, SKPaymentTransactionObserver>
@property (nonatomic, copy) MsgBlock resultBlock;
@property (nonatomic, copy) MsgBlock verifyingResultBlock;
@property (nonatomic , copy) NSString *selectProductID;
@property (nonatomic , copy) NSString *orderID;
@property (nonatomic , copy) NSString *amount;
@end
@implementation RLSAppleIAPService
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static RLSAppleIAPService *service = nil;
    dispatch_once(&onceToken, ^{
        service = [[RLSAppleIAPService alloc]init];
    });
    return service;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
    return self;
}
-(void)purchase:(id)parameter resultBlock:(MsgBlock)resultBlock {
    self.resultBlock = resultBlock;
    self.selectProductID = parameter[@"product_id"];
    self.amount = [parameter[@"amount"] stringValue];
    self.orderID = parameter[@"orderID"];
    if ([SKPaymentQueue canMakePayments]) {
        NSSet *set = [NSSet setWithObjects:self.selectProductID, nil];
        SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:set];
        request.delegate = self;
        [request start];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD showInfoWithStatus:@"正在获取商品信息"];
    } else {
        NSError *error = [NSError errorWithDomain:@"IAP"
                                             code:-1
                                         userInfo:@{ NSLocalizedDescriptionKey : @"检查是否允许支付功能或者该设备是否支持支付." }];
        if(self.resultBlock) {
            self.resultBlock(nil,error);
        }
    }
}
#pragma mark - SKProductsRequestDelegate
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSArray *products = response.products;
    if (products.count == 0) {
        NSError *error = [NSError errorWithDomain:@"IAP"
                                             code:-2
                                         userInfo:@{ NSLocalizedDescriptionKey : @"商品信息无效，请联系客服。" }];
        if(self.resultBlock) self.resultBlock(nil,error);
        return;
    }
    for (SKProduct *sKProduct in products) {
        NSLog(@"pro info");
        NSLog(@"SKProduct 描述信息：%@", sKProduct.description);
        NSLog(@"localizedTitle 产品标题：%@", sKProduct.localizedTitle);
        NSLog(@"localizedDescription 产品描述信息：%@",sKProduct.localizedDescription);
        NSLog(@"price 价格：%@",sKProduct.price);
        NSLog(@"productIdentifier Product id：%@",sKProduct.productIdentifier);
        if([sKProduct.productIdentifier isEqualToString: self.selectProductID]){
            [self buyProduct:sKProduct];
            break;
        }else{
            NSError *error = [NSError errorWithDomain:@"IAP"
                                                 code:-2
                                             userInfo:@{ NSLocalizedDescriptionKey : @"商品信息无效，请联系客服。" }];
            if(self.resultBlock) self.resultBlock(nil,error);
            return;
        }
    }
}
#pragma mark 内购的代码调用
-(void)buyProduct:(SKProduct *)product{
    SKPayment *skpayment = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addPayment:skpayment];
    [SVProgressHUD showInfoWithStatus:@"生成订单中..."];
}
- (void)requestDidFinish:(SKRequest *)request{
    NSLog(@"%s",__FUNCTION__);
}
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"%s:%@",__FUNCTION__,error.localizedDescription);
    if(self.resultBlock) self.resultBlock(nil,error);
}
#pragma mark - SKPaymentTransactionObserver
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchasing: 
                break;
            case SKPaymentTransactionStatePurchased:  
                [self completeTransaction:transaction forStatus:IAPPurchaseSucceeded];
                break;
            case SKPaymentTransactionStateFailed:     
                [self completeTransaction:transaction forStatus:IAPPurchaseFailed];
                break;
            case SKPaymentTransactionStateRestored:   
                [self completeTransaction:transaction forStatus:IAPRestoredSucceeded];
                break;
            default:
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
        }
    }
}
#pragma mark Complete transaction
-(void)completeTransaction:(SKPaymentTransaction *)transaction forStatus:(IAPPurchaseStatus)status
{
    if (transaction.error.code != SKErrorPaymentCancelled){
        switch (status) {
            case IAPPurchaseSucceeded:
            case IAPRestoredSucceeded:
            {
                [self uploadReceipt:transaction];
            }
                break;
            case IAPPurchaseFailed:
            case IAPRestoredFailed:
            {
                if(self.resultBlock) self.resultBlock(nil,transaction.error);
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            }
            default:
            {
                if(self.resultBlock) self.resultBlock(nil,transaction.error);
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            }
                break;
        }
    }else{
        NSError *error = [NSError errorWithDomain:@"IAP"
                                             code:-3
                                         userInfo:@{ NSLocalizedDescriptionKey : @"已取消支付。" }];
        if(self.resultBlock) self.resultBlock(nil,error);
        [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    }
}
- (void)completeTransaction:(SKPaymentTransaction *)transaction{
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}
-(void)uploadReceipt:(SKPaymentTransaction *)transaction {
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receipt = [NSData dataWithContentsOfURL:receiptURL];
    if (!receipt) { 
        [SVProgressHUD showSuccessWithStatus:@"本地数据不存在"];
        return;
    }
    NSString *base64_receipt = [receipt base64EncodedStringWithOptions:0];
    [ArchiveFile savePurchaseProof:@{@"base64_receipt":PARAM_IS_NIL_ERROR(base64_receipt), @"orderID":PARAM_IS_NIL_ERROR(self.orderID), @"amount":PARAM_IS_NIL_ERROR(self.amount)}];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:base64_receipt forKey:@"receipt-data"];
    NSError *error;
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:params
                                                          options:0
                                                            error:&error];
    NSMutableDictionary *parameter =[NSMutableDictionary dictionaryWithDictionary: [RLSHttpString getCommenParemeter]];
    [parameter setObject:base64_receipt forKey:@"receipt-data"];
    [parameter setObject:transaction.transactionIdentifier forKey:@"transaction_id"];
    [parameter setObject:self.orderID forKey:@"orderId"];
    [parameter setObject:self.amount forKey:@"amount"];
    
    [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_verifyPayment]  ArrayFile:nil Start:^(id requestOrignal) {
    } End:^(id responseOrignal) {
    } Success:^(id responseResult, id responseOrignal) {
        if ([[responseOrignal objectForKey:@"code"] integerValue]==200) {
            NSDictionary *dic = responseOrignal;
            NSString *statusCode = [dic[@"data"] stringValue];
            if ([statusCode isEqualToString:@"21007"]) {
                [self uploadSanBoxReceipt:requestData receipt:self.orderID];
            } else if ([statusCode isEqualToString:@"0"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [ArchiveFile removerPurchaseProof:base64_receipt];
                    if (self.resultBlock) {
                        self.resultBlock(statusCode,nil);
                    }
                });
            } else {
                [SVProgressHUD showSuccessWithStatus:@"购买失败"];
            }
        }else {
             self.resultBlock(nil,nil);
            [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"%@",[responseOrignal objectForKey:@"msg"]]];
            [SVProgressHUD dismissWithDelay:2.0f];
        }
    } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
        if (self.resultBlock) {
            self.resultBlock(false,error);
        }
        [SVProgressHUD showWithStatus:[NSString stringWithFormat:@"%@",[responseOrignal objectForKey:@"msg"]]];
        [SVProgressHUD dismissWithDelay:2.0f];
    }];
}
-(void)uploadSanBoxReceipt:(NSData *)requestData receipt:(NSString *)receipt {
    NSString *verifyUrlString = @"https://sandbox.itunes.apple.com/verifyReceipt";
    NSMutableURLRequest *storeRequest = [NSMutableURLRequest requestWithURL:[[NSURL alloc] initWithString:verifyUrlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f];
    [storeRequest setHTTPMethod:@"POST"];
    [storeRequest setHTTPBody:requestData];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:storeRequest queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (connectionError) {
                                  [SVProgressHUD showErrorWithStatus:@"链接失败"];
                               } else {
                                   NSError *error;
                                   NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                   if (!jsonResponse) {
                                       [SVProgressHUD showErrorWithStatus:@"验证失败"];
                                   }
                                   NSString *code = [jsonResponse[@"status"] stringValue];
                                   if ([code isEqualToString:@"0"]) {
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           [ArchiveFile removerPurchaseProof:self.orderID];
                                           if (self.resultBlock) {
                                               self.resultBlock(code,nil);
                                           }
                                       });
                                   }
                               }
                           }];
}
- (void)VerifyingLocalCredentialsWithBlock:(MsgBlock)resultBlock {
    self.verifyingResultBlock = resultBlock;
   NSMutableArray *arry = [ArchiveFile getDataWithPath:In_App_Purchase_Path];
    if (arry.count > 0) {
        for (NSInteger i = 0; i < arry.count; i++) {
            NSDictionary *dic = arry[i];
            NSString *base64_receipt = dic[@"base64_receipt"];
            NSString *orderID = dic[@"orderID"];
            NSString *amount = dic[@"amount"];
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            [params setObject:base64_receipt forKey:@"receipt-data"];
            NSError *error;
            NSData *requestData = [NSJSONSerialization dataWithJSONObject:params
                                                                  options:0
                                                                    error:&error];
            NSMutableDictionary *parameter =[NSMutableDictionary dictionaryWithDictionary: [RLSHttpString getCommenParemeter]];
            [parameter setObject:base64_receipt forKey:@"receipt-data"];
            [parameter setObject:orderID forKey:@"orderId"];
            [parameter setObject:amount forKey:@"amount"];
            [[RLSDCHttpRequest shareInstance] sendRequestByMethod:@"post" WithParamaters:parameter PathUrlL:[NSString stringWithFormat:@"%@%@",APPDELEGATE.url_Server,url_verifyPayment]  ArrayFile:nil Start:^(id requestOrignal) {
            } End:^(id responseOrignal) {
            } Success:^(id responseResult, id responseOrignal) {
                if ([[responseOrignal objectForKey:@"code"] integerValue]==200) {
                    NSDictionary *dic = responseOrignal;
                   NSString *statusCode = [dic[@"data"] stringValue];
                    if ([statusCode isEqualToString:@"21007"]) {
                        [ArchiveFile removerPurchaseProof:orderID];
                        [self uploadSanBoxReceipt:requestData receipt:base64_receipt];
                    } else if ([statusCode isEqualToString:@"0"]) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [ArchiveFile removerPurchaseProof:orderID];
                            if (self.verifyingResultBlock) {
                                self.verifyingResultBlock(statusCode,nil);
                            }
                        });
                    } else {
                    }
                }else {
                    if (self.verifyingResultBlock) {
                        self.verifyingResultBlock(false,error);
                    }
                }
            } Failure:^(NSError *error, NSString *errorDict, id responseOrignal) {
                if (self.verifyingResultBlock) {
                    self.verifyingResultBlock(false,error);
                }
            }];
        }
    }
}
- (void)dealloc
{
    NSLog(@"%s销毁",__FUNCTION__);
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}
- (void)getProductInfo:(NSString *)productIdentifier {
}
-(void)removeTheIAPOberver {
}
-(void)addTheIAPObserver {
}
+ (void)checkTheIAPStatusFunction {
}
@end
