//
//  RequestAPIClient.h
//  ThreePersonEducation
//
//  Created by maxudong on 2019/4/9.
//  Copyright © 2019 maxudong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *const Post_Method = @"post";
static NSString *const Get_Method  = @"get";

#pragma mark - 创建网络请求使用的三种Block

typedef void (^APISuccessBlock)(id responseObject); //成功状态
typedef void (^APIFailureBlock)(id responseObject); //失败状态

typedef void(^SuccessBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject);
typedef void(^FailureBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error);
typedef void (^Progress)(NSProgress * _Nullable progress);

@interface RequestAPIClient : NSObject

/**
 *  网络请求单例
 */
+ (__kindof RequestAPIClient *)APIClientInstance;

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
                      failure:(APIFailureBlock)failureBlock;

/**
 *  网络请求 (POST / GET)
 *
 *  @param path         接口拼接路径
 *  @param params       请求体
 *  @param method       "get" / "post"
 *  @param successBlock 成功
 *  @param failureBlock 失败
 */
- (void)sendRequestPath:(NSString *)path
                 params:(NSDictionary *)params
                 method:(NSString *)method
                success:(APISuccessBlock)successBlock
                failure:(APIFailureBlock)failureBlock;

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
                    failure:(APIFailureBlock)failureBlock;


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
              failure:(APIFailureBlock)failureBlock;


/**
 *  音频上传网络请求
 *
 *  @param path         接口拼接路径
 *  @param params       请求体
 *  @param data    音频数据
 *  @param name    音频名称
 *  @param successBlock 成功
 *  @param failureBlock 失败
 */
- (void)uploadVoicePath:(NSString *)path
               params:(NSDictionary *)params
            voiceData:(NSData *)data
            voiceName:(NSString *)name
              success:(APISuccessBlock)successBlock
              failure:(APIFailureBlock)failureBlock;

// 用来区分是否为 Json 请求
- (void)requestOnPath:(NSString *)path parameters:(NSDictionary *)parameters method:(NSString *)method isJsonRequest:(BOOL)isJsonRequest onSuccess:(APISuccessBlock)onSuccess onError:(APIFailureBlock)onError;
@end

NS_ASSUME_NONNULL_END
