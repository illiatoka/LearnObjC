#import "PUCollectionChangeModel.h"

@interface PUCollectionChangeModel ()
@property (nonatomic, assign)   NSUInteger  modelAction;

@end

@implementation PUCollectionChangeModel

#pragma mark -
#pragma mark Class Methods

+ (instancetype)changeModelWithAction:(NSUInteger)action {
    return [[self alloc] initModelWithAction:action];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initModelWithAction:(NSUInteger)action {
    self = [self init];
    if (self) {
        self.modelAction = action;
    }
    
    return self;
}

@end
