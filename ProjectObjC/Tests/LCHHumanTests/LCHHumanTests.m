#import "LCHHumanTests.h"
#import "LCHHuman.h"
#import "LCHMan.h"
#import "LCHWoman.h"

#import "NSObject+LCHObjectExtensions.h"

@interface LCHHumanTests ()

- (void)performHumanObjectTests;
- (void)performChildrenArrayTests;
- (void)performSayHelloTests;
- (void)performGenderSpecificOperationTests;

@end

@implementation LCHHumanTests

#pragma mark -
#pragma mark Public Implementations

- (void)performHumanTests {
    [self performHumanObjectTests];
    [self performChildrenArrayTests];
    [self performSayHelloTests];
    [self performGenderSpecificOperationTests];
}

#pragma mark -
#pragma mark Private Implementations

- (void)performHumanObjectTests {
    // Create instance of class LCHHuman with gender Male
    id man = [LCHHuman humanWithGender:kLCHGenderMale];
    
        // Instance must not be nil
        NSAssert(man, @"Instance wasn't created");
    
        // Class of instance must be LCHMan
        NSAssert([LCHMan class] == [man class], @"Instance created with wrong class");
    
        // Gender of instance must be Male
        NSAssert(kLCHGenderMale == [man gender], @"Gender of instanse isn't Male");
    
        // Name must be nil
        NSAssert(![man name], @"Property name isn't nil");
    
        // Children must not be nil
        NSAssert([man children], @"Property children wasn't initialized");
    
        // Children count must be 0
        NSAssert(0 == [[man children] count], @"Children array isn't empty");
    
    // Create instance of class LCHHuman with gender Male
    id woman = [LCHHuman humanWithGender:kLCHGenderFemale];
    
        // Instance must not be nil
        NSAssert(woman, @"Instance wasn't created");
        
        // Class of instance must be LCHMan
        NSAssert([LCHWoman class] == [woman class], @"Instance created with wrong class");
        
        // Gender of instance must be Male
        NSAssert(kLCHGenderFemale == [woman gender], @"Gender of instanse isn't Female");
        
        // Name must be nil
        NSAssert(![woman name], @"Property name isn't nil");
        
        // Children must not be nil
        NSAssert([woman children], @"Property children wasn't initialized");
        
        // Children count must be 0
        NSAssert(0 == [[woman children] count], @"Children array isn't empty");
}

- (void)performChildrenArrayTests {
    // Create test instances
    id man = [LCHHuman humanWithGender:kLCHGenderMale];
    id woman = [LCHHuman humanWithGender:kLCHGenderFemale];
    
    // After test children created
    id firstChild = [LCHHuman humanWithGender:kLCHGenderMale];
    id secondChild = [LCHHuman humanWithGender:kLCHGenderMale];
    
        // firstChild must not be nil
        NSAssert(firstChild, @"Instance wasn't created");
    
        // secondChild must not be nil
        NSAssert(secondChild, @"Instance wasn't created");
    
    // After add firstChild to children array
    [woman addChild:firstChild];
    
        // Children count must not be 0
        NSAssert(0 != [[woman children] count], @"Children array is empty");
    
        // Children count must be 1
        NSAssert(1 == [[woman children] count], @"Children array contains not only 1 object");
    
        // Children array must contain firstChild
        NSAssert([[woman children] containsObject:firstChild], @"Children array doesn't contain firstChild");
    
    // After add firstChild to children array
    [woman addChild:secondChild];
    
        // Children count must not be 0
        NSAssert(0 != [[woman children] count], @"Children array is empty");
        
        // Children count must be 2
        NSAssert(2 == [[woman children] count], @"Children array contains not only 2 objects");
        
        // Children array must contain secondChild
        NSAssert([[woman children] containsObject:secondChild], @"Children array doesn't contain firstChild");
    
    // After add firstChild to children array
    [man addChild:firstChild];
    
        // Children count must not be 0
        NSAssert(0 != [[man children] count], @"Children array is empty");
        
        // Children count must be 1
        NSAssert(1 == [[man children] count], @"Children array contains not only 1 object");
        
        // Children array must contain firstChild
        NSAssert([[man children] containsObject:firstChild], @"Children array doesn't contain firstChild");
    
    // After add firstChild to children array
    [man addChild:secondChild];
    
        // Children count must not be 0
        NSAssert(0 != [[man children] count], @"Children array is empty");
        
        // Children count must be 2
        NSAssert(2 == [[man children] count], @"Children array contains not only 2 objects");
        
        // Children array must contain secondChild
        NSAssert([[man children] containsObject:secondChild], @"Children array doesn't contain firstChild");
}

- (void)performSayHelloTests {
    // Create test instance
    id man = [LCHHuman humanWithGender:kLCHGenderMale];
    
    // Create test instances and add to test array
    for (uint8_t count = 0; count < 20; count++) {
        id child = [LCHHuman humanWithGender:kLCHGenderMale];
        [man addChild:child];
    }
    
    // Say hello from everyone
    [man sayHello];
}

- (void)performGenderSpecificOperationTests {
    // Create test array
    NSMutableArray *array = [NSMutableArray object];
    
    // Create test instances and add to test array
    for (uint8_t count = 0; count < 20; count++) {
        id man = [LCHHuman humanWithGender:kLCHGenderMale];
        id woman = [LCHHuman humanWithGender:kLCHGenderFemale];
        [array addObject:man];
        [array addObject:woman];
    }
    
    // Send message performGenderSpecificOperation to all instances in array
    [array makeObjectsPerformSelector:@selector(performGenderSpecificOperation)];
}

@end
