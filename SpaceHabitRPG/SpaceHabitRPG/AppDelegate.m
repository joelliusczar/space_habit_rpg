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



@interface AppDelegate ()
@property (strong,nonatomic) SHCoreData *dataController;
@property (strong,nonatomic) SHResourceUtility *resourceUtil;
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

-(BOOL)application:(UIApplication *)application
	didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	(void)application;
	(void)launchOptions;
	NSBundle *modelsBundle = [NSBundle bundleForClass:SHBundleKey.class];
	self.dataController = [SHCoreData newWithOptionsBlock:^(SHCoreDataOptions *options){
		options.appBundle = modelsBundle;
	}];
	self.resourceUtil = [[SHResourceUtility alloc] initWithBundle:modelsBundle];
	SHSector.sectorInfo = [[SHSectorInfoDictionary alloc] initWithResourceUtil:self.resourceUtil];
	SHMonster.monsterInfo = [[SHMonsterInfoDictionary alloc] initWithResourceUtil:self.resourceUtil];
	self.centralController = [SHCentralViewController
		newWithDataController:self.dataController
		andNibName:@"SHCentralViewController"
		andResourceUtil:self.resourceUtil
		andBundle:nil];
	
	
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
	[SHNotificationHelper cleanUpSentReminders];
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
	(void)application;
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(BOOL)application:(UIApplication *)application
	shouldSaveApplicationState:(NSCoder *)coder
{
	(void)application; (void)coder;
	return YES;
}


-(BOOL)application:(UIApplication *)application
	shouldRestoreApplicationState:(NSCoder *)coder
{
	(void)application; (void)coder;
	return YES;
}


@end
