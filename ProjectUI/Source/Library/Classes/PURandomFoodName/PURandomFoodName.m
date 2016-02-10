#import "PURandomFoodName.h"

@interface PURandomFoodName ()
@property (nonatomic, strong)   NSMutableArray  *mutableFoodNames;

@end

@implementation PURandomFoodName

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutableFoodNames = [NSMutableArray arrayWithObjects:
                                 @"Apples",
                                 @"Bananas",
                                 @"Juice",
                                 @"Bread",
                                 @"Cheese",
                                 @"Milk",
                                 @"Yogurt",
                                 nil];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)foodNames {
    return [self.mutableFoodNames copy];
}

#pragma mark -
#pragma mark Public

- (NSString *)randomFoodName {
    NSUInteger randomIndex = arc4random_uniform((uint32_t)self.mutableFoodNames.count);
    
    return [self.mutableFoodNames objectAtIndex:randomIndex];
}

@end
