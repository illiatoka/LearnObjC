#import "LCHQueue.h"

@interface LCHQueue ()
@property (nonatomic, readwrite, retain)    NSMutableSet   *mutableItems;

@end

@implementation LCHQueue

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

- (void)enqueue:(id)object {
    @synchronized(self) {
        [self.mutableItems addObject:object];
    }
}

- (id)dequeue {
    @synchronized(self) {
        id object = [[self items] firstObject];
        if (object) {
            [[object retain] autorelease];
            [self.mutableItems removeObject:object];
        }
        
        return object;
    }
    
    return nil;
}

@end
