#import "LCHRoom.h"
#import "LCHContainerWithCapacity.h"

@interface LCHRoom ()
@property (nonatomic, readwrite, retain) LCHContainerWithCapacity *privateEmployees;

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
    self.privateEmployees = nil;
    
    [super dealloc];
}

- (instancetype)initWithCapacity:(NSUInteger)capacity {
    self = [self init];
    
    if (self) {
        self.privateEmployees = [LCHContainerWithCapacity containerWithCapacity:capacity];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (LCHContainerWithCapacity *)employees {
    return self.privateEmployees;
}

#pragma mark -
#pragma mark Public Implementations

- (void)addEmployee:(id)employee {
    [self.privateEmployees addItem:employee];
}

- (void)removeEmployee:(id)employee {
    [self.privateEmployees removeItem:employee];
}

- (BOOL)isFull {
    return [self.privateEmployees isFull];
}

@end
