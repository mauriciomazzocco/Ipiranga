//
//  AttachmentProcessReturn.m
//  Fluig
//
//  Created by Mauricio Mazzocco on 03/09/13.
//  Copyright (c) 2013 TOTVS S.A. All rights reserved.
//

#import "AttachmentProcessReturn.h"

@implementation AttachmentProcessReturn
@synthesize originalMovementSequence, permission, processInstanceId, version, newAttach, documentType;
@synthesize documentId, descriptionStr, deleted, companyId, colleagueId, attachmentSequence, attachments;
@synthesize fileName, colleagueName, createDate, size, crc, archive, createDateTimestamp, changed,streamControlUrl, image;

- (void)encodeWithCoder:(NSCoder*)encoder {

	[encoder encodeInt:documentId forKey:@"documentId"];
	[encoder encodeInt:version forKey:@"version"];
	[encoder encodeObject:descriptionStr forKey:@"description"];
	[encoder encodeObject:fileName forKey:@"fileName"];
	[encoder encodeBool:deleted forKey:@"deleted"];
	[encoder encodeBool:changed forKey:@"changed"];
	[encoder encodeObject:attachments forKey:@"attachments"];
	[encoder encodeObject:permission forKey:@"permission"];
	[encoder encodeBool:newAttach forKey:@"newAttach"];
	[encoder encodeObject:archive forKey:@"archive"];
	[encoder encodeObject:colleagueName forKey:@"colleagueName"];
	[encoder encodeObject:createDate forKey:@"createDate"];
	[encoder encodeFloat:size forKey:@"size"];
	[encoder encodeInteger:crc forKey:@"crc"];
	[encoder encodeObject:documentType forKey:@"documentType"];
	[encoder encodeObject:colleagueId forKey:@"colleagueId"];
	[encoder encodeInt:originalMovementSequence forKey:@"originalMovementSequence"];
	[encoder encodeInt:processInstanceId forKey:@"processInstanceId"];
	[encoder encodeInt:companyId forKey:@"companyId"];
	[encoder encodeInt:attachmentSequence forKey:@"attachmentSequence"];
	[encoder encodeInt64:createDateTimestamp forKey:@"createDateTimestamp"];
    [encoder encodeObject:streamControlUrl forKey:@"streamControlUrl"];
}

- (id)initWithCoder:(NSCoder*)decoder {
	self = [super init];
	if (self != nil) {

		documentId = [decoder decodeIntForKey:@"documentId"];
		version = [decoder decodeIntForKey:@"version"];
		descriptionStr = [decoder decodeObjectForKey:@"description"];
		fileName = [decoder decodeObjectForKey:@"fileName"];
		deleted = [decoder decodeBoolForKey:@"deleted"];
		attachments = [decoder decodeObjectForKey:@"attachments"];
		permission = [decoder decodeObjectForKey:@"permission"];
		newAttach = [decoder decodeBoolForKey:@"newAttach"];
		archive = [decoder decodeObjectForKey:@"archive"];
		colleagueName = [decoder decodeObjectForKey:@"colleagueName"];
		createDate = [decoder decodeObjectForKey:@"createDate"];
		size = [decoder decodeFloatForKey:@"size"];
		crc = [decoder decodeIntegerForKey:@"crc"];
		documentType = [decoder decodeObjectForKey:@"documentType"];
		colleagueId = [decoder decodeObjectForKey:@"colleagueId"];
		originalMovementSequence = [decoder decodeIntForKey:@"originalMovementSequence"];
		processInstanceId = [decoder decodeIntForKey:@"processInstanceId"];
		companyId = [decoder decodeIntForKey:@"companyId"];
		attachmentSequence = [decoder decodeIntForKey:@"attachmentSequence"];
		createDateTimestamp = [decoder decodeInt64ForKey:@"createDateTimestamp"];
		changed = [decoder decodeBoolForKey:@"changed"];
        streamControlUrl = [decoder decodeObjectForKey:@"streamControlUrl"];
	}

	return self;
}

+ (AttachmentProcessReturn*)dictToAttachmentProcessReturnWithDict:(NSDictionary*)dict {

	AttachmentProcessReturn* attachmentProcessReturn = [[AttachmentProcessReturn alloc] init];

	if ([dict objectForKey:@"companyId"] != [NSNull null]) {
		attachmentProcessReturn.companyId = [[dict objectForKey:@"companyId"] intValue];
	}

	if ([dict objectForKey:@"processInstanceId"] != [NSNull null]) {
		attachmentProcessReturn.processInstanceId = [[dict objectForKey:@"processInstanceId"] intValue];
	}

	if ([dict objectForKey:@"attachmentSequence"] != [NSNull null]) {
		attachmentProcessReturn.attachmentSequence = [[dict objectForKey:@"attachmentSequence"] intValue];
	}

	if ([dict objectForKey:@"documentId"] != [NSNull null]) {
		attachmentProcessReturn.documentId = [[dict objectForKey:@"documentId"] intValue];
	}

	if ([dict objectForKey:@"version"] != [NSNull null]) {
		attachmentProcessReturn.version = [[dict objectForKey:@"version"] intValue];
	}

	if ([dict objectForKey:@"originalMovementSequence"] != [NSNull null]) {
		attachmentProcessReturn.originalMovementSequence = [[dict objectForKey:@"originalMovementSequence"] intValue];
	}

	if ([dict objectForKey:@"colleagueId"] != [NSNull null]) {
		attachmentProcessReturn.colleagueId = [dict objectForKey:@"colleagueId"];
	}

	if ([dict objectForKey:@"description"] != [NSNull null]) {
		attachmentProcessReturn.descriptionStr = [dict objectForKey:@"description"];
	}

	if ([dict objectForKey:@"fileName"] != [NSNull null]) {
		attachmentProcessReturn.fileName = [dict objectForKey:@"fileName"];
	}

	if ([dict objectForKey:@"deleted"] != [NSNull null]) {
		attachmentProcessReturn.deleted = [[dict objectForKey:@"deleted"] boolValue];
	}
    
    if ([dict objectForKey:@"streamControlUrl"] != [NSNull null]) {
        attachmentProcessReturn.streamControlUrl = [dict objectForKey:@"streamControlUrl"];
    }

    

	if ([dict objectForKey:@"attachments"] != [NSNull null]) {
		NSArray* arData = [dict objectForKey:@"attachments"];
		Attachment* data = [[Attachment alloc] init];
		attachmentProcessReturn.attachments = [[NSMutableArray alloc] init];

		for (NSDictionary* localDict in arData) {
			[attachmentProcessReturn.attachments addObject:[data dictToAttachmentWithDict:localDict]];
		}
	}

	if ([dict objectForKey:@"permission"] != [NSNull null]) {
		attachmentProcessReturn.permission = [dict objectForKey:@"permission"];
	}

	if ([dict objectForKey:@"newAttach"] != [NSNull null]) {
		attachmentProcessReturn.newAttach = [[dict objectForKey:@"newAttach"] boolValue];
	}

	if ([dict objectForKey:@"documentType"] != [NSNull null]) {
		attachmentProcessReturn.documentType = [dict objectForKey:@"documentType"];
	}

	if ([dict objectForKey:@"colleagueName"] != [NSNull null]) {
		attachmentProcessReturn.colleagueName = [dict objectForKey:@"colleagueName"];
	}

	if ([dict objectForKey:@"createDate"] != [NSNull null]) {
		attachmentProcessReturn.createDate = [dict objectForKey:@"createDate"];

		@try {
			if (![attachmentProcessReturn.createDate isKindOfClass:[NSDecimalNumber class]] && ![attachmentProcessReturn.createDate isKindOfClass:[NSNumber class]]) {
				NSString* temp = [dict objectForKey:@"createDate"];

			
			} else {
				NSDecimalNumber* decimal = [dict objectForKey:@"createDate"];
				attachmentProcessReturn.createDate = [NSString stringWithFormat:@"%@", decimal];
			}
		}
		@catch (NSException* exception) {

		}
		@finally {
		}
	}
	if ([dict objectForKey:@"createDateTimestamp"] != [NSNull null]) {
		long long dateTimeStamp = [[dict objectForKey:@"createDateTimestamp"] longLongValue];
		if (dateTimeStamp > 0) {
			NSDate* date = [NSDate dateWithTimeIntervalSince1970:(dateTimeStamp / 1000)];
			NSDateFormatter* df = [[NSDateFormatter alloc] init];
			[df setDateFormat:@"dd/MM/yyyy"];
			;
			attachmentProcessReturn.createDate = [df stringFromDate:date];
		}
	}

	if ([dict objectForKey:@"size"] != [NSNull null]) {
		attachmentProcessReturn.size = [[dict objectForKey:@"size"] floatValue];
	}

	if ([dict objectForKey:@"crc"] != [NSNull null]) {
		attachmentProcessReturn.crc = [[dict objectForKey:@"crc"] intValue];
	}

	if ([dict objectForKey:@"documentType"] != [NSNull null]) {
		attachmentProcessReturn.documentType = [dict objectForKey:@"documentType"];
	}

	if ([dict objectForKey:@"colleagueId"] != [NSNull null]) {
		attachmentProcessReturn.colleagueId = [dict objectForKey:@"colleagueId"];
	}

	if ([dict objectForKey:@"originalMovementSequence"] != [NSNull null]) {
		attachmentProcessReturn.originalMovementSequence = [[dict objectForKey:@"originalMovementSequence"] intValue];
	}

	if ([dict objectForKey:@"processInstanceId"] != [NSNull null]) {
		attachmentProcessReturn.processInstanceId = [[dict objectForKey:@"processInstanceId"] intValue];
	}

	if ([dict objectForKey:@"companyId"] != [NSNull null]) {
		attachmentProcessReturn.companyId = [[dict objectForKey:@"companyId"] intValue];
	}

	if ([dict objectForKey:@"attachmentSequence"] != [NSNull null]) {
		attachmentProcessReturn.attachmentSequence = [[dict objectForKey:@"attachmentSequence"] intValue];
	}

	return attachmentProcessReturn;
}


- (id)proxyForJson {

	if (newAttach) {
		return @{ @"documentId" : @(documentId),
			@"version" : @(version),
			@"description" : descriptionStr,
			@"fileName" : fileName,
			@"deleted" : @(deleted),
			@"attachments" : attachments,
			@"newAttach" : @(newAttach),
			@"documentType" : documentType
		};
	}

	return @{ @"attachmentSequence" : @(attachmentSequence),
		@"attachments" : attachments,
		@"colleagueId" : colleagueId,
		@"companyId" : @(companyId),
		@"deleted" : @(deleted),
		@"description" : descriptionStr,
		@"documentId" : @(documentId),
		@"documentType" : documentType,
		@"fileName" : fileName,
		@"newAttach" : @(newAttach),
		@"originalMovementSequence" : @(originalMovementSequence),
		@"permission" : permission,
		@"processInstanceId" : @(processInstanceId),
		@"version" : @(version),
		@"companyId" : @(companyId),
		@"crc" : @(crc),
        @"streamControlUrl" : streamControlUrl
	};
}

- (id)copyWithZone:(NSZone*)zone {
	AttachmentProcessReturn* attachmentCopy = [[AttachmentProcessReturn allocWithZone:zone] init];

	attachmentCopy.attachmentSequence = attachmentSequence;
	attachmentCopy.attachments = attachments;
	attachmentCopy.colleagueId = colleagueId;
	attachmentCopy.companyId = companyId;
	attachmentCopy.deleted = deleted;
	attachmentCopy.descriptionStr = descriptionStr;
	attachmentCopy.documentId = documentId;
	attachmentCopy.documentType = documentType;
	attachmentCopy.fileName = fileName;
	attachmentCopy.newAttach = newAttach;
	attachmentCopy.originalMovementSequence = originalMovementSequence;
	attachmentCopy.permission = permission;
	attachmentCopy.processInstanceId = processInstanceId;
	attachmentCopy.version = version;
	attachmentCopy.colleagueName = colleagueName;
	attachmentCopy.createDate = createDate;
	attachmentCopy.size = size;
	attachmentCopy.crc = crc;
    attachmentCopy.streamControlUrl = streamControlUrl;
	return attachmentCopy;
}

@end
