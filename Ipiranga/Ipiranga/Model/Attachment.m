//
//  Attachment.m
//  Fluig
//
//  Created by Mauricio Mazzocco on 03/09/13.
//  Copyright (c) 2013 TOTVS S.A. All rights reserved.
//

#import "Attachment.h"

@implementation Attachment
@synthesize attach,descriptor,editing,filecontent,fileName,fileSelected,fileSize,fullPatch,iconPath,mobile,principal;

-(Attachment *)dictToAttachmentWithDict:(NSDictionary *)dict{
    Attachment *attachment = [[Attachment alloc] init];
    if ([dict objectForKey:@"fileName"] != [NSNull null]) {
        attachment.fileName = [dict objectForKey:@"fileName"];
    }
    
    if ([dict objectForKey:@"fullPatch"] != [NSNull null]) {
        attachment.fullPatch = [dict objectForKey:@"fullPatch"];
    }
    
    if ([dict objectForKey:@"fileSize"] != [NSNull null]) {
        attachment.fileSize = [[dict objectForKey:@"fileSize"] longValue];
    }

    if ([dict objectForKey:@"principal"] != [NSNull null]) {
        attachment.principal = [[dict objectForKey:@"principal"] boolValue];
    }
    
    if ([dict objectForKey:@"attach"] != [NSNull null]) {
        attachment.attach = [[dict objectForKey:@"attach"] boolValue];
    }
    if ([dict objectForKey:@"iconPath"] != [NSNull null]) {
        attachment.iconPath = [dict objectForKey:@"iconPath"];
    }
    
    if ([dict objectForKey:@"descriptor"] != [NSNull null]) {
        attachment.descriptor = [[dict objectForKey:@"descriptor"] boolValue];
    }
    
    if ([dict objectForKey:@"fileSelected"] != [NSNull null]) {
        attachment.fileSelected = [dict objectForKey:@"fileSelected"];
    }

    if ([dict objectForKey:@"editing"] != [NSNull null]) {
        attachment.editing = [[dict objectForKey:@"editing"] boolValue];
    }

    if ([dict objectForKey:@"filecontent"] != [NSNull null]) {
        attachment.filecontent = [dict objectForKey:@"filecontent"];
    }

    if ([dict objectForKey:@"mobile"] != [NSNull null]) {
        attachment.mobile = [[dict objectForKey:@"mobile"] boolValue];
    }
    
    return attachment;
}

- (id) proxyForJson {
    
    if (fullPatch) {
        return @{ @"fileName": self.fileName,
                  @"fileSize": @(self.fileSize),
                  @"fullPatch": self.fullPatch,
                  @"mobile": @(self.mobile)
                };
    } else {
        return @{ @"fileName": self.fileName
                };
    }
}

- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.fileName forKey:@"fileName"];
    [encoder encodeObject:self.fullPatch forKey:@"fullPatch"];
    [encoder encodeInteger:self.fileSize forKey:@"fileSize"];
    [encoder encodeBool:self.principal forKey:@"principal"];
    [encoder encodeBool:self.attach forKey:@"attach"];
    [encoder encodeObject:self.iconPath forKey:@"iconPath"];
    [encoder encodeBool:self.descriptor forKey:@"descriptor"];
    [encoder encodeObject:self.fileSelected forKey:@"fileSelected"];
    [encoder encodeBool:self.editing forKey:@"editing"];
    [encoder encodeObject:self.filecontent forKey:@"filecontent"];
    [encoder encodeBool:self.mobile forKey:@"mobile"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if( self != nil ){
        self.fileName = [decoder decodeObjectForKey:@"fileName"];
        self.fullPatch = [decoder decodeObjectForKey:@"fullPatch"];
        self.fileSize = [decoder decodeIntForKey:@"fileSize"];
        self.principal = [decoder decodeBoolForKey:@"principal"];
        self.attach = [decoder decodeBoolForKey:@"attach"];
        self.iconPath = [decoder decodeObjectForKey:@"iconPath"];
        self.descriptor = [decoder decodeBoolForKey:@"descriptor"];
        self.fileSelected = [decoder decodeObjectForKey:@"fileSelected"];
        self.editing = [decoder decodeBoolForKey:@"editing"];
        self.filecontent = [decoder decodeObjectForKey:@"filecontent"];
        self.mobile = [decoder decodeBoolForKey:@"mobile"];
    }
    
    return self;
}


@end
