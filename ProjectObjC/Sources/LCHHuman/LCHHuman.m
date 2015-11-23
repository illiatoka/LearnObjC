#import "LCHHuman.h"

@interface LCHHuman ()
@property (nonatomic, readwrite, copy)      NSString            *firstName;
@property (nonatomic, readwrite, retain)    NSMutableArray      *mutableChildren;
@property (nonatomic, readwrite, assign)    LCHHumanGenderType  gender;
@end

@implementation LCHHuman

@dynamic children;

#pragma mark -
#pragma mark Class methods

+ (instancetype)human {
    return [[[self alloc] init] autorelease];
}

+ (instancetype)humanWithFirstName:(NSString *)name gender:(LCHHumanGenderType)gender {
    return [[[self alloc] initWithFirstName:name gender:gender] autorelease];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.firstName = nil;
    self.mutableChildren = nil;
    
    [super dealloc];
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.firstName = nil;
        self.mutableChildren = [NSMutableArray array];
        self.gender = kLCHHumanUnknown;
    }
    
    return self;
}

- (instancetype)initWithFirstName:(NSString *)name gender:(LCHHumanGenderType)gender {
    self = [self init];
    
    if (self) {
        self.firstName = name;
        self.gender = gender;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)children {
    return [[self.mutableChildren copy] autorelease];
}

#pragma mark -
#pragma mark Public Implementations

- (void)sayHello {
    NSLog(@"Hello from %@", self);
}

- (void)fight {
    NSLog(@"%@ Went to fight", self);
}

- (instancetype)reproduce {
    return [LCHHuman human];
}

- (void)addChild:(LCHHuman *)child {
    NSMutableArray *children = self.mutableChildren;
    
    if (YES == [child isKindOfClass:[LCHHuman class]]) {
        if (NO == [children containsObject:child]) {
            [children addObject:child];
        }
    }
}

- (void)removeChild:(LCHHuman *)child {
    [self.mutableChildren removeObject:child];
}

@end
