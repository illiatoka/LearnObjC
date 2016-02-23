#import "PUCollectionChangeModel.h"

@interface PUCollectionChangeModel ()
@property (nonatomic, assign)   NSUInteger  modelAction;

@end

@implementation PUCollectionChangeModel

#pragma mark -
#pragma mark Class Methods

+ (instancetype)modelWithAction:(NSUInteger)action {
    return [[self alloc] initWithAction:action];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithAction:(NSUInteger)action {
    self = [self init];
    if (self) {
        self.modelAction = action;
    }
    
    return self;
}

@end
