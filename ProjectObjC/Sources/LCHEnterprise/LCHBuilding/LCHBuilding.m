#import "LCHBuilding.h"
#import "LCHRoom.h"
#import "LCHContainerWithCapacity.h"

static const NSUInteger kLCHInitialRoomCapacity = 2;

@interface LCHBuilding ()
@property (nonatomic, readwrite, retain) NSMutableSet *mutableRooms;

@end

@implementation LCHBuilding
@dynamic rooms;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)building {
    return [[self alloc] initWithRooms:[NSSet setWithObject:[LCHRoom roomWithCapacity:kLCHInitialRoomCapacity]]];
}

+ (instancetype)buildingWithRooms:(NSSet *)rooms {
    return [[self alloc] initWithRooms:rooms];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableRooms = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.mutableRooms = [NSMutableSet set];
    }
    
    return self;
}

- (instancetype)initWithRooms:(NSSet *)rooms {
    self = [self init];
    
    if (self) {
        for (id room in rooms) {
            [[self mutableRooms] addObject:room];
        }
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSSet *)rooms {
    return [[self.mutableRooms copy] autorelease];
}

#pragma mark -
#pragma mark Public Implementations

- (void)addRoom:(id)room {
    [self.mutableRooms addObject:room];
}

- (void)removeRoom:(id)room {
    for (id employee in [[room employees] items]) {
        [room removeEmployee:employee];
    }
    
    [self.mutableRooms removeObject:room];
}

- (BOOL)canContainCarWashRoom {
    return NO;
}

@end
