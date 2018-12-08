//
//  Attachment.h
//  Fluig
//
//  Created by Mauricio Mazzocco on 03/09/13.
//  Copyright (c) 2013 TOTVS S.A. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Attachment : NSObject
@property (nonatomic,retain) NSString *fileName;
@property (nonatomic,retain) NSString *fullPatch;
@property (assign) long fileSize;
@property (assign) BOOL principal;
@property (assign) BOOL attach;
@property (nonatomic,retain) NSString *iconPath;
@property (assign) BOOL descriptor;
@property (nonatomic,retain) Attachment *fileSelected;
@property (assign) BOOL editing;
@property (nonatomic,retain) NSMutableData *filecontent;
@property (assign) BOOL mobile;

-(Attachment *)dictToAttachmentWithDict:(NSDictionary *)dict;
- (id)proxyForJson;
@end
