#import "NSObject+LCHExtensions.h"

@implementation NSObject (LCHObjectExtensions)

#pragma mark -
#pragma mark Class Methods

+ (instancetype)object {
    return [[[self alloc] init] autorelease];
}

+ (NSArray *)objectsWithCount:(NSUInteger)count {
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:count];
    for (NSUInteger index = 0; index < count; index++) {
        [objects addObject:[self object]];
    }
    
    return [[objects copy] autorelease];
}

@end
