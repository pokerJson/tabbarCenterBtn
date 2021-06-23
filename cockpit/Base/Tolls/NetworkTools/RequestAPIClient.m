//
//  RequestAPIClient.m
//  ThreePersonEducation
//
//  Created by maxudong on 2019/4/9.
//  Copyright © 2019 maxudong. All rights reserved.
//

#import "RequestAPIClient.h"
#import "NetworkJudgement.h"
//#import "DGLoginTools.h"

#define kRequestTimeOutInterval     20.f //请求超时时限
#define kImageRquestTimeOutInterval 15.f //图片请求超时时限

@interface RequestAPIClient () <NSURLSessionDelegate>

{
    AFHTTPSessionManager *_sessionManager;
}

@end

@implementation RequestAPIClient

static id requestAPIClient = nil;

/**
 *  单例
 */
+ (__kindof RequestAPIClient *)APIClientInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!requestAPIClient) {
            requestAPIClient = [[self alloc] init];
        }
    });
    
    return requestAPIClient;
}

#pragma mark -
#pragma mark networkHandler
/**
 *  升级服务器网络请求 (POST / GET)
 *
 *  @param path         接口拼接路径
 *  @param params       请求体
 *  @param method       get / post
 *  @param successBlock 成功
 *  @param failureBlock 失败
 */
- (void)sendNoticeRequestPath:(NSString *)path
                 params:(NSDictionary *)params
                 method:(NSString *)method
                success:(APISuccessBlock)successBlock
                failure:(APIFailureBlock)failureBlock

{
    
    /** 实时监测网络状态*/
    [[NetworkJudgement defaultInstance] judgeNetWorkIsAvailable];
    
    DGLog(@"params = %@",params);
    NSString *fullPath = [NSString stringWithFormat:@"%@%@", kMainUpdateUrl_HTTP, path];
    _sessionManager = [AFHTTPSessionManager manager];
    _sessionManager.requestSerializer.timeoutInterval = kRequestTimeOutInterval;
    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    [_sessionManager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", nil]];
    /** 设置头部信息*/
    [self setHTTPHeaderInfoBy:params];
    
    if ([[method lowercaseString] isEqualToString:@"get"]) {
        
        if(kCurrentSystemVersion <= 7.0f) {
            
            fullPath = [fullPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
        } else {
            
            fullPath = [fullPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
        }
        
        DGLog(@"网络请求地址: %@", fullPath);
        
        [_sessionManager GET:fullPath parameters:params  headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self successDataTask:task ResponseObject:responseObject success:successBlock failure:failureBlock];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            failureBlock(error);
        }];
        
    } else if ([[method lowercaseString] isEqualToString:@"post"]) {
        
        if(kCurrentSystemVersion <= 7.0f) {
            
            fullPath = [fullPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
        } else {
            
            fullPath = [fullPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
        }
        
        DGLog(@"网络请求地址: %@", fullPath);
        
        [_sessionManager POST:fullPath parameters:params  headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self successDataTask:task ResponseObject:responseObject success:successBlock failure:failureBlock];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            failureBlock(error);
        }];
    }
}
/**
 *  网络请求 (POST / GET)
 *
 *  @param path         接口拼接路径
 *  @param params       请求体
 *  @param method       get / post
 *  @param successBlock 成功
 *  @param failureBlock 失败
 */
- (void)sendRequestPath:(NSString *)path
                 params:(NSDictionary *)params
                 method:(NSString *)method
                success:(APISuccessBlock)successBlock
                failure:(APIFailureBlock)failureBlock

{
    
    /** 实时监测网络状态*/
    [[NetworkJudgement defaultInstance] judgeNetWorkIsAvailable];
    
    DGLog(@"params = %@",params);
    NSString *fullPath = [NSString stringWithFormat:@"%@%@", kMainUrl_HTTP, path];
    _sessionManager = [AFHTTPSessionManager manager];
    _sessionManager.requestSerializer.timeoutInterval = kRequestTimeOutInterval;
    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    [_sessionManager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", nil]];
    /** 设置头部信息*/
    [self setHTTPHeaderInfoBy:params];
    
    if ([[method lowercaseString] isEqualToString:@"get"]) {
        
        if(kCurrentSystemVersion <= 7.0f) {
            
            fullPath = [fullPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
        } else {
            
            fullPath = [fullPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
        }
        
        DGLog(@"网络请求地址: %@", fullPath);
        
        [_sessionManager GET:fullPath parameters:params headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self successDataTask:task ResponseObject:responseObject success:successBlock failure:failureBlock];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            failureBlock(error);
        }];
        
    } else if ([[method lowercaseString] isEqualToString:@"post"]) {
        
        if(kCurrentSystemVersion <= 7.0f) {
            
            fullPath = [fullPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
        } else {
            
            fullPath = [fullPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
        }
        
        DGLog(@"网络请求地址: %@", fullPath);
        
        [_sessionManager POST:fullPath parameters:params headers:nil  progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

            [self successDataTask:task ResponseObject:responseObject success:successBlock failure:failureBlock];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            failureBlock(error);
        }];
    }
}

/**
 *  网络请求 (POST / GET)
 *
 *  @param path         接口拼接路径
 *  @param params       请求体
 *  @param method       get / post
 *  @param successBlock 成功
 *  @param failureBlock 失败
 */
- (void)sendJsonRequestPath:(NSString *)path
                     params:(id)params
                     method:(NSString *)method
                    success:(APISuccessBlock)successBlock
                    failure:(APIFailureBlock)failureBlock

{
    
    /** 实时监测网络状态*/
    [[NetworkJudgement defaultInstance] judgeNetWorkIsAvailable];
    
    DGLog(@"params = %@",params);
    NSString *fullPath = [NSString stringWithFormat:@"%@%@", kMainUrl_HTTP, path];
    _sessionManager = [AFHTTPSessionManager manager];
    _sessionManager.requestSerializer.timeoutInterval = kRequestTimeOutInterval;
    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    _sessionManager.requestSerializer  = [AFJSONRequestSerializer serializer];
    [_sessionManager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", nil]];
    /** 设置头部信息*/
    [self setHTTPHeaderInfoBy:params];
    
    if ([[method lowercaseString] isEqualToString:@"get"]) {
        
        if(kCurrentSystemVersion <= 7.0f) {
            
            fullPath = [fullPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
        } else {
            
            fullPath = [fullPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
        }
        
        DGLog(@"网络请求地址: %@", fullPath);
        
        [_sessionManager GET:fullPath parameters:params  headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self successDataTask:task ResponseObject:responseObject success:successBlock failure:failureBlock];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            failureBlock(error);
        }];
        
    } else if ([[method lowercaseString] isEqualToString:@"post"]) {
        
        if(kCurrentSystemVersion <= 7.0f) {
            
            fullPath = [fullPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            
        } else {
            
            fullPath = [fullPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
        }
        
        DGLog(@"网络请求地址: %@", fullPath);
        
        [_sessionManager POST:fullPath parameters:params  headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self successDataTask:task ResponseObject:responseObject success:successBlock failure:failureBlock];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            failureBlock(error);
        }];
    }
}

/**
 *  图片上传网络请求
 *
 *  @param path         接口拼接路径
 *  @param params       请求体
 *  @param imagesArr    图片数据
 *  @param imageName    图片名称
 *  @param successBlock 成功
 *  @param failureBlock 失败
 */
- (void)uploadIMGPath:(NSString *)path
               params:(NSDictionary *)params
            imagesArr:(NSArray *)imagesArr
            imageName:(NSString *)imageName
              success:(APISuccessBlock)successBlock
              failure:(APIFailureBlock)failureBlock

{
    /** 实时监测网络状态*/
    [[NetworkJudgement defaultInstance] judgeNetWorkIsAvailable];
    
    DGLog(@"params = %@",params);
    NSString *fullPath = [NSString stringWithFormat:@"%@%@", kMainUrl_HTTP, path];
    _sessionManager = [AFHTTPSessionManager manager];
    _sessionManager.requestSerializer.timeoutInterval = kImageRquestTimeOutInterval;
    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    [_sessionManager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", @"text/plain", nil]];
    /** 设置头部信息*/
    [self setHTTPHeaderInfoBy:params];

    if(kCurrentSystemVersion <= 7.0f) {

        fullPath = [fullPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    } else {

        fullPath = [fullPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    }


    [_sessionManager POST:fullPath parameters:params  headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {

        for (NSInteger i = 0; i < imagesArr.count; i++) {

            UIImage *image = imagesArr[i];
            NSData *imageData  = UIImageJPEGRepresentation(image, 0.5);
            NSString *fileName = [NSString stringWithFormat:@"%@%ld.png", imageName, (long)i + 1];
            NSString *mimeType = @"image/png";
            [formData appendPartWithFileData:imageData
                                        name:imageName
                                    fileName:fileName
                                    mimeType:mimeType];
        }

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        DGLog(@"发布进度%lf", 1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        [self successDataTask:task ResponseObject:responseObject success:successBlock failure:failureBlock];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        failureBlock(error);
    }];
}



/*
 * 设置请求头信息
 */
- (void)setHTTPHeaderInfoBy:(NSDictionary *)dict
{
    DGUserInfo *userInfo = [DGUserInfoManager unarchive];
    if (userInfo) {
        if (kStringIsEmpty(userInfo.token)) {
            userInfo.token = @"";
        }

        NSLog(@"%@", kCurrentAppVersion);
        NSString *finalToken = [NSString stringWithFormat:@"%@", userInfo.token];
        [self->_sessionManager.requestSerializer setValue:finalToken ? finalToken : @"" forHTTPHeaderField:@"token"];
//        [self->_sessionManager.requestSerializer setValue:@"MTM1MjA5MzY0MDg3ODE4" forHTTPHeaderField:@"token"];
        [self->_sessionManager.requestSerializer setValue:[NSString stringWithFormat:@"v%@",kCurrentAppVersion] forHTTPHeaderField:@"version"];
//        [self->_sessionManager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"source"];
        DGLog(@"token = %@ | version = %@ | source = %@", userInfo.token, [NSString stringWithFormat:@"v%@",kCurrentAppVersion], @"ios");
    }
    [self->_sessionManager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"source"];

}


/**
 *  成功Block对数据进行处理
 *
 *  @param task           任务
 *  @param responseObject 请求结果
 *  @param successBlock   成功回调
 *  @param failureBlock   失败回调
 */
- (void)successDataTask:(NSURLSessionDataTask *)task
         ResponseObject:(id)responseObject
                success:(APISuccessBlock)successBlock
                failure:(APIFailureBlock)failureBlock
{
    
    DGUserInfo *userInfo = [DGUserInfoManager unarchive];
    DGLog(@"userInfo.token===>%@", userInfo.token);
    

    if (0 == [responseObject[@"code"] integerValue]) {
        successBlock(responseObject);
        
    } else if ([responseObject[@"code"] integerValue] == 90001 || [responseObject[@"code"] integerValue] == 90002) {
        successBlock(responseObject);
    } else if ([responseObject[@"code"] integerValue] == 90000) {
        if ( !kStringIsEmpty(userInfo.token)) {//老用户被提问了 token还有
            //登录过期
//            [DGTools dumpDataOfUser];
//            [DGLoginTools isLogin];
        }
        //登录过期
//        [DGTools dumpDataOfUser];
        failureBlock(responseObject);

    } else {
        successBlock(responseObject);
    }
}


- (void)uploadVoicePath:(NSString *)path
                 params:(NSDictionary *)params
              voiceData:(NSData *)data
              voiceName:(NSString *)name
                success:(APISuccessBlock)successBlock
                failure:(APIFailureBlock)failureBlock {
    
    /** 实时监测网络状态*/
    [[NetworkJudgement defaultInstance] judgeNetWorkIsAvailable];
    
    DGLog(@"params = %@",params);
    NSString *fullPath = [NSString stringWithFormat:@"%@%@", kMainUrl_HTTP, path];
    _sessionManager = [AFHTTPSessionManager manager];
    _sessionManager.requestSerializer.timeoutInterval = kImageRquestTimeOutInterval;
    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    [_sessionManager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", @"text/plain", nil]];
    /** 设置头部信息*/
    [self setHTTPHeaderInfoBy:params];

    if(kCurrentSystemVersion <= 7.0f) {
        fullPath = [fullPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    } else {

        fullPath = [fullPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    }
    
    [_sessionManager POST:fullPath parameters:params headers:nil  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSTimeInterval time = [[NSDate date] timeIntervalSince1970]*1000;// *1000 是精确到毫秒(13位),不乘就是精确到秒(10位)
        NSString *timeString = [NSString stringWithFormat:@"%f.mp3", time];

        [formData appendPartWithFileData:data
                                    name:name
                                fileName:timeString
                                mimeType:@".mp3"];

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        DGLog(@"发布进度%lf", 1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        [self successDataTask:task ResponseObject:responseObject success:successBlock failure:failureBlock];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        failureBlock(error);
    }];
}

- (void)requestOnPath:(NSString *)path parameters:(NSDictionary *)parameters method:(NSString *)method isJsonRequest:(BOOL)isJsonRequest onSuccess:(APISuccessBlock)onSuccess onError:(APIFailureBlock)onError {
    if (isJsonRequest) {
        [self sendJsonRequestPath:path params:parameters method:method success:onSuccess failure:onError];
    } else {
        [self sendRequestPath:path params:parameters method:method success:onSuccess failure:onError];
    }
}
@end
