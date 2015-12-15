#import "LCHWasherman.h"
#import "LCHWashBox.h"
#import "LCHContainerWithCapacity.h"
#import "LCHCar.h"

@interface LCHWasherman ()
// TODO: Give a proper name for this property
@property (nonatomic, readwrite, assign) BOOL blablaAbleToWash;

@end

@implementation LCHWasherman
@dynamic ableToWash;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.blablaAbleToWash = YES;
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
    return self.blablaAbleToWash;
}

@end
