//
//  FluigUtils.m
//  Fluig
//
//  Created by imac4gb on 8/22/13.
//  Copyright (c) 2013 TOTVS S.A. All rights reserved.
//

#import "FluigUtils.h"
#import "USAdditions.h"
#import "Reachability.h"
#import "WCMRest.h"
#import "TenantReturn.h"
#import "StartScreen.h"
#import "WidgetsViewController.h"
#import "HomeContainerViewController.h"
#import "TasksFullViewController.h"
#import "TimelineViewController.h"
#import "DocumentsViewController.h"

static BOOL refreshTable;
static NSArray* arrayShowAlert;
static NSArray* arrayOpen;
static NSArray* arrayNoAction;

@implementation FluigUtils

+ (BOOL)isShowAlertNotification:(NSString*)eventKey {

	if (!arrayShowAlert) {
		arrayShowAlert = [[NSArray alloc] initWithObjects:@"ARCHIVED_DENOUNCE", @"NEW_TASK_POOL_ROLE_TO_SUBSTITUTE", @"NEW_TASK_POOL_GROUP_TO_SUBSTITUTE", @"PROCESS_NEW_STATE_TO_REQUESTER_SUBSTITUTE", @"PROCESS_NEW_STATE_TO_REQUESTER", @"TASK_WILL_EXPIRE_TO_SUBSTITUTE", @"TASK_WILL_EXPIRE_TO_REQUESTER_SUBSTITUTE", @"TASK_WILL_EXPIRE_POOL_ROLE_TO_SUBSTITUTE", @"TASK_WILL_EXPIRE_POOL_GROUP_TO_SUBSTITUTE", @"TASK_WILL_EXPIRE_CONSENSUS_TO_SUBSTITUTE", @"OVERDUE_TASK_USER_RESQUESTED_TO_SUBSTITUTE", @"OVERDUE_TASK_USER_RESPONSIBLE_TO_SUBSTITUTE", @"OVERDUE_TASK_CONSENSUS_TO_SUBSTITUTE",  @"OVERDUE_TASK_TO_ROLE_TO_SUBSTITUTE", @"OVERDUE_TASK_TO_GROUP_TO_SUBSTITUTE", nil];
	}

	return [arrayShowAlert containsObject:eventKey];
}

+ (BOOL)isOpenNotification:(NSString*)eventKey {

	if (!arrayOpen) {
        arrayOpen = [[NSArray alloc] initWithObjects:@"REVOKED_DENOUNCE", @"DENOUNCE", @"DENOUNCED_CONTENT", @"FOLLOW_REQUEST", @"FOLLOW_REQUEST_ACCEPTED", @"PARTICIPATION_REQUEST", @"LIKE", @"SHARE", @"PARTICIPATION_INFO", @"POST_COMMUNITY_IS_MODERATOR", @"MENTION", @"MENTION_COMMUNITY", @"BLACKLIST_DENOUNCE", @"WATCH", @"WATCH_COMMENT", @"DOCUMENT_APPROVAL_PENDING", @"DOCUMENT_APPROVED", @"DOCUMENT_GROUPED_APPROVED", @"DOCUMENT_REPROVED", @"NEW_DOCUMENT_SUBJECT_INTEREST", @"NEW_DOCUMENT_VERSION_SUBJECT_INTEREST", @"DOCUMENT_UPDATED_SUBJECT_INTEREST", @"DOCUMENT_YOUR_RESPONSABILITY_WILL_EXPIRE", @"DOCUMENT_READING_REQUEST", @"DOCUMENT_WATCH_MODIFY_CONTENT", @"NEW_TASK", @"NEW_TASK_POOL_ROLE", @"NEW_TASK_POOL_GROUP", @"TASK_POOL_GROUP_ASSUMED", @"TASK_POOL_ROLE_ASSUMED", @"TASK_AUTO_COMPLETED", @"CONSENSUS_TASK_AUTO_COMPLETED", @"TASK_WILL_EXPIRE", @"TASK_WILL_EXPIRE_TO_REQUESTER", @"TASK_WILL_EXPIRE_POOL_ROLE", @"TASK_WILL_EXPIRE_POOL_GROUP", @"TASK_WILL_EXPIRE_TO_MANAGER", @"TASK_WILL_EXPIRE_CONSENSUS", @"OVERDUE_TASK_USER_RESQUESTED", @"OVERDUE_TASK_USER_RESPONSIBLE", @"OVERDUE_TASK_TO_ROLE", @"OVERDUE_TASK_TO_GROUP", @"OVERDUE_TASK_TO_MANAGER", @"OVERDUE_TASK_CONSENSUS", @"FORM_CREATION",@"PROCESS_NEW_STATE_TO_MANAGER", @"PROCESS_NEW_STATE_TO_MANAGER_SUBSTITUTE",@"NEW_COMPLEMENT_MANAGER", @"NEW_ATTACHMENT_MANAGER", @"NEW_COMPLEMENT_MANAGER_TO_SUBSTITUTE",@"NEW_ATTACHMENT_MANAGER_TO_SUBSTITUTE", @"UPDATE_ATTACHMENT_MANAGER",
            @"UPDATE_ATTACHMENT_MANAGER_TO_SUBSTITUTE",@"TASK_WILL_EXPIRE_TO_MANAGER_SUBSTITUTE", @"OVERDUE_TASK_TO_MANAGER_TO_SUBSTITUTE", nil];
	}

	return [arrayOpen containsObject:eventKey];
}

+ (BOOL)isNoActionNotification:(NSString*)eventKey {
	if (!arrayNoAction) {
		arrayNoAction = [[NSArray alloc] initWithObjects:@"DOCUMENT_GROUPED_REPROVED", @"DOCUMENT_VERSION_REMOVED", @"DOCUMENT_REMOVED_SUBJECT_INTEREST", @"DOCUMENT_ALL_VERSION_REMOVED", @"FOLDER_REMOVED_SUBJECT_INTEREST", @"DOCUMENT_VERSION_REMOVED_YOU_APPROVED", @"TASK_AUTO_COMPLETED_TO_SUBSTITUTE", @"CONSENSUS_TASK_AUTO_COMPLETED_TO_SUBSTITUTE", @"PROCESS_CANCELED", @"PROCESS_CANCELED_TO_SUBSTITUTE", @"PROCESS_SEARCH_RESULT_PUBLISHED", @"PROCESS_SEARCH_ERROR", @"INDEX_PROCESS_FINISHED", @"DOCUMENT_MEETING_ENDED", @"PROCESS_COMPLETED_TO_MANAGER", @"PROCESS_COMPLETED_TO_MANAGER_SUBSTITUTE" , nil];
	}

	return [arrayNoAction containsObject:eventKey];
}

+ (NSString*)getServerAddress:(NSString*)link {
	NSString* linkTenant = [FluigUtils replaceString:link];
	NSString* stringWithHttp = @"";

	if ([link contains:@"//"]) {
		stringWithHttp = [link substringFromIndex:0 toIndex:[link indexOf:@"//"] + 2];
	}
	int index = [linkTenant indexOf:@"/"];

	if (index != -1) {
		linkTenant = [linkTenant substringFromIndex:0 toIndex:index];
	}

	return [NSString stringWithFormat:@"%@%@", stringWithHttp, linkTenant];
}

+ (NSString*)replaceString:(NSString*)stringToReplace {
	if (!stringToReplace) {
		return @"";
	}

	if (!stringToReplace) {
		return @"";
	}
	NSString* stringFormated = [[[[stringToReplace replace:@"https://" withString:@""] replace:@"http://" withString:@""] replace:@"%20" withString:@" "] lowercaseString];

	return stringFormated;
}

+ (UIImage*)getFavIcon:(BOOL)isFavorite {
	NSString* imageName = isFavorite ? @"favorito_on" : @"favorito_off_fundoclaro";

	return [UIImage imageNamed:imageName];
}

+ (NSString*)convertBooleanToString:(BOOL)isTrue {
	return isTrue ? @"true" : @"false";
}

+ (UIImage*)getIcon:(NSString*)fileName {

	NSString* extension;
	@try {
		extension = [self extension:fileName];
	} @catch (NSException* e) {
		return [UIImage imageNamed:@"ico_generico"];
	}
	NSString* strImage = [NSString stringWithFormat:@"ico_%@", extension];

	if (![UIImage imageNamed:strImage]) {
		strImage = @"ico_generico";
	}

	return [UIImage imageNamed:strImage];
}

+ (void)setRefreshTableView:(BOOL)refresh {
	refreshTable = refresh;
}

+ (BOOL)refreshTableView {
	return refreshTable;
}

+ (UIImage*)getIconReduzido:(NSString*)fileName {

	NSString* extension;
	@try {
		extension = [self extension:fileName];
	} @catch (NSException* e) {
		return [UIImage imageNamed:@"ico_generico_reduzido"];
	}
	NSString* strImage = [NSString stringWithFormat:@"ico_%@_reduzido", extension];

	if (![UIImage imageNamed:strImage]) {
		strImage = @"ico_generico_reduzido";
	}

	return [UIImage imageNamed:strImage];
}

+ (NSString*)extension:(NSString*)phisicalFile {
	NSRange range = [phisicalFile rangeOfString:@"?"];

	if (range.location == NSNotFound) {
		NSRange file = [phisicalFile rangeOfString:@"." options:NSBackwardsSearch];
		NSUInteger start = file.location + 1;
		return [phisicalFile substringFromIndex:start];
	} else {
		NSUInteger end = range.length;
		NSString* extension = [phisicalFile substringFromIndex:0 toIndex:(int)end];
		NSRange file = [extension rangeOfString:@"." options:NSBackwardsSearch];
		NSUInteger start = file.location + 1;

		return [extension substringFromIndex:start];
	}
}

+ (NSString*)transformedValue:(id)value {

	NSString* temp = value;
	temp = [[temp replace:@"," withString:@""] replace:@"." withString:@""];

	double convertedValue = [temp doubleValue];
	int multiplyFactor = 0;

	NSArray* tokens = [NSArray arrayWithObjects:@"bytes", @"KB", @"MB", @"GB", @"TB", nil];

	while (convertedValue > 1024) {
		convertedValue /= 1024;
		multiplyFactor++;
	}

	return [NSString stringWithFormat:@"%4.2f %@", convertedValue, [tokens objectAtIndex:multiplyFactor]];
}

+ (NSString*)formatSize:(double)size {
	size *= 1024 * 1024;
	NSArray* tokens = [NSArray arrayWithObjects:@"bytes", @"KB", @"MB", @"GB", @"TB", nil];

	int count = 0;

	while (size >= 1024) {
		size /= 1024;
		count++;
	}

	return [NSString stringWithFormat:@"%.2f %@", size, tokens[count]];
}

+ (NSString*)getDateFromTime:(long long)time {
	NSDate* date = [NSDate dateWithTimeIntervalSince1970:time];

	NSDateFormatter* formatter = [[NSDateFormatter alloc] init];

	[formatter setDateStyle:NSDateFormatterMediumStyle];

	return [formatter stringFromDate:date];
}

+ (NSString*)getRelativeDateFromTime:(NSTimeInterval)time {
	NSDate* createdAt = [NSDate dateWithTimeIntervalSince1970:time];

	NSString* strTime = [DateUtil timeAgoString:createdAt];
	return strTime;
}

+ (void)openViewController:(UIViewController*)currentView to:(UIViewController*)viewController eAnimated:(BOOL)animated {
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
		[currentView presentViewController:viewController animated:animated completion:nil];
	} else {
		UIWindow* window = [UIApplication sharedApplication].keyWindow;
		UIViewController* rootViewController = window.rootViewController;
		[rootViewController presentViewController:viewController animated:animated completion:nil];
	}
}

+ (BOOL)isConnected {
	Reachability* networkReachability = [Reachability reachabilityForInternetConnection];
	NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];

	if (networkStatus == NotReachable) {
		return false;
	}

	return true;
}

+ (void)openActionSheet:(UIActionSheet*)actionSheet where:(UIView*)view {
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
		[actionSheet showInView:view];
	} else {
		UIWindow* window = [UIApplication sharedApplication].keyWindow;
		UIViewController* rootViewController = window.rootViewController;
		[actionSheet showInView:rootViewController.view];
	}
}

+ (void)setRightMenuPosition:(UITableView*)tableView {
	CGRect screenRect = [[UIScreen mainScreen] bounds];

	float width;
	float height;

	if ([InterfaceConstant isIOsGraterVersion7]) {
		width = screenRect.size.width;
		height = screenRect.size.height;
	} else {

		if ([InterfaceConstant isPortrait]) {
			width = screenRect.size.width;
			height = screenRect.size.height;
		} else {
			width = screenRect.size.height;
			height = screenRect.size.width;
		}
	}

	tableView.frame = CGRectMake(width - 256, 0, 256, height - 20);
}

+ (NSMutableDictionary*)getDemoKeysMap {

	/*
        Foi solici]tado para apenas enviar chaves para abrir o app em portugues, Isto é momentanio pois os dados não estao bem traduzidos ainda.
    NSString* language = [[NSLocale preferredLanguages] objectAtIndex:0];

	NSMutableDictionary* dicionarioDeChavesPorLanguage = [[NSMutableDictionary alloc] init];

	if ([language contains:@"es"]) {
		[dicionarioDeChavesPorLanguage setObject:@"cc29ad6c-615c-41ae-a0e8-00f69944bb13" forKey:@"token"];
		[dicionarioDeChavesPorLanguage setObject:@"5823364f-b0fc-4636-a116-5f37093079fff9e90729-36a4-4e67-8fa7-1d958b7463be" forKey:@"secret"];
	} else if ([language contains:@"pt"]) {
		[dicionarioDeChavesPorLanguage setObject:@"b66680a0-98e5-496b-a200-ecb737b6253f" forKey:@"token"];
		[dicionarioDeChavesPorLanguage setObject:@"291df0fc-96ea-4329-b32c-fe9c7fb31e48e8af4905-d622-4944-bc06-d39438f29291" forKey:@"secret"];
	} else {
		[dicionarioDeChavesPorLanguage setObject:@"86b63da1-9f37-4239-ba6f-8371a87f53f9" forKey:@"token"];
		[dicionarioDeChavesPorLanguage setObject:@"bdc40583-1bdf-47ab-b8f3-79cb9187d0ac51d9e5b6-d9b5-4228-85b8-6947974c1ae3" forKey:@"secret"];
	}
*/
	NSMutableDictionary* dicionarioDeChavesPorLanguage = [[NSMutableDictionary alloc] init];
	[dicionarioDeChavesPorLanguage setObject:@"b66680a0-98e5-496b-a200-ecb737b6253f" forKey:@"token"];
	[dicionarioDeChavesPorLanguage setObject:@"291df0fc-96ea-4329-b32c-fe9c7fb31e48e8af4905-d622-4944-bc06-d39438f29291" forKey:@"secret"];

	return dicionarioDeChavesPorLanguage;
}

+ (NSObject*)configureStandardHomePage {
	PageReturn* pageReturn = [[PageReturn alloc] init];

	NSString* uri = [ServerManager getMainServer].adresss;

	if (![uri endsWith:@"/"]) {
		uri = [uri stringByAppendingString:@"/"];
	}

	uri = [uri stringByAppendingString:@"portal/p/"];

	OauthServer* server = [ServerManager getMainServer];

	if (!server.companyId || [server.companyId isEqualToString:@""]) {

		ServerConfigReturn* serverConfig = [WCMRest getServerCustomConfig:nil useCache:true];
		server.companyId = serverConfig.tenantCode;
		[ServerManager updateServer:server];
	}

	uri = [uri stringByAppendingString:[NSString stringWithFormat:@"%@/home", server.companyId]];
	pageReturn.uri = uri;
	pageReturn.title = NSLocalizedString(@"mainMenuHome", nil);

	return pageReturn;
}

+ (NSMutableDictionary*)getStoryBoardAndControllerInitialViewController {

	UIStoryboard* storyboard;
	UIViewController* root;
	NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
	ServerConfigReturn* serverConfig = [WCMRest getServerCustomConfig:nil useCache:true];
	StartScreen* startScreen = serverConfig.tenantConfig.startScreen;
	enum LeftMenuType leftMenuCellSelected = CentralTaskMenu;

	if (!startScreen) {
		startScreen = [[StartScreen alloc] init];
		startScreen.screenName = StartScreenTasks;
	}

	switch (startScreen.screenName) {
	case StartScreenProcess:
		storyboard = [UIStoryboard storyboardWithName:@"StoryboardProcess" bundle:nil];
		root = [storyboard instantiateViewControllerWithIdentifier:@"process"];

		leftMenuCellSelected = ProcessMenu;
		break;
	case StartScreenDocument:
		storyboard = [UIStoryboard storyboardWithName:@"StoryboardDocument" bundle:nil];
		root = [storyboard instantiateViewControllerWithIdentifier:@"documentController"];

		leftMenuCellSelected = DocumentsMenu;
		break;
	case StartScreenPage: {

		PageReturn* pageReturn = [[PageReturn alloc] init];
		pageReturn.uri = startScreen.parameter;
		pageReturn.title = startScreen.screenDescription;

		storyboard = [UIStoryboard storyboardWithName:@"StoryboardPages" bundle:nil];
		root = [storyboard instantiateViewControllerWithIdentifier:@"widgetsController"];
		((WidgetsViewController*)root).pageReturn = pageReturn;

		leftMenuCellSelected = PagesMenu;
		break;
	}
	case StartScreenSocial:
	case StartScreenCommunity:
		storyboard = [UIStoryboard storyboardWithName:@"StoryboardSocial" bundle:nil];
		root = [storyboard instantiateViewControllerWithIdentifier:@"social"];

		if (startScreen.parameter) {
			((TimelineViewController*)root).userAlias = startScreen.parameter;
		}

		leftMenuCellSelected = SocialMenu;
		break;
	case StartScreenTasks:
		if (![InterfaceConstant isIpad]) {
			storyboard = [UIStoryboard storyboardWithName:@"StoryboardTasksCentral" bundle:nil];
			root = [storyboard instantiateViewControllerWithIdentifier:@"homeContainer"];
		} else {
			storyboard = [UIStoryboard storyboardWithName:@"StoryboardTasksCentral_iPad" bundle:nil];
			root = [storyboard instantiateViewControllerWithIdentifier:@"homeContainer"];
		}
		break;
	}

	[dict setObject:storyboard forKey:@"storyboard"];
	[dict setObject:root forKey:@"controller"];

	[dict setObject:[NSString stringWithFormat:@"%d", (int)leftMenuCellSelected] forKey:@"leftMenuSelectedCell"];

	return dict;
}

+ (NSMutableDictionary*)getFluigNavigationAndControllerInitialViewController:(BOOL)showAlerts {

	NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
	FluigNavigationViewController* fluigNavigation;
	UIViewController* viewController;
	UIStoryboard* storyboard;
	enum LeftMenuType numberLeftMenu;
	AppDelegate* appDelegate = ((AppDelegate*)[UIApplication sharedApplication].delegate);

	if ([ServerManager getMainServer].demo) {

		if (![InterfaceConstant isIpad]) {
			storyboard = [UIStoryboard storyboardWithName:@"StoryboardTasksCentral" bundle:nil];
			fluigNavigation = (FluigNavigationViewController*)[storyboard instantiateViewControllerWithIdentifier:@"homeNavigation"];

			HomeContainerViewController* centralTasksView = (HomeContainerViewController*)fluigNavigation.topViewController;
			centralTasksView.showAlerts = showAlerts;

			viewController = centralTasksView;

		} else {

			storyboard = [UIStoryboard storyboardWithName:@"StoryboardTasksCentral_iPad" bundle:nil];
			fluigNavigation = (FluigNavigationViewController*)[storyboard instantiateViewControllerWithIdentifier:@"homeNavigation"];

			TasksFullViewController* centralTasksView = (TasksFullViewController*)fluigNavigation.topViewController;

			centralTasksView.showAlerts = showAlerts;
			viewController = centralTasksView;
		}
		numberLeftMenu = CentralTaskMenu;

	} else {

        ServerConfigReturn* serverConfig = [WCMRest getServerCustomConfig:nil useCache:true];
		StartScreen* startScreen = serverConfig.tenantConfig.startScreen;

		if (!startScreen) {
			startScreen = [[StartScreen alloc] init];
			startScreen.screenName = StartScreenTasks;
		}

		switch (startScreen.screenName) {
		case StartScreenProcess:
			storyboard = [UIStoryboard storyboardWithName:@"StoryboardProcess" bundle:nil];
			fluigNavigation = [storyboard instantiateViewControllerWithIdentifier:@"processNavigation"];
			viewController = fluigNavigation.topViewController;
			numberLeftMenu = ProcessMenu;
			break;
		case StartScreenDocument: {
			storyboard = [UIStoryboard storyboardWithName:@"StoryboardDocument" bundle:nil];
			fluigNavigation = (FluigNavigationViewController*)[storyboard instantiateViewControllerWithIdentifier:@"documentsNavigation"];

			DocumentsViewController* documentsViewController = (DocumentsViewController*)fluigNavigation.topViewController;
			documentsViewController.showAlerts = showAlerts;
			viewController = documentsViewController;
			numberLeftMenu = DocumentsMenu;
			break;
		}
		case StartScreenPage: {

			PageReturn* pageReturn = [[PageReturn alloc] init];
			if (!startScreen.parameter) {
				pageReturn = (PageReturn*)[FluigUtils configureStandardHomePage];
			} else {
				pageReturn.uri = startScreen.parameter;
				pageReturn.title = NSLocalizedString(@"mainMenuHome", nil);
			}
			fluigNavigation = [[FluigNavigationViewController alloc] init];
			storyboard = [UIStoryboard storyboardWithName:@"StoryboardPages" bundle:nil];
			WidgetsViewController* wvc = [storyboard instantiateViewControllerWithIdentifier:@"widgetsController"];
			wvc.pageReturn = pageReturn;
			viewController = wvc;
			[fluigNavigation setViewControllers:@[ viewController ]];
			numberLeftMenu = HomeMenu;
			break;
		}
		case StartScreenSocial:
		case StartScreenCommunity: {
			storyboard = [UIStoryboard storyboardWithName:@"StoryboardSocial" bundle:nil];
			fluigNavigation = (FluigNavigationViewController*)[storyboard instantiateViewControllerWithIdentifier:@"socialNavigation"];

			TimelineViewController* timeLineController = (TimelineViewController*)fluigNavigation.topViewController;
			timeLineController.showAlerts = showAlerts;
			if (startScreen.parameter) {
				timeLineController.userAlias = startScreen.parameter;
			}

			viewController = timeLineController;

			numberLeftMenu = SocialMenu;
			break;
		}
		case StartScreenTasks:
			if (![InterfaceConstant isIpad]) {
				storyboard = [UIStoryboard storyboardWithName:@"StoryboardTasksCentral" bundle:nil];
				fluigNavigation = (FluigNavigationViewController*)[storyboard instantiateViewControllerWithIdentifier:@"homeNavigation"];

				HomeContainerViewController* centralTasksView = (HomeContainerViewController*)fluigNavigation.topViewController;
				centralTasksView.showAlerts = showAlerts;
				viewController = centralTasksView;

			} else {
				storyboard = [UIStoryboard storyboardWithName:@"StoryboardTasksCentral_iPad" bundle:nil];
				fluigNavigation = (FluigNavigationViewController*)[storyboard instantiateViewControllerWithIdentifier:@"homeNavigation"];

				TasksFullViewController* centralTasksView = (TasksFullViewController*)fluigNavigation.topViewController;

				centralTasksView.showAlerts = showAlerts;
				viewController = centralTasksView;
			}

			numberLeftMenu = CentralTaskMenu;
			break;
		}
	}

	[appDelegate notifySidePainel:@"left" notifyType:@"change" parameter:[NSString stringWithFormat:@"%d", (int)numberLeftMenu]];

	[dict setObject:fluigNavigation forKey:@"navigation"];
	[dict setObject:viewController forKey:@"controller"];
	[dict setObject:[NSString stringWithFormat:@"%d", (int)numberLeftMenu] forKey:@"number"];

	return dict;
}

+ (void)saveInCacheServerConfig:(ServerConfigReturn*)server withAddress:(NSString*)address {

	NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];


	NSMutableDictionary* oldDict = [self getAllServerConfig:userDefaults];
	ServerConfigReturn* oldServerConfig = [oldDict objectForKey:address];

	if (oldServerConfig.tenantConfig.startScreen.screenName != server.tenantConfig.startScreen.screenName) {
		[[NSNotificationCenter defaultCenter] postNotificationName:@"showToast" object:NSLocalizedString(@"initialScreenChanged", nil)];
	}

    [oldDict setObject:server forKey:address];
    
	[userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:[NSDictionary dictionaryWithDictionary:oldDict]] forKey:@"SERVER_CONFIG_KEY"];
	[userDefaults synchronize];
}

+ (NSMutableDictionary*)getAllServerConfig:(NSUserDefaults*)userDefaults {

	NSData* data = [userDefaults objectForKey:@"SERVER_CONFIG_KEY"];
	NSDictionary* dict;

	if (!data) {
		dict = [NSDictionary new];
		[userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:dict] forKey:@"SERVER_CONFIG_KEY"];

		[userDefaults synchronize];

	} else {

		dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	}
	return [NSMutableDictionary dictionaryWithDictionary:dict];
}


+(void)verifyAndAtualizeServerConfigWithServer:(OauthServer *)oauthServer{
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSData* data = [userDefaults objectForKey:@"SERVER_CONFIG_KEY"];
    
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
    
    ServerConfigReturn* serverConfigReturn = [dict objectForKey:oauthServer.adresss];
    
    if(serverConfigReturn){
        //se Tiver configuração apenas atualiza se passar um dia.
        Reachability* networkReachability = [Reachability reachabilityForInternetConnection];
        
        if ([networkReachability currentReachabilityStatus] == ReachableViaWiFi || [serverConfigReturn.tenantConfig.startScreen.nextUpdate compare:[NSDate date]] == NSOrderedAscending) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                if ([ServerManager verifyMainServerVersionCompatibility:@"1.4.8"]) {
                    [WCMRest getServerCustomConfig:oauthServer useCache:false];
                }
            });
        }else{
            //Busca um novo
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                if ([ServerManager verifyMainServerVersionCompatibility:@"1.4.8"]) {
                    [WCMRest getServerCustomConfig:oauthServer useCache:false];
                }
                
            });

        }

    }
    
    
}

+ (ServerConfigReturn*)getServerConfigWithServer:(OauthServer*)oauthServer {

	NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];

	NSData* data = [userDefaults objectForKey:@"SERVER_CONFIG_KEY"];

	NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithData:data]];

	ServerConfigReturn* serverConfigReturn = [dict objectForKey:oauthServer.adresss];
	if (!serverConfigReturn) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if ([ServerManager verifyMainServerVersionCompatibility:@"1.4.8"]) {
                [WCMRest getServerCustomConfig:oauthServer useCache:false];
            }
 
        });
     
	} else {
		Reachability* networkReachability = [Reachability reachabilityForInternetConnection];

		if ([networkReachability currentReachabilityStatus] == ReachableViaWiFi || [serverConfigReturn.tenantConfig.startScreen.nextUpdate compare:[NSDate date]] == NSOrderedAscending) {
			dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                if ([ServerManager verifyMainServerVersionCompatibility:@"1.4.8"]) {
                    [WCMRest getServerCustomConfig:oauthServer useCache:false];
                }
			});
		}
	}
	return serverConfigReturn;
}



+ (NSString*)socialPermissionEnumToString:(enum SocialPermission)enumVal {

	NSArray* socialPermissionArray = [[NSArray alloc] initWithObjects:kSocialPermissionArray];
	return [socialPermissionArray objectAtIndex:enumVal];
}

+ (enum SocialPermission)socialPermissionStringToEnum:(NSString*)strVal {

	NSArray* socialPermissionArray = [[NSArray alloc] initWithObjects:kSocialPermissionArray];
	NSUInteger n = [socialPermissionArray indexOfObject:strVal];
	if (n < 1) {

		n = Comment;
	}
	return (enum SocialPermission)n;
}

+ (id)objectOrNSNull:(id)object {

	return object ?: [NSNull null];
}

+ (NSString*)getImageDefaultName {

	NSDate* now = [NSDate date];

	NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"ddMMyy-HHmmss"];

	return [NSString stringWithFormat:@"IMG-%@.png", [dateFormat stringFromDate:now]];
}

+(NSString *)getTitleHeader:(enum SearchType)type{
    switch (type) {
        case SEARCH_USER:
            return  NSLocalizedString(@"headerGorupSearcheUser", nil);
            break;
        case SEARCH_DOCUMENT:
            return  NSLocalizedString(@"headerGorupSearchDocuments", nil);
            break;
        case SEARCH_COMMUNITY:
            return  NSLocalizedString(@"headerGorupSearchComunities", nil);
            break;
        case SEARCH_POST:
            return  NSLocalizedString(@"headerGorupSearchPost", nil);
            break;
        case SEARCH_INFLUENCERS:
            return  NSLocalizedString(@"headerGorupSearchInfluencers", nil);
            break;
        
        default:
            break;
    }
    
    return nil;
}

+(void)joinConversation:(NSString*)link serverAddress:(NSString*)serverAddress {
    UIApplication* uiApp = [UIApplication sharedApplication];
    NSString* messagingURL = @"fluigChat://?conversationid=%@&username=%@&server=%@";
    NSString* conversationID = [link replace:@"/messaging/" withString:@""];

    [ServerManager exportAccounts];

    NSString* alias = [self getAliasFromServer:serverAddress];

    NSURL* url = [[NSURL alloc] initWithString:[NSString stringWithFormat:messagingURL, conversationID, alias, serverAddress]];
    BOOL msgInstalled = [uiApp canOpenURL:url];

    if (msgInstalled) {
        [uiApp openURL:url];
    } else {
        [self showMessagingAlert];
    }
}

+(NSString*)getAliasFromServer:(NSString*)serverAddress {
    NSArray* arrServers = [ServerManager loadServer];
    for (OauthServer* server in arrServers) {
        if ([server.adresss isEqualToString:serverAddress]) {
            return server.login;
        }
    }

    return @"";
}

+(void)showMessagingAlert {
    UIViewController* rootController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"" message:NSLocalizedString(@"messagingMissing", nil) preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* ok = [UIAlertAction actionWithTitle:NSLocalizedString(@"updateAvailablePositive", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/br/app/chat/id1186263515?mt=8&ls=1"]];
    }];
    [alert addAction:ok];

    UIAlertAction* cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction* action){
    }];
    [alert addAction:cancel];

    [rootController presentViewController:alert animated:YES completion:nil];
}

@end
