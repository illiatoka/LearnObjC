#import "LCHContainerWithCapacity.h"

@interface LCHContainerWithCapacity ()
@property (nonatomic, readwrite, assign)    NSUInteger  capacity;

@end

@implementation LCHContainerWithCapacity

#pragma mark -
#pragma mark Class methods

+ (instancetype)containerWithCapacity:(NSUInteger)capacity {
    return [[[self alloc] initWithCapacity:capacity] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithCapacity:(NSUInteger)capacity {
    self = [super init];
    
    if (self) {
        self.capacity = capacity;
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Implementations

#pragma mark -
#pragma mark Public Implementations

- (void)addItem:(id)item {
    if (![self isFull]) {
        [self addItem:item];
    }
}

- (BOOL)isFull {
    return [self.items count] >= self.capacity;
}

@end
