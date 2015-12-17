#import "LCHContainerWithCapacity.h"

@interface LCHContainerWithCapacity ()
@property (nonatomic, readwrite, assign)    NSUInteger     capacity;
@property (nonatomic, readwrite, retain)    NSMutableSet   *mutableItems;

@end

@implementation LCHContainerWithCapacity
@dynamic items;

#pragma mark -
#pragma mark Class methods

+ (instancetype)containerWithCapacity:(NSUInteger)capacity {
    return [[[self alloc] initWithCapacity:capacity] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableItems = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.mutableItems = [NSMutableSet set];
    }
    
    return self;
}

- (instancetype)initWithCapacity:(NSUInteger)capacity {
    self = [self init];
    
    if (self) {
        self.capacity = capacity;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSSet *)items {
    return [[self.mutableItems copy] autorelease];
}

#pragma mark -
#pragma mark Public Implementations

- (void)addItem:(id)item {
    if (![self isFull]) {
        [self.mutableItems addObject:item];
    }
}

- (void)removeItem:(id)item {
    [self.mutableItems removeObject:item];
}

- (BOOL)isFull {
    return [self.mutableItems count] >= self.capacity;
}

@end
