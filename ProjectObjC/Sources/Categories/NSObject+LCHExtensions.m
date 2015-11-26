#import "NSObject+LCHExtensions.h"

@implementation NSObject (LCHExtensions)

#pragma mark -
#pragma mark Class Methods

+ (instancetype)object {
    return [[[self alloc] init] autorelease];
}

@end
