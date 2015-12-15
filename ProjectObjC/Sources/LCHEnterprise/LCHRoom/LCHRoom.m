#import "LCHRoom.h"
#import "LCHContainerWithCapacity.h"

@interface LCHRoom ()
// TODO: Give a proper name for this property
@property (nonatomic, readwrite, retain) LCHContainerWithCapacity *blablaEmployees;

@end

@implementation LCHRoom
@dynamic employees;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)roomWithCapacity:(NSUInteger)capacity {
    return [[[self alloc] initWithCapacity:capacity] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.blablaEmployees = nil;
    
    [super dealloc];
}

- (instancetype)initWithCapacity:(NSUInteger)capacity {
    self = [self init];
    
    if (self) {
        self.blablaEmployees = [LCHContainerWithCapacity containerWithCapacity:capacity];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (LCHContainerWithCapacity *)employees {
    return self.blablaEmployees;
}

#pragma mark -
#pragma mark Public Implementations

- (void)addEmployee:(id)employee {
    [self.blablaEmployees addItem:employee];
}

- (void)removeEmployee:(id)employee {
    [self.blablaEmployees removeItem:employee];
}

- (BOOL)isFull {
    return [self.blablaEmployees isFull];
}

@end
