#import "LCHWashBox.h"
#import "LCHContainerWithCapacity.h"

static const NSUInteger kLCHDefaultCapacity = 1;

@interface LCHWashBox ()
@property (nonatomic, readwrite, retain)    LCHContainerWithCapacity    *cars;

@end

@implementation LCHWashBox

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
    self.cars = nil;
    
    [super dealloc];
}

- (instancetype)initWithCapacity:(NSUInteger)capacity {
    self = [super initWithCapacity:capacity];
    
    if (self) {
        self.cars = [LCHContainerWithCapacity containerWithCapacity:capacity];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Implementations

- (void)addCar:(id)car {
    [self.cars addItem:car];
}

- (void)removeCar:(id)car {
    [self.cars removeItem:car];
}

- (BOOL)isFullOfCars {
    return [self.cars isFull];
}

@end
