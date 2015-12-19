#import "LCHRoom.h"
#import "LCHContainerWithCapacity.h"

static const NSUInteger kLCHDefaultCapacity = 2;

@interface LCHRoom ()
@property (nonatomic, readwrite, retain)    LCHContainerWithCapacity    *employees;

@end

@implementation LCHRoom

#pragma mark -
#pragma mark Class Methods

+ (instancetype)room {
    return [[[self alloc] initWithCapacity:kLCHDefaultCapacity] autorelease];
}

+ (instancetype)roomWithCapacity:(NSUInteger)capacity {
    return [[[self alloc] initWithCapacity:capacity] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.employees = nil;
    
    [super dealloc];
}

- (instancetype)initWithCapacity:(NSUInteger)capacity {
    self = [self init];
    
    if (self) {
        self.employees = [LCHContainerWithCapacity containerWithCapacity:capacity];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Implementations

- (void)addEmployee:(id)employee {
    [self.employees addItem:employee];
}

- (void)removeEmployee:(id)employee {
    [self.employees removeItem:employee];
}

- (BOOL)isFullOfEmployees {
    return [self.employees isFull];
}

@end
