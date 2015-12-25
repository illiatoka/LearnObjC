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
    self = [self init];
    
    if (self) {
        self.capacity = capacity;
    }
    
    return self;
}

#pragma mark -
#pragma mark Public Implementations

- (void)addItem:(id)item {
    @synchronized(self) {
        if (![self isFull]) {
            [super addItem:item];
        }
    }
}

- (BOOL)isFull {
    @synchronized(self) {
        return [self.items count] >= self.capacity;
    }
    
    return YES;
}

@end
