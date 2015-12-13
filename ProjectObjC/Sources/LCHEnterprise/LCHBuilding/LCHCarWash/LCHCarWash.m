#import "LCHCarWash.h"
#import "LCHWashBox.h"

static const NSUInteger kLCHInitialRoomCapacity = 1;

@implementation LCHCarWash

#pragma mark -
#pragma mark Class Methods

+ (instancetype)building {
    return [[self alloc] initWithRooms:[NSSet setWithObject:[LCHWashBox roomWithCapacity:kLCHInitialRoomCapacity]]];
}

#pragma mark -
#pragma mark Public Implementations

- (BOOL)canContainCarWashRoom {
    return YES;
}

@end
