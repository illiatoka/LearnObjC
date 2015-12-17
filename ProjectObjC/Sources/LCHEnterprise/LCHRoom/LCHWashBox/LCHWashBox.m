#import "LCHWashBox.h"
#import "LCHContainerWithCapacity.h"

@interface LCHWashBox ()
@property (nonatomic, readwrite, retain)    LCHContainerWithCapacity    *cars;

@property (nonatomic, readwrite, getter=isAbleToContainCars)    BOOL   ableToContainCars;

@end

@implementation LCHWashBox

#pragma mark -
#pragma mark Class Methods

+ (instancetype)roomWithCapacity:(NSUInteger)capacity {
    return [[[self alloc] initWithCapacity:capacity] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.cars = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.ableToContainCars = YES;
    }
    
    return self;
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
