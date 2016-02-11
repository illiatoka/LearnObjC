#import "PUAppDelegate.h"

#import "PUSquareViewController.h"
#import "PUShopListViewController.h"

#import "PUShopListItems.h"

#import "UIWindow+PUExtensions.h"

@implementation PUAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [UIWindow window];
    self.window = window;
    PUShopListViewController *controller = [PUShopListViewController new];
    window.rootViewController = controller;
    
    controller.shopListItems = [PUShopListItems new];
    
    [window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
