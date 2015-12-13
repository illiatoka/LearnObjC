#import "LCHWashBox.h"
#import "LCHContainerWithCapacity.h"

@interface LCHWashBox ()
@property (nonatomic, readwrite, retain) LCHContainerWithCapacity *privateCars;

@end

@implementation LCHWashBox
@dynamic cars;
@dynamic ableToContainCars;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)roomWithCapacity:(NSUInteger)capacity {
    return [[[self alloc] initWithCapacity:capacity] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithCapacity:(NSUInteger)capacity {
    self = [super initWithCapacity:capacity];
    
    if (self) {
        self.privateCars = [LCHContainerWithCapacity containerWithCapacity:capacity];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (BOOL)isAbleToContainCars {
    return YES;
}

- (LCHContainerWithCapacity *)cars {
    return self.privateCars;
}

#pragma mark -
#pragma mark Public Implementations

- (void)addCar:(id)car {
    [self.privateCars addItem:car];
}

- (void)removeCar:(id)car {
    [self.privateCars removeItem:car];
}

- (BOOL)isFullOfCars {
    return [self.privateCars isFull];
}

@end
