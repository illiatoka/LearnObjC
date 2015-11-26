#import "NSObject+LCHObjectCreate.h"

@implementation NSObject (LCHObjectCreate)

#pragma mark -
#pragma mark Class Methods

+ (instancetype)object {
    return [[[self alloc] init] autorelease];
}

@end
