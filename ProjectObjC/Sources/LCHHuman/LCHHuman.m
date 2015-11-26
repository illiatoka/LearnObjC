#import "LCHHuman.h"
#import "LCHMan.h"
#import "LCHWoman.h"

@interface LCHHuman ()
@property (nonatomic, readwrite, retain)    NSMutableSet    *mutableChildren;

+ (NSMutableDictionary *)genderClasses;
+ (Class)classForGender:(LCHHumanGenderType)gender;

@end

@implementation LCHHuman

@synthesize name = _name;
@synthesize age = _age;
@synthesize weight = _weight;

@dynamic children;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)humanWithGender:(LCHHumanGenderType)gender {
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

- (instancetype)initWithGender:(LCHHumanGenderType)gender {
    Class objectClass = [LCHHuman classForGender:gender];
    
    if (objectClass) {
        [self release];
    }
    
    self = [[objectClass alloc] init];
    
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

- (void)addChild:(id<LCHHumanProtocol>)child {
    if ([child conformsToProtocol:@protocol(LCHHumanProtocol)]) {
        [self.mutableChildren addObject:child];
    }
}

- (void)removeChild:(id<LCHHumanProtocol>)child {
    [self.mutableChildren removeObject:child];
}

#pragma mark -
#pragma mark Private Implementations

+ (NSMutableDictionary *)genderClasses {
    static NSMutableDictionary *__genderClasses = nil;
    
    if (nil == __genderClasses) {
        __genderClasses = [NSMutableDictionary dictionaryWithDictionary:@{@(kLCHGenderMale)     : [LCHMan class],
                                                                          @(kLCHGenderFemale)   : [LCHWoman class]}];
    }
    
    return __genderClasses;
}

+ (Class)classForGender:(LCHHumanGenderType)gender {
    NSMutableDictionary *genderClasses = [self genderClasses];
    Class result = genderClasses[@(gender)];
    
    NSAssert(result, @"Class isn't register for gender %lu", (unsigned long)gender);
    
    return result;
}

#pragma mark -
#pragma mark LCHHumanProtocol

- (void)performGenderSpecificOperation {
    // Do nothing if message sent to LCHHuman
}

@end
