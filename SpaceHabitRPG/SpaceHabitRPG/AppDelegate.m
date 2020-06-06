//
//	AppDelegate.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 8/26/16.
//	Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "AppDelegate.h"
#import "SHThemeController.h"
#import "SHCentralViewController.h"
#import "SHConfigSetup.h"

@import SHControls;
@import SHModels;


#ifndef SH_APP_VERSION_NUMBER
#define SH_APP_VERSION_NUMBER 0
#endif

#ifndef SH_DB_FILE_LOCATION
#define SH_DB_FILE_LOCATION "./SH_db.sqlite"
#endif

@interface AppDelegate ()
@property (strong, nonatomic) SHCoreData *dataController;
@property (assign, nonatomic) struct SHSerialQueue *dbQueue;
@property (assign, nonatomic) struct SHConfigAccessor config;
@end

@implementation AppDelegate

void printWorkingDir(){
	NSURL *url = [[NSFileManager.defaultManager URLsForDirectory: NSDocumentDirectory inDomains: NSUserDomainMask] lastObject];
	NSLog(@"%@",url);
}

- (void)applyTheming {
	if (@available(iOS 13.0, *)) {
		UITraitCollection *traits = UITraitCollection.currentTraitCollection;
		if(traits.userInterfaceStyle == UIUserInterfaceStyleDark) {
			[SHThemeController applyDarkTheme];
		}
		else if(traits.userInterfaceStyle == UIUserInterfaceStyleLight) {
			[SHThemeController applyLightTheme];
		}
		else {
			[SHThemeController applyDefaultTheme];
		}
	}
	else {
		[SHThemeController applyDefaultTheme];
	}
}

struct _initialArgs {
	struct SHConfigAccessor *config;
};


static void* _openDb(void *args) {
	struct SHQueueStoreItem *item = malloc(sizeof(struct SHQueueStoreItem));
	struct _initialArgs *initArgs = (struct _initialArgs *)args;
	const char *dbFile = NULL;
	NSArray<NSString*> *procArgs = NSProcessInfo.processInfo.arguments;
	if(procArgs.count > 1) {
		dbFile = procArgs[1].UTF8String;
	}
	else {
		dbFile = SH_DB_FILE_LOCATION;
	}
	if((SH_openDb(&item->db, dbFile)) != SH_NO_ERROR) {
		free(item);
		return NULL;
	}
	item->config = initArgs->config;
	item->config->setIsAppInitialized(true);
	return item;
}


static SHErrorCode _setupDb(void* args, struct SHQueueStore *store) {
	(void)args;
	struct SHQueueStoreItem *item = (struct SHQueueStoreItem *)SH_getUserItemFromStore(store);
	printf("setup db?");
	SHErrorCode status = SH_setupDb(item->db);
	
	
	
	return status;
}


-(BOOL)application:(UIApplication *)application
	didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	(void)application;
	(void)launchOptions;
	SH_setupConfig(&self->_config);
	struct _initialArgs *initArgs = malloc(sizeof(struct _initialArgs));
	*initArgs = (struct _initialArgs){
		.config = &self->_config,
	};
	self.dateProvider = [[SHDefaultDateProvider alloc] init];
	self.dbQueue = SH_initSerialQueue(_openDb, SH_FreeQueueStoreItemVoid, initArgs, free);
	SHErrorCode status = SH_NO_ERROR;
	if((status = SH_startSerialQueueLoop(self.dbQueue))
		!= SH_NO_ERROR)
	{
		return NO;
	}
	
	if(!self.config.getIsAppInitialized()) {
		if((status = SH_addOp(self.dbQueue, _setupDb, NULL, NULL)) != SH_NO_ERROR) {
			return NO;
		}
	}
	#warning update without core data
//	SHDailyProcessor *processor = [[SHDailyProcessor alloc] init];
//
	NSBundle *modelsBundle = [NSBundle bundleForClass:SHBundleKey.class];
//	self.dataController = [SHCoreData newWithOptionsBlock:^(SHCoreDataOptions *options){
//		options.appBundle = modelsBundle;
//	}];
//	processor.context = [self.dataController newBackgroundContext];
	self.resourceUtil = [[SHResourceUtility alloc] initWithBundle:modelsBundle];
	SHSector.sectorInfo = [[SHSectorInfoDictionary alloc] initWithResourceUtil:self.resourceUtil];
	SHMonster.monsterInfo = [[SHMonsterInfoDictionary alloc] initWithResourceUtil:self.resourceUtil];
	self.centralController = [[SHCentralViewController alloc] init];


	[self applyTheming];
	self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
	self.window.rootViewController = self.centralController;

	[self.window makeKeyAndVisible];
	// Override point for customization after application launch.
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
	(void)application;
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	(void)application;
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
	(void)application;
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	(void)application;
	//[SHNotificationHelper cleanUpSentReminders];
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	(void)application;
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(void)dealloc {
	SH_freeSerialQueue(self->_dbQueue);
}


@end
