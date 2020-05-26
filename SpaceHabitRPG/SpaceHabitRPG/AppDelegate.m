//
//	AppDelegate.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 8/26/16.
//	Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "AppDelegate.h"
#import "SHThemeController.h"
@import SHCommon;
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
@property (strong, nonatomic) SHResourceUtility *resourceUtil;
@property (assign, nonatomic) sqlite3 *db;
@property (assign, nonatomic) pthread_t dbSerialThread;
@property (assign, nonatomic) struct SHSerialQueue *queue;
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


static void* _serialQueueLoopWrapper(void *args) {
	SHErrorCode status = SH_NO_ERROR;
	struct SHSerialQueue *queue = (struct SHSerialQueue *)args;
	if((status = SH_startSerialQueueLoop(queue)) != SH_NO_ERROR) { ; }
	printf("thread ending");
	return NULL;
}

struct SHOpenDbArgs {
	sqlite3 **db;
	const unsigned char * dbFilePath;
};


static SHErrorCode _openDb(void *args) {
	struct SHOpenDbArgs *openDbArgs = (struct SHOpenDbArgs *)args;
	return SH_openDb(openDbArgs->db, openDbArgs->dbFilePath);
}


static SHErrorCode _setupDb(void* args) {
	sqlite3 *db = (sqlite3 *)args;
	return SH_setupDb(db);
}

-(BOOL)application:(UIApplication *)application
	didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	(void)application;
	(void)launchOptions;
	const unsigned char *dbFile = NULL;
	NSArray<NSString*> *args = NSProcessInfo.processInfo.arguments;
	if(args.count > 1) {
		dbFile = (unsigned char *)args[1].UTF8String;
	}
	else {
		dbFile = (unsigned char *)SH_DB_FILE_LOCATION;
	}
	self.queue = SH_initSerialQueue();
	int32_t threadStatus = 0;
	SHErrorCode status = SH_NO_ERROR;
	if((threadStatus = pthread_create(&self->_dbSerialThread, NULL, _serialQueueLoopWrapper, self.queue))
		!= SH_NO_ERROR)
	{
		return NO;
	}
	struct SHOpenDbArgs *openDbArgs = malloc(sizeof(struct SHOpenDbArgs));
	*openDbArgs = (struct SHOpenDbArgs){ .db = &self->_db, .dbFilePath = dbFile };
	if((status = SH_addOpToSerialQueue(self.queue, _openDb, openDbArgs, free)) != SH_NO_ERROR) {
		return NO;
	}
	if(!SHConfig.isAppInitialized) {
		if((status = SH_addOpToSerialQueue(self.queue, _setupDb, self->_db, NULL)) != SH_NO_ERROR) {
			return NO;
		}
	}
	#warning update without core data
//	SHDailyProcessor *processor = [[SHDailyProcessor alloc] init];
//
//	NSBundle *modelsBundle = [NSBundle bundleForClass:SHBundleKey.class];
//	self.dataController = [SHCoreData newWithOptionsBlock:^(SHCoreDataOptions *options){
//		options.appBundle = modelsBundle;
//	}];
//	processor.context = [self.dataController newBackgroundContext];
//	self.resourceUtil = [[SHResourceUtility alloc] initWithBundle:modelsBundle];
//	SHSector.sectorInfo = [[SHSectorInfoDictionary alloc] initWithResourceUtil:self.resourceUtil];
//	SHMonster.monsterInfo = [[SHMonsterInfoDictionary alloc] initWithResourceUtil:self.resourceUtil];
//	[processor processAllDailies];
//	self.centralController = [SHCentralViewController
//		newWithDataController:self.dataController
//		andNibName:@"SHCentralViewController"
//		andResourceUtil:self.resourceUtil
//		andBundle:nil];
//
//
//	[self applyTheming];
//	self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
//	self.window.rootViewController = self.centralController;
//
//	[self.window makeKeyAndVisible];
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
	SH_freeSerialQueue(self->_queue);
	int32_t sqlStatus = 0;
	if((sqlStatus = sqlite3_close(self->_db)) != SQLITE_OK) {
		SH_notifyOfError(SH_SQLITE3_ERROR, "Couldn't close for some reason");
	}

}


@end
