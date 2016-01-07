#import "LCHContainer.h"

@interface LCHContainer ()
@property (nonatomic, readwrite, retain)    NSMutableSet   *mutableItems;

@end

@implementation LCHContainer

@dynamic items;

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

#pragma mark -
#pragma mark Accessors

- (NSArray *)items {
    NSArray *items = nil;
    NSMutableSet *mutableItems = self.mutableItems;
    
    @synchronized(mutableItems) {
        items = mutableItems.allObjects;
    }
    
    return items;
}

#pragma mark -
#pragma mark Public Implementations

- (void)addItem:(id)item {
    NSMutableSet *mutableItems = self.mutableItems;
    
    @synchronized(mutableItems) {
        [mutableItems addObject:item];
    }
}

- (void)removeItem:(id)item {
    NSMutableSet *mutableItems = self.mutableItems;
    
    @synchronized(mutableItems) {
        [mutableItems removeObject:item];
    }
}

@end
