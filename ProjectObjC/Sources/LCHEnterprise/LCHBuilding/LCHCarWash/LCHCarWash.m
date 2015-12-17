#import "LCHCarWash.h"
#import "LCHWashBox.h"

static const NSUInteger kLCHInitialRoomCapacity = 1;

@interface LCHCarWash ()
@property (nonatomic, readwrite, getter=isAbleToContainCarWashRoom)  BOOL    ableToContainCarWashRoom;

@end

@implementation LCHCarWash

#pragma mark -
#pragma mark Class Methods

+ (instancetype)building {
    return [[self alloc] initWithRooms:[NSSet setWithObject:[LCHWashBox roomWithCapacity:kLCHInitialRoomCapacity]]];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.ableToContainCarWashRoom = YES;
    }
    
    return self;
}

@end
