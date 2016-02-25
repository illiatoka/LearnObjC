#import "PUAppDelegate.h"

#import "PUSquareViewController.h"
#import "PUShopListViewController.h"
#import "PUUsersViewController.h"

#import "PUShopListItems.h"

#import "UIWindow+PUExtensions.h"

@interface PUAppDelegate ()
@property (nonatomic, strong)   PUShopListItems *shopListItems;

@end

@implementation PUAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [UIWindow window];
    self.window = window;
    PUShopListViewController *controller = [PUShopListViewController new];
    window.rootViewController = controller;
    
    PUShopListItems *shopListItems = [PUShopListItems new];
    self.shopListItems = shopListItems;
    controller.shopListItems = shopListItems;
    
    [window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [self.shopListItems save];
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
