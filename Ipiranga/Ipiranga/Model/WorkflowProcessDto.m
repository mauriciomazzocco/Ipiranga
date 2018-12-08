//
//  WorkflowProcessDto.m
//  Social ECM
//
//  Created by Everton Feltrin Pinheiro on 5/27/13.
//  Copyright (c) 2013 TOTVS S.A. All rights reserved.
//

#import "WorkflowProcessDto.h"


@implementation WorkflowProcessDto

@synthesize companyId;
@synthesize processInstanceId;
@synthesize processId;
@synthesize stateId;
@synthesize version;
@synthesize requesterId;
@synthesize requesterName;
@synthesize active;
@synthesize attachmentSeqId;
@synthesize sourceProcess;
@synthesize sourceThreadSequence;
@synthesize stateDescription;
@synthesize processDescription;
@synthesize deadlineDate;
@synthesize deadlineText;
@synthesize documentDescription;
@synthesize colleagueName;
@synthesize movementSequence;
@synthesize currentMovto;
@synthesize mainAttachmentDocumentId;
@synthesize mainAttachmentDocumentVersion;
@synthesize rowId;
@synthesize movementHour;
@synthesize errorMessage;
@synthesize mobileReady;
@synthesize canTake;
@synthesize canCancel;
@synthesize url;
@synthesize code;
@synthesize pagination;
@synthesize relatedDatasets;
@synthesize startupHour;

- (void)encodeWithCoder:(NSCoder*)encoder {

	[encoder encodeObject:[NSNumber numberWithLong:companyId] forKey:@"companyId"];
	[encoder encodeObject:[NSNumber numberWithLong:processInstanceId] forKey:@"processInstanceId"];
	[encoder encodeObject:processId forKey:@"processId"];
	[encoder encodeObject:[NSNumber numberWithLong:version] forKey:@"version"];
	[encoder encodeObject:requesterId forKey:@"requesterId"];
	[encoder encodeObject:requesterName forKey:@"requesterName"];
	[encoder encodeBool:active forKey:@"active"];
	[encoder encodeObject:[NSNumber numberWithLong:attachmentSeqId] forKey:@"attachmentSeqId"];
	[encoder encodeObject:[NSNumber numberWithLong:sourceProcess] forKey:@"sourceProcess"];
	[encoder encodeObject:[NSNumber numberWithLong:sourceThreadSequence] forKey:@"sourceThreadSequence"];
	[encoder encodeObject:stateDescription forKey:@"stateDescription"];
	[encoder encodeObject:processDescription forKey:@"processDescription"];
	[encoder encodeObject:deadlineDate forKey:@"deadlineDate"];
	[encoder encodeObject:deadlineText forKey:@"deadlineText"];
	[encoder encodeObject:documentDescription forKey:@"documentDescription"];
	[encoder encodeObject:colleagueName forKey:@"colleagueName"];
	[encoder encodeObject:[NSNumber numberWithLong:movementSequence] forKey:@"movementSequence"];
    [encoder encodeObject:[NSNumber numberWithLong:currentMovto] forKey:@"currentMovto"];
	[encoder encodeObject:[NSNumber numberWithLong:mainAttachmentDocumentId] forKey:@"mainAttachmentDocumentId"];
	[encoder encodeObject:[NSNumber numberWithLong:mainAttachmentDocumentVersion] forKey:@"mainAttachmentDocumentVersion"];
	[encoder encodeObject:[NSNumber numberWithLong:rowId] forKey:@"rowId"];
	[encoder encodeObject:movementHour forKey:@"movementHour"];
	[encoder encodeObject:movementHour forKey:@"startupHour"];
	[encoder encodeObject:errorMessage forKey:@"errorMessage"];
	[encoder encodeBool:mobileReady forKey:@"mobileReady"];
	[encoder encodeObject:[NSNumber numberWithLong:stateId] forKey:@"stateId"];
	[encoder encodeObject:url forKey:@"url"];
	[encoder encodeObject:code forKey:@"code"];
	[encoder encodeBool:pagination forKey:@"pagination"];
	[encoder encodeObject:relatedDatasets forKey:@"relatedDatasets"];
}

- (id)initWithCoder:(NSCoder*)decoder {
	self = [super init];
	if (self != nil) {

		companyId = [[decoder decodeObjectForKey:@"companyId"] longValue];
		processInstanceId = [[decoder decodeObjectForKey:@"processInstanceId"] intValue];
		processId = [decoder decodeObjectForKey:@"processId"];
		version = [[decoder decodeObjectForKey:@"version"] intValue];
		requesterId = [decoder decodeObjectForKey:@"requesterId"];
		requesterName = [decoder decodeObjectForKey:@"requesterName"];
		active = [decoder decodeBoolForKey:@"active"];
		attachmentSeqId = [[decoder decodeObjectForKey:@"attachmentSeqId"] intValue];
		sourceProcess = [[decoder decodeObjectForKey:@"sourceProcess"] intValue];
		sourceThreadSequence = [[decoder decodeObjectForKey:@"sourceThreadSequence"] intValue];
		stateDescription = [decoder decodeObjectForKey:@"stateDescription"];
		processDescription = [decoder decodeObjectForKey:@"processDescription"];
		deadlineDate = [decoder decodeObjectForKey:@"deadlineDate"];
		deadlineText = [decoder decodeObjectForKey:@"deadlineText"];
		documentDescription = [decoder decodeObjectForKey:@"documentDescription"];
		colleagueName = [decoder decodeObjectForKey:@"colleagueName"];
		movementSequence = [[decoder decodeObjectForKey:@"movementSequence"] intValue];
        currentMovto = [[decoder decodeObjectForKey:@"currentMovto"] intValue];
		mainAttachmentDocumentId = [[decoder decodeObjectForKey:@"mainAttachmentDocumentId"] intValue];
		mainAttachmentDocumentVersion = [[decoder decodeObjectForKey:@"mainAttachmentDocumentVersion"] intValue];
		rowId = [[decoder decodeObjectForKey:@"rowId"] intValue];
		movementHour = [decoder decodeObjectForKey:@"movementHour"];
		startupHour = [decoder decodeObjectForKey:@"startupHour"];
		errorMessage = [decoder decodeObjectForKey:@"errorMessage"];
		mobileReady = [decoder decodeBoolForKey:@"mobileReady"];
		canTake = [decoder decodeBoolForKey:@"canTake"];
		canCancel = [decoder decodeBoolForKey:@"canCancel"];
		stateId = [[decoder decodeObjectForKey:@"stateId"] intValue];
		url = [decoder decodeObjectForKey:@"url"];
		code = [decoder decodeObjectForKey:@"code"];
		pagination = [decoder decodeBoolForKey:@"pagination"];
		relatedDatasets = [decoder decodeObjectForKey:@"relatedDatasets"];
	}

	return self;
}

- (WorkflowProcessDto*)dictToWorkflowProcessDtoWithDict:(NSDictionary*)dict {

	WorkflowProcessDto* workflowProcessDto = [[WorkflowProcessDto alloc] init];

	if ([dict objectForKey:@"companyId"] != [NSNull null]) {
		workflowProcessDto.companyId = [[dict objectForKey:@"companyId"] longValue];
	}

	if ([dict objectForKey:@"processInstanceId"] != [NSNull null]) {
		workflowProcessDto.processInstanceId = [[dict objectForKey:@"processInstanceId"] intValue];
	}

	if ([dict objectForKey:@"processId"] != [NSNull null]) {
		workflowProcessDto.processId = [dict objectForKey:@"processId"];
	}

	if ([dict objectForKey:@"version"] != [NSNull null]) {
		workflowProcessDto.version = [[dict objectForKey:@"version"] intValue];
	}

	if ([dict objectForKey:@"stateId"] != [NSNull null]) {
		workflowProcessDto.stateId = [[dict objectForKey:@"stateId"] intValue];
	}

	if ([dict objectForKey:@"requesterId"] != [NSNull null]) {
		workflowProcessDto.requesterId = [dict objectForKey:@"requesterId"];
	}

	if ([dict objectForKey:@"requesterName"] != [NSNull null]) {
		workflowProcessDto.requesterName = [dict objectForKey:@"requesterName"];
	}

	if ([dict objectForKey:@"active"] != [NSNull null]) {
		workflowProcessDto.active = [[dict objectForKey:@"active"] boolValue];
	}
	if ([dict objectForKey:@"canTake"] != [NSNull null]) {
		workflowProcessDto.canTake = [[dict objectForKey:@"canTake"] boolValue];
	}
	if ([dict objectForKey:@"canCancel"] != [NSNull null]) {
		workflowProcessDto.canCancel = [[dict objectForKey:@"canCancel"] boolValue];
	}

	if ([dict objectForKey:@"attachmentSeqId"] != [NSNull null]) {
		workflowProcessDto.attachmentSeqId = [[dict objectForKey:@"attachmentSeqId"] intValue];
	}

	if ([dict objectForKey:@"sourceProcess"] != [NSNull null]) {
		workflowProcessDto.sourceProcess = [[dict objectForKey:@"sourceProcess"] intValue];
	}

	if ([dict objectForKey:@"sourceThreadSequence"] != [NSNull null]) {
		workflowProcessDto.sourceThreadSequence = [[dict objectForKey:@"sourceThreadSequence"] intValue];
	}

	if ([dict objectForKey:@"stateDescription"] != [NSNull null]) {
		workflowProcessDto.stateDescription = [dict objectForKey:@"stateDescription"];
	}

	if ([dict objectForKey:@"processDescription"] != [NSNull null]) {
		workflowProcessDto.processDescription = [dict objectForKey:@"processDescription"];
	}

	if ([dict objectForKey:@"deadlineDate"] != [NSNull null]) {
		workflowProcessDto.deadlineDate = [dict objectForKey:@"deadlineDate"];

		@try {
			NSString* temp = [dict objectForKey:@"deadlineDate"];

		
		}
		@catch (NSException* exception) {

		}
		@finally {
		}
	}

	if ([dict objectForKey:@"deadlineText"] != [NSNull null]) {
		workflowProcessDto.deadlineText = [dict objectForKey:@"deadlineText"];
	}

	if ([dict objectForKey:@"documentDescription"] != [NSNull null]) {
		workflowProcessDto.documentDescription = [dict objectForKey:@"documentDescription"];
	}

	if ([dict objectForKey:@"colleagueName"] != [NSNull null]) {
		workflowProcessDto.colleagueName = [dict objectForKey:@"colleagueName"];
	}

	if ([dict objectForKey:@"movementSequence"] != [NSNull null]) {
		workflowProcessDto.movementSequence = [[dict objectForKey:@"movementSequence"] intValue];
	}
    
    if ([dict objectForKey:@"currentMovto"] != [NSNull null]) {
        workflowProcessDto.currentMovto = [[dict objectForKey:@"currentMovto"] intValue];
    }

	if ([dict objectForKey:@"mainAttachmentDocumentId"] != [NSNull null]) {
		workflowProcessDto.mainAttachmentDocumentId = [[dict objectForKey:@"mainAttachmentDocumentId"] intValue];
	}

	if ([dict objectForKey:@"mainAttachmentDocumentVersion"] != [NSNull null]) {
		workflowProcessDto.mainAttachmentDocumentVersion = [[dict objectForKey:@"mainAttachmentDocumentVersion"] intValue];
	}

	if ([dict objectForKey:@"rowId"] != [NSNull null]) {
		workflowProcessDto.rowId = [[dict objectForKey:@"rowId"] intValue];
	}

	if ([dict objectForKey:@"movementHour"] != [NSNull null]) {
		workflowProcessDto.movementHour = [dict objectForKey:@"movementHour"];
	}

	if ([dict objectForKey:@"startupHour"] != [NSNull null]) {
		workflowProcessDto.startupHour = [dict objectForKey:@"startupHour"];
	}

	if ([dict objectForKey:@"errorMessage"] != [NSNull null]) {
		workflowProcessDto.errorMessage = [dict objectForKey:@"errorMessage"];
	}


	if ([dict objectForKey:@"mobileReady"] != [NSNull null]) {
		workflowProcessDto.mobileReady = [[dict objectForKey:@"mobileReady"] boolValue];
	}

	if ([dict objectForKey:@"url"] != [NSNull null]) {
		workflowProcessDto.url = [dict objectForKey:@"url"];
	}

	if ([dict objectForKey:@"code"] != [NSNull null]) {
		workflowProcessDto.code = [dict objectForKey:@"code"];
	}

	if ([dict objectForKey:@"relatedDatasets"] != [NSNull null]) {
		workflowProcessDto.relatedDatasets = [dict objectForKey:@"relatedDatasets"];
	}

	return workflowProcessDto;
}

@end
