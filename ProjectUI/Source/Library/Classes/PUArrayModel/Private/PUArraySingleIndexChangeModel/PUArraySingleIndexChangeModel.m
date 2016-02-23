#import "PUArraySingleIndexChangeModel.h"

@interface PUArraySingleIndexChangeModel ()
@property (nonatomic, assign)   NSUInteger  index;

@end

@implementation PUArraySingleIndexChangeModel

#pragma mark -
#pragma mark Class Methods

+ (instancetype)modelWithAction:(NSUInteger)action index:(NSUInteger)index {
    return [[PUArraySingleIndexChangeModel alloc] initWithAction:action index:index];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithAction:(NSUInteger)action index:(NSUInteger)index {
    self = [super initWithAction:action];
    if (self) {
        self.index = index;
    }
    
    return self;
}

@end
