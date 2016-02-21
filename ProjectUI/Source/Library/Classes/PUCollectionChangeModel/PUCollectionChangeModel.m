#import "PUCollectionChangeModel.h"

@interface PUCollectionChangeModel ()
@property (nonatomic, assign)   NSUInteger  modelAction;

@end

@implementation PUCollectionChangeModel

#pragma mark -
#pragma mark Class Methods

+ (instancetype)collectionModelWithAction:(NSUInteger)action {
    return [[self alloc] initCollectionModelWithAction:action];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initCollectionModelWithAction:(NSUInteger)action {
    self = [self init];
    if (self) {
        self.modelAction = action;
    }
    
    return self;
}

@end
