#import "LCHHuman.h"

@interface LCHHuman ()
@property (nonatomic, readwrite, retain)    NSMutableSet    *mutableChildren;
@property (nonatomic, readwrite, assign)    LCHHumanGender  gender;

@end

@implementation LCHHuman

@dynamic children;

#pragma mark -
#pragma mark Class methods

+ (instancetype)humanWithGender:(LCHHumanGender)gender {
    return [[[self alloc] initWithGender:gender] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.name = nil;
    self.mutableChildren = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.mutableChildren = [NSMutableSet set];
    }
    
    return self;
}

- (instancetype)initWithGender:(LCHHumanGender)gender {
    self = [self init];
    
    if (self) {
        self.gender = gender;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSSet *)children {
    return [[self.mutableChildren copy] autorelease];
}

#pragma mark -
#pragma mark Public Implementations

- (void)sayHello {
    NSLog(@"Hello from %@", self);
    
    for (LCHHuman *child in self.children) {
        NSLog(@"Hello from child %@", child);
    }
}

- (void)fight {
    NSLog(@"%@ Went to fight", self);
}

- (instancetype)reproduce {
    LCHHumanGender randomGender = (arc4random_uniform(kLCHHumanUnknown));

    return [[self class] humanWithGender:randomGender];
}

- (void)addChild:(id<LCHHumanProtocol>)child {
    if ([child conformsToProtocol:@protocol(LCHHumanProtocol)]) {
        [self.mutableChildren addObject:child];
    }
}

- (void)removeChild:(id<LCHHumanProtocol>)child {
    [self.mutableChildren removeObject:child];
}

#pragma mark -
#pragma mark LCHHumanProtocol

- (void)performGenderSpecificOperation {
    
}

@end
