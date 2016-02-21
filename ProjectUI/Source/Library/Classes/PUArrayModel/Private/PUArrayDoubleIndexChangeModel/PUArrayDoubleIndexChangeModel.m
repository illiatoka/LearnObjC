#import "PUArrayDoubleIndexChangeModel.h"

@interface PUArrayDoubleIndexChangeModel ()
@property (nonatomic, assign)   NSUInteger  toIndex;

@end

@implementation PUArrayDoubleIndexChangeModel

#pragma mark -
#pragma mark Class Methods

+ (instancetype)changeModelWithAction:(NSUInteger)action idx1:(NSUInteger)idx1 idx2:(NSUInteger)idx2 {
    return [[PUArrayDoubleIndexChangeModel alloc] initWithAction:action idx1:idx1 idx2:idx2];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithAction:(NSUInteger)action idx1:(NSUInteger)idx1 idx2:(NSUInteger)idx2 {
    self = [super initWithAction:action index:idx1];
    if (self) {
        self.toIndex = idx2;
    }
    
    return self;
}

@end
