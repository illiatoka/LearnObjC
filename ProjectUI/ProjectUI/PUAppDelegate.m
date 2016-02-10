#import "PUAppDelegate.h"

#import "PUSquareViewController.h"
#import "PUFoodListViewController.h"

#import "PUFoodListItems.h"

#import "UIWindow+PUExtensions.h"

@implementation PUAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [UIWindow window];
    self.window = window;
    PUFoodListViewController *controller = [PUFoodListViewController new];
    window.rootViewController = controller;
    
    controller.foodListItems = [PUFoodListItems new];
    
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
