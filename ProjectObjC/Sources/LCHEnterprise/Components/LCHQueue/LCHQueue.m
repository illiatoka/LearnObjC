#import "LCHQueue.h"

@interface LCHQueue ()
@property (nonatomic, retain)   NSMutableArray  *mutableItems;

@end

@implementation LCHQueue

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.mutableItems = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mutableItems = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark -
#pragma mark Public

- (void)enqueue:(id)object {
    @synchronized(self) {
        [self.mutableItems addObject:object];
    }
}

- (id)dequeue {
    @synchronized(self) {
        id object = [self.mutableItems firstObject];
        if (object) {
            [[object retain] autorelease];
            [self.mutableItems removeObject:object];
        }
        
        return object;
    }
}

@end
