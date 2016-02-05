#import "UIWindow+PUExtensions.h"

@implementation UIWindow (PUExtensions)

#pragma mark -
#pragma mark Class methods

+ (UIWindow *)window {
    return [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
}

@end
