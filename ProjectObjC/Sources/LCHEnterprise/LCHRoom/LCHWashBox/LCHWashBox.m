#import "LCHWashBox.h"
#import "LCHContainerWithCapacity.h"

@interface LCHWashBox ()
// TODO: Give a proper name for this property
@property (nonatomic, readwrite, retain) LCHContainerWithCapacity *blablaCars;

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
        self.blablaCars = [LCHContainerWithCapacity containerWithCapacity:capacity];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (BOOL)isAbleToContainCars {
    return YES;
}

- (LCHContainerWithCapacity *)cars {
    return self.blablaCars;
}

#pragma mark -
#pragma mark Public Implementations

- (void)addCar:(id)car {
    [self.blablaCars addItem:car];
}

- (void)removeCar:(id)car {
    [self.blablaCars removeItem:car];
}

- (BOOL)isFullOfCars {
    return [self.blablaCars isFull];
}

@end
