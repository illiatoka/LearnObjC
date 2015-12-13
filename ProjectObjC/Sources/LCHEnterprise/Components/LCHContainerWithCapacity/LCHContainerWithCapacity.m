#import "LCHContainerWithCapacity.h"

@interface LCHContainerWithCapacity ()
@property (nonatomic, readwrite, retain) NSMutableSet *mutableItems;
@property (nonatomic, readwrite, assign) NSUInteger privateCapacity;

@end

@implementation LCHContainerWithCapacity
@dynamic capacity;
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
        self.privateCapacity = capacity;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSUInteger)capacity {
    return self.privateCapacity;
}

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
    return [self.mutableItems count] >= self.privateCapacity;
}

@end
