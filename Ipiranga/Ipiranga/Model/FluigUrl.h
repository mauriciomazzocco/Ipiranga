//
//  FluigUrl.h
//  Social ECM
//
//  Created by Flávio Luiz Maria on 6/29/13.
//  Copyright (c) 2013 TOTVS S.A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OauthServer.h"

@interface FluigUrl : NSObject {
    
}

+(NSString *)getPortalUrl;
+(NSString *)getPortalUrl:(OauthServer *)oauthServer;

+(NSString *)getSocialUrl;
+(NSString *)getSocialUrl:(OauthServer *)oauthServer;

+(NSString *)getECMUrl;
+(NSString *)getECMUrl:(OauthServer *)oauthServer;

+(NSString *)getBPMUrl;
+(NSString *)getBPMUrl:(OauthServer *)oauthServer;

+(NSString *)getFluig;
+(NSString *)getFluig:(OauthServer *)oauthServer;

+(NSString *)getFluigCloud;

+(NSString *)getPublicApi;
+(NSString *)getPublicApi:(OauthServer *)oauthServer;

+(NSString *)getMobileApi;
+(NSString *)getMobileApi:(OauthServer *)oauthServer;
@end
