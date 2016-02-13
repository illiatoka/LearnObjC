#import "PUArrayModelChanges.h"

@interface PUArrayModelChanges ()
@property (nonatomic, assign)   PUArrayModelAction  action;
@property (nonatomic, assign)   NSUInteger          idx1;
@property (nonatomic, assign)   NSUInteger          idx2;

@end

@implementation PUArrayModelChanges

#pragma mark -
#pragma mark Class Methods

+ (instancetype)modelOfChangesWithAction:(PUArrayModelAction)action idx1:(NSUInteger)idx1 idx2:(NSUInteger)idx2 {
    return [[PUArrayModelChanges alloc] initWithAction:action idx1:idx1 idx2:idx2];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithAction:(PUArrayModelAction)action idx1:(NSUInteger)idx1 idx2:(NSUInteger)idx2 {
    self = [self init];
    if (self) {
        self.action = action;
        self.idx1 = idx1;
        self.idx2 = idx2;
    }
    
    return self;
}

@end
