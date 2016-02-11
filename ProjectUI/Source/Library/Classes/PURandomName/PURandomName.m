#import "PURandomName.h"

@interface PURandomName ()
@property (nonatomic, strong)   NSMutableArray  *mutableNames;

@end

@implementation PURandomName

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutableNames = [NSMutableArray arrayWithObjects:
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

- (NSArray *)names {
    return [self.mutableNames copy];
}

#pragma mark -
#pragma mark Public

- (NSString *)randomName {
    NSUInteger randomIndex = arc4random_uniform((uint32_t)self.mutableNames.count);
    
    return [self.mutableNames objectAtIndex:randomIndex];
}

@end
