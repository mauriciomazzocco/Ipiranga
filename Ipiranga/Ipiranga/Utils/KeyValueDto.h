//
//  KeyValueDto.h
//  Social ECM
//
//  Created by Flávio Luiz Maria on 6/4/13.
//  Copyright (c) 2013 TOTVS S.A. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyValueDto : NSObject<NSCoding> {
    NSString *key;
    
    NSString *value;
}

@property (strong) NSString *key;

@property (strong) NSString *value;

-(NSMutableDictionary *)keyValueDtoToDict;

- (KeyValueDto *)dictToKeyValueDtoWithDict:(NSDictionary *)dict;

@end
