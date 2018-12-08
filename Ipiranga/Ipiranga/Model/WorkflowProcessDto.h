//
//  WorkflowProcessDto.h
//  Social ECM
//
//  Created by Everton Feltrin Pinheiro on 5/27/13.
//  Copyright (c) 2013 TOTVS S.A. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WorkflowProcessDto : NSObject

@property (assign) long companyId;
@property (assign) int processInstanceId;
@property (strong) NSString* processId;
@property (assign) int version;
@property (strong) NSString* requesterId;
@property (strong) NSString* requesterName;
@property (assign) BOOL active;
@property (assign) int attachmentSeqId;
@property (assign) int sourceProcess;
@property (assign) int sourceThreadSequence;
@property (strong) NSString* stateDescription;
@property (strong) NSString* processDescription;
@property (strong) NSString* deadlineDate;
@property (strong) NSString* deadlineText;
@property (strong) NSString* documentDescription;
@property (strong) NSString* colleagueName;
@property (assign) int movementSequence;
@property (assign) int currentMovto;
@property (assign) int mainAttachmentDocumentId;
@property (assign) int mainAttachmentDocumentVersion;
@property (assign) int rowId;
@property (strong) NSString* movementHour;
@property (strong) NSString* startupHour;
@property (strong) NSString* errorMessage;
@property (assign) BOOL mobileReady;
@property (assign) BOOL canCancel;
@property (assign) BOOL canTake;
@property (assign) int stateId;
@property (strong, nonatomic) NSString* url;
@property (strong, nonatomic) NSString* code;
@property (assign) BOOL pagination;
@property (strong, nonatomic) NSMutableArray* relatedDatasets;
- (WorkflowProcessDto*)dictToWorkflowProcessDtoWithDict:(NSDictionary*)dict;

@end
