#import "NSObject+LCHExtensions.h"

@implementation NSObject (LCHObjectExtensions)

#pragma mark -
#pragma mark Class Methods

+ (instancetype)object {
    return [[[self alloc] init] autorelease];
}

#pragma mark -
#pragma mark Public Implementations

- (NSArray *)objectsOfClass:(Class)class withCount:(NSUInteger)count {
    NSMutableArray *objects = [NSMutableArray arrayWithCapacity:count - 1];
    for (NSUInteger index = 0; index < count; index++) {
        id object = [class object];
        [objects addObject:object];
    }
    
    return [[objects copy] autorelease];
}

@end
