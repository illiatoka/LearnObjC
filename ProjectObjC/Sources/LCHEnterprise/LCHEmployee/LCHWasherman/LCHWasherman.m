#import "LCHWasherman.h"
#import "LCHWashBox.h"
#import "LCHContainerWithCapacity.h"
#import "LCHCar.h"

@interface LCHWasherman ()
@property (nonatomic, readwrite, assign) BOOL privateAbleToWash;

@end

@implementation LCHWasherman
@dynamic ableToWash;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.privateAbleToWash = YES;
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Implementations

- (void)performEmployeeSpecificOperationWithPrise:(NSUInteger)price {
    NSSet *cars = [[self.parrentRoom cars] items];
    
    for (LCHCar *car in cars) {
        [car giveMoney:price];
        [car setClean:YES];
        [self giveMoney:price];
    }
}

#pragma mark -
#pragma mark Accessors

- (BOOL)isAbleToWash {
    return self.privateAbleToWash;
}

@end
