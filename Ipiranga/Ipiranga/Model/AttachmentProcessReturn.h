//
//  AttachmentProcessReturn.h
//  Fluig
//
//  Created by Mauricio Mazzocco on 03/09/13.
//  Copyright (c) 2013 TOTVS S.A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Attachment.h"
#import  <UIKit/UIKit.h>
@interface AttachmentProcessReturn : NSObject
@property (assign) int companyId;
@property (assign) int processInstanceId;
@property (assign) int attachmentSequence;
@property (assign) int documentId;
@property (assign) int version;
@property (assign) int originalMovementSequence;
@property (nonatomic, retain) NSString* colleagueId;
@property (nonatomic, retain) NSString* descriptionStr;
@property (nonatomic, retain) NSString* fileName;
@property (nonatomic, retain) NSString* streamControlUrl;
@property (assign) BOOL deleted;
@property (nonatomic, retain) UIImage* image;
@property (nonatomic, retain) NSMutableArray* attachments;
@property (nonatomic, retain) NSString* permission;
@property (assign) BOOL newAttach;
@property (nonatomic, retain) NSString* documentType;
@property (strong) NSData* archive;
@property (nonatomic, retain) NSString* colleagueName;
@property (nonatomic, retain) NSString* createDate;
@property (assign) float size;
@property (assign) long crc;
@property (assign) long long createDateTimestamp;

//Only in cache.
@property (assign) BOOL changed;

+ (AttachmentProcessReturn*)dictToAttachmentProcessReturnWithDict:(NSDictionary*)dict;

- (id)proxyForJson;
@end
