#import "LCHContainer.h"
#import "NSObject+LCHExtensions.h"

@interface LCHContainer ()
@property (nonatomic, readwrite, retain)    NSMutableSet   *mutableItems;

@end

@implementation LCHContainer
@dynamic items;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)container {
    return [self object];
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

#pragma mark -
#pragma mark Accessors

- (NSSet *)items {
    NSSet *items = nil;
    
    @synchronized(self.mutableItems) {
        items = [[self.mutableItems copy] autorelease];
    }
    
    return items;
}

#pragma mark -
#pragma mark Public Implementations

- (void)addItem:(id)item {
    @synchronized(self.mutableItems) {
        [self.mutableItems addObject:item];
    }
}

- (void)removeItem:(id)item {
    @synchronized(self.mutableItems) {
        [self.mutableItems removeObject:item];
    }
}

@end
