//
//  CallService.m
//  4G
//  拨号网络接口
//  Created by yg on 16/2/27.
//  Copyright © 2016年 西米科技. All rights reserved.
//

#import "CallService.h"
#import "DataCenter.h"

@implementation CallService

/**
 *	@brief	拨号
 *	@param 	calleeNbr 	    拨给谁
 *	@param 	successBlock 	成功回调
 *	@param 	failedBlock 	失败回调
 */
+ (void)callPhoneNumber:(NSString *)calleeNbr
        andSuccessBlock:(SuccessBlock)successBlock
         andFailedBlock:(FailedBlock)failedBlock
{
    NSDictionary *paramsDic = @{@"userToken": DataCenterManager.userToken,
                                @"calleeNbr": calleeNbr};
    
    [super requestWithBaseUrlStrByPost:DEFAULT_URL
                               andPath:@"voice/dial"
                          andParamsDic:paramsDic
                       andSuccessBlock:^(id data){
                           
                           NSInteger flag = [[data objectForKey:@"code"] integerValue];
                           
                           if (flag == 200) {
                               
                               NSDictionary *resDic = data[@"data"][@"result"];
                               successBlock(resDic);
                               
                           } else {
                               
                               failedBlock([data objectForKey:@"message"]);
                           }
                       } andFailedBlock:^(NSString *error) {
                           
                           failedBlock(error);
                       }];
}


/**
 *	@brief	拨号停止
 *	@param 	sessionId 	    会话ID
 *	@param 	successBlock 	成功回调
 *	@param 	failedBlock 	失败回调
 */
+ (void)dialStopWithSessionId:(NSString *)sessionId
              andSuccessBlock:(SuccessBlock)successBlock
               andFailedBlock:(FailedBlock)failedBlock
{
    NSDictionary *paramsDic = @{@"userToken": DataCenterManager.userToken,
                                @"sessionId": sessionId};
    
    [super requestWithBaseUrlStrByPost:DEFAULT_URL
                               andPath:@"voice/dialStop"
                          andParamsDic:paramsDic
                       andSuccessBlock:^(id data){
                           
                           NSInteger flag = [[data objectForKey:@"code"] integerValue];
                           
                           if (flag == 200) {
                               
                               NSDictionary *resDic = data[@"data"][@"result"];
                               successBlock(resDic);
                               
                           } else {
                               
                               failedBlock([data objectForKey:@"message"]);
                           }
                       } andFailedBlock:^(NSString *error) {
                           
                           failedBlock(error);
                       }];
}


///**
// *	@brief	语音文件上传
// *	@param 	sessionId 	    会话ID
// *	@param 	successBlock 	成功回调
// *	@param 	failedBlock 	失败回调
// */
//+ (void)dialStopWithSessionId:(NSString *)sessionId
//              andSuccessBlock:(SuccessBlock)successBlock
//               andFailedBlock:(FailedBlock)failedBlock;



/**
 *	@brief 语音通知
 *	@param 用户token【userToken】:
 *	@param TTS文本内容【ttsContent】:
 *	@param 语音文件名【fileName】:
 *	@param 语音文件url【fileUrl】:
 *	@param 发给谁【calleeNbr】:
 *	@param 	successBlock 	成功回调
 *	@param 	failedBlock 	失败回调
 */
+ (void)sendVoiceToNumber:(NSString *)calleeNbr
                 fileName:(NSString *)fileName
                  fileUrl:(NSString *)fileUrl
               ttsContent:(NSString *)ttsContent
          andSuccessBlock:(SuccessBlock)successBlock
           andFailedBlock:(FailedBlock)failedBlock
{
    NSDictionary *paramsDic = @{@"userToken": DataCenterManager.userToken,
                                @"ttsContent": ttsContent,
                                @"fileName": fileName,
                                @"fileUrl": fileUrl,
                                @"calleeNbr": calleeNbr};
    
    [super requestWithBaseUrlStrByPost:DEFAULT_URL
                               andPath:@"voice/sendVoiceNotice"
                          andParamsDic:paramsDic
                       andSuccessBlock:^(id data){
                           
                           NSInteger flag = [[data objectForKey:@"code"] integerValue];
                           
                           if (flag == 200) {
                               
                               NSDictionary *resDic = data[@"data"][@"result"];
                               successBlock(resDic);
                               
                           } else {
                               
                               failedBlock([data objectForKey:@"message"]);
                           }
                       } andFailedBlock:^(NSString *error) {
                           
                           failedBlock(error);
                       }];
}

/**
 *	@brief  多方通话
 *	@param  talks 包括发起方在内多方通话的实际接入号码【calledNbr】
 *	@param 	successBlock 	成功回调
 *	@param 	failedBlock 	失败回调
 */
+ (void)multipleTalks:(NSString *)talks
      andSuccessBlock:(SuccessBlock)successBlock
       andFailedBlock:(FailedBlock)failedBlock
{
    NSDictionary *paramsDic = @{@"userToken": DataCenterManager.userToken,
                                @"calledNbr": talks};
    
    [super requestWithBaseUrlStrByPost:DEFAULT_URL
                               andPath:@"voice/talks"
                          andParamsDic:paramsDic
                       andSuccessBlock:^(id data){
                           
                           NSInteger flag = [[data objectForKey:@"code"] integerValue];
                           
                           if (flag == 200) {
                               
                               NSDictionary *resDic = data[@"data"][@"result"];
                               successBlock(resDic);
                               
                           } else {
                               
                               failedBlock([data objectForKey:@"message"]);
                           }
                       } andFailedBlock:^(NSString *error) {
                           
                           failedBlock(error);
                       }];
}

/**
 *	@brief 营销接口
 *	@param 	successBlock 	成功回调
 *	@param 	failedBlock 	失败回调
 */
+ (void)geteMarketingSuccessBlock:(SuccessBlock)successBlock
                   andFailedBlock:(FailedBlock)failedBlock
{
    NSDictionary *paramsDic = @{@"userToken": DataCenterManager.userToken};
    
    [super requestWithBaseUrlStrByPost:DEFAULT_URL
                               andPath:@"voice/marketing"
                          andParamsDic:paramsDic
                       andSuccessBlock:^(id data){
                           
                           NSInteger flag = [[data objectForKey:@"code"] integerValue];
                           
                           if (flag == 200) {
                               
                               NSDictionary *resDic = data[@"data"][@"result"];
                               successBlock(resDic);
                               
                           } else {
                               
                               failedBlock([data objectForKey:@"message"]);
                           }
                       } andFailedBlock:^(NSString *error) {
                           
                           failedBlock(error);
                       }];
}


@end
