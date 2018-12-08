//
//  FluigUrl.m
//  Social ECM
//
//  Created by Flávio Luiz Maria on 6/29/13.
//  Copyright (c) 2013 TOTVS S.A. All rights reserved.
//

#import "FluigUrl.h"
#import "ServerManager.h"

@implementation FluigUrl

static NSString *fluigCloud= @"10.80.17.89:8080";

static NSString *PATHPortal= @"/portal";

static NSString *PATHSocial= @"/socialsimpleapi";

static NSString *PATHECM= @"/ecm";

static NSString *PATHBPM= @"/bpm";

static NSString *PATHMOBILE= @"/mobile";

static NSString *PATHBody= @"/api/rest";

static NSString *PATHPublic= @"/api/public";


//URL Padrao utilizada para autenticacao Oauth
+(NSString *)getPortalUrl {
    return [self getPortalUrl:nil];
}

+(NSString *)getPortalUrl:(OauthServer *)oauthServer {
    return [NSString stringWithFormat:@"%@%@%@/", [self getFluig:oauthServer], PATHPortal, PATHBody];
}

//URL Padrao utilizada
+(NSString *)getSocialUrl {
    return [self getSocialUrl:nil];
}

+(NSString *)getSocialUrl:(OauthServer *)oauthServer {
    return [NSString stringWithFormat:@"%@%@%@/", [self getFluig:oauthServer], PATHSocial, PATHBody];
}

+(NSString *)getECMUrl{
    return [self getECMUrl:nil];
}
+(NSString *)getBPMUrl{
    return [self getECMUrl:nil];
}

+(NSString *)getBPMUrl:(OauthServer *)oauthServer {
    return [NSString stringWithFormat:@"%@%@%@%@/", [self getFluig:oauthServer], PATHMOBILE, PATHBody, PATHBPM];
}

+(NSString *)getECMUrl:(OauthServer *)oauthServer {
    return [NSString stringWithFormat:@"%@%@%@%@/", [self getFluig:oauthServer], PATHECM, PATHBody, PATHECM];
}

+(NSString *)getPublicApi{
    return [self getECMUrl:nil];
}

+(NSString *)getMobileApi{
    return [self getMobileApi:nil];
}
+(NSString *)getMobileApi:(OauthServer *)oauthServer {
    return [NSString stringWithFormat:@"%@%@%@/", [self getFluig:oauthServer], PATHMOBILE,PATHBody];
}

+(NSString *)getPublicApi:(OauthServer *)oauthServer {
    return [NSString stringWithFormat:@"%@%@/", [self getFluig:oauthServer], PATHPublic];
}

+(NSString *)getFluig {
    return [self getFluig:nil];
}

+(NSString *)getFluig:(OauthServer *)oauthServer{
    if(oauthServer == nil){
        return [[ServerManager getMainServer] adresss];
    }else{
        return [oauthServer adresss];
    }
}


+(NSString *)getFluigCloud {
    return fluigCloud;
}


@end
