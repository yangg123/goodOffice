// AFAppDotNetAPIClient.h
//
// Copyright (c) 2012 Mattt Thompson (http://mattt.me/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AFAppDotNetAPIClient.h"

@implementation AFAppDotNetAPIClient

+ (instancetype)sharedClientWithBaseUrlStr:(NSString *)baseUrlStr
{
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    //是否允许CA不信任的证书通过
    policy.allowInvalidCertificates = YES;
    //是否验证主机名
    policy.validatesDomainName = YES;
    
    if ([baseUrlStr isEqualToString:DEFAULT_URL]) {
        
        static AFAppDotNetAPIClient *_sharedClient = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:DEFAULT_URL]];
            _sharedClient.requestSerializer = [AFHTTPRequestSerializer serializer];
            _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
            _sharedClient.securityPolicy = policy;
        });
        
        return _sharedClient;
        
    } else if ([baseUrlStr isEqualToString:WEIXIN_LOGIN_URL]) {  //微信授权登录接口
        
        static AFAppDotNetAPIClient *_sharedClient = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:WEIXIN_LOGIN_URL]];
            _sharedClient.requestSerializer = [AFHTTPRequestSerializer serializer];
            _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
            _sharedClient.securityPolicy = policy;
        });
        
        return _sharedClient;
        
    } else if ([baseUrlStr isEqualToString:WeiboUrl]) {
        
        static AFAppDotNetAPIClient *_sharedClient = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:WeiboUrl]];
            _sharedClient.requestSerializer = [AFHTTPRequestSerializer serializer];
            _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
            _sharedClient.securityPolicy = policy;
        });
        
        return _sharedClient;
        
    }
    else if ([baseUrlStr isEqualToString:TrendURL]){
        
        static AFAppDotNetAPIClient *_sharedClient = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:TrendURL]];
            _sharedClient.requestSerializer = [AFHTTPRequestSerializer serializer];
            _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
            _sharedClient.securityPolicy = policy;
            [_sharedClient.requestSerializer setValue:@"YekeAgent" forHTTPHeaderField:@"User-Agent"];
        });
        
        return _sharedClient;
    } else if ([baseUrlStr isEqualToString:@"http://api.360yeke.com/"]){   //隐藏会员中心 ==》用域名
        
        static AFAppDotNetAPIClient *_sharedClient = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:baseUrlStr]];
            _sharedClient.requestSerializer = [AFHTTPRequestSerializer serializer];
            _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
            _sharedClient.securityPolicy = policy;
            [_sharedClient.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringCacheData];
        });
        
        return _sharedClient;
    }
    return nil;
}

@end
