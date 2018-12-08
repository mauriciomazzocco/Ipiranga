//
//  FluigUtils.h
//  Fluig
//
//  Created by imac4gb on 8/22/13.
//  Copyright (c) 2013 TOTVS S.A. All rights reserved.
//

#import <Foundation/Foundation.h>



enum SyncStatus {
	OUTBOX_STOPPED = 0,
	OUTBOX_SYNCHRONIZING = 1,
	OUTBOX_ERROR = 2
};

enum TasksWorkflowType {
	START_TASK = 0,
	OPEN_TASK = 1,
	MY_REQUESTS_TASK = 4,
	DOCUMENTS_ON_DEMAND = 6,
	DOCUMENTS_TO_APPROVE = 7,
	GROUP_TASK = 10,
	ROLE_TASK = 11,
    UNDER_MY_MANAGEMENT = 12,
	NOTIFICATION = 97,
	OUTBOX = 98,
	DRAFT = 99,
};

enum ConnectionType {
	COMMUNITIES = 0,
	FOLLOWERS = 1,
	FOLLOWING = 2
};

enum LeftMenuType {

	HomeMenu,
	CentralTaskMenu,
	ProcessMenu,
	DocumentsMenu,
	PagesMenu,
	SocialMenu,
	CommunitiesMenu,
	FollowingMenu,
	DraftsMenu,

	LeftMenuTotalItems
};

enum SocialPermission {
	Comment = 1001,
	Like = 1002,
	Publish = 1007,

	//    not supported by mobile
	NotifyPost = 1003,
	NotifyCommunity = 1004,
	Share = 1005,
	Denounce = 1006,
	AdministerUser = 1008,
	AdministerModerator = 1009,
	ProfileEdit = 1010,

};

#define kSocialPermissionArray @"COMMENT", @"LIKE", @"NOTIFY_POST", @"NOTIFY_COMMUNITY", @"SHARE", @"DENOUNCE", @"PUBLISH", @"ADMINISTER_USER", @"ADMINISTER_MODERATOR", @"PROFILE_EDIT", nil

enum DocumentsSort {
	DOCUMENT_DESCRIPTION_ASC = 1,
	DOCUMENT_DESCRIPTION_DESC = 2,
	DOCUMENT_UPDATE_DATE_ASC = 3,
	DOCUMENT_UPDATE_DATE_DESC = 4
};

enum DocumentVisualizationType {
	DOCUMENT_VIEW = 1,
	DOCUMENT_APPROVE = 2
};

enum DocumentViewRightMenuCellType {
	CELL_NEW_FOLDER = 0,
	CELL_NEW_DOCUMENT = 1,
	CELL_RENAME = 2,
	CELL_REMOVE = 3,
	CELL_DETAIL = 4,
	CELL_VIEW_DOCUMENT = 5
};

enum DraftType {
	POST_NEW = 0,
	POST_COMMENT = 1,
	POST_COMMUNITY = 2

};

@interface FluigUtils : NSObject

+ (NSString*)socialPermissionEnumToString:(enum SocialPermission)enumVal;
+ (enum SocialPermission)socialPermissionStringToEnum:(NSString*)strVal;
+ (NSString*)getImageDefaultName;
+ (UIImage*)getFavIcon:(BOOL)isFavorite;
+ (UIImage*)getIcon:(NSString*)fileName;
+ (NSString*)extension:(NSString*)phisicalFile;
+ (NSString*)transformedValue:(id)value;
+ (NSString*)convertBooleanToString:(BOOL)isTrue;
+ (NSString*)formatSize:(double)size;
+ (NSString*)getDateFromTime:(long long)time;
+ (void)openActionSheet:(UIActionSheet*)actionSheet where:(UIView*)view;
+ (void)openViewController:(UIViewController*)currentView to:(UIViewController*)viewController eAnimated:(BOOL)animated;
+ (UIImage*)getIconReduzido:(NSString*)fileName;
+ (BOOL)refreshTableView;
+ (void)setRefreshTableView:(BOOL)refresh;
+ (void)setRightMenuPosition:(UITableView*)tableView;
+ (BOOL)isConnected;
+ (NSMutableDictionary*)getDemoKeysMap;
+ (BOOL)isOpenNotification:(NSString*)eventKey;
+ (BOOL)isShowAlertNotification:(NSString*)eventKey;
+ (BOOL)isNoActionNotification:(NSString*)eventKey;
+ (NSString*)getServerAddress:(NSString*)link;
+ (NSString*)replaceString:(NSString*)stringToReplace;
+ (NSMutableDictionary*)getStoryBoardAndControllerInitialViewController;
+ (NSMutableDictionary*)getFluigNavigationAndControllerInitialViewController:(BOOL)showAlerts;
+ (void)saveInCacheServerConfig:(ServerConfigReturn*)server withAddress:(NSString*)address;
+ (NSMutableDictionary*)getAllServerConfig:(NSUserDefaults*)userDefaults;
+ (ServerConfigReturn*)getServerConfigWithServer:(OauthServer*)oauthServer;
+ (NSString*)getRelativeDateFromTime:(NSTimeInterval)time;
+ (id)objectOrNSNull:(id)object;
+ (NSObject*)configureStandardHomePage;
+(void)verifyAndAtualizeServerConfigWithServer:(OauthServer *)oauthServer;
+(NSString *)getTitleHeader:(enum SearchType)type;
+(void)joinConversation:(NSString*)link serverAddress:(NSString*)serverAddress;

@end
