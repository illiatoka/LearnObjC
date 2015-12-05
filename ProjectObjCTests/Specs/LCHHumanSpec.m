#import "Kiwi.h"

#import "LCHHuman.h"
#import "LCHMan.h"
#import "LCHWoman.h"

SPEC_BEGIN(LCHHumanSpec)

describe(@"LCHHuman", ^{
    __block id man = nil;
    __block id woman = nil;
    
    afterAll(^{
        man = nil;
        woman = nil;
    });
    
    context(@"when initialized with humanWithGender: with gender kLCHGenderMale", ^{
        man = [LCHHuman humanWithGender:kLCHGenderMale];
        
        it(@"should be of Class LCHMan", ^{
            [[man should] beKindOfClass:[LCHMan class]];
        });
        
        // Instance must not be nil
        NSAssert(man, @"Instance wasn't created");
        
        // Gender of instance must be Male
        NSAssert(kLCHGenderMale == [man gender], @"Gender of instanse isn't Male");
        
        // Name must be nil
        NSAssert(![man name], @"Property name isn't nil");
        
        // Children must not be nil
        NSAssert([man children], @"Property children wasn't initialized");
        
        // Children count must be 0
        NSAssert(0 == [[man children] count], @"Children array isn't empty");
    });
    
    context(@"when initialized with humanWithGender: with gender kLCHGenderFemale", ^{
        woman = [LCHHuman humanWithGender:kLCHGenderFemale];
        
        it(@"should be of Class LCHWoman", ^{
            [[woman should] beKindOfClass:[LCHWoman class]];
        });
        
        // Instance must not be nil
        NSAssert(woman, @"Instance wasn't created");
        
        // Gender of instance must be Male
        NSAssert(kLCHGenderFemale == [woman gender], @"Gender of instanse isn't Female");
        
        // Name must be nil
        NSAssert(![woman name], @"Property name isn't nil");
        
        // Children must not be nil
        NSAssert([woman children], @"Property children wasn't initialized");
        
        // Children count must be 0
        NSAssert(0 == [[woman children] count], @"Children array isn't empty");
    });
    
    context(@"when child was added to children array", ^{
        man = [LCHHuman humanWithGender:kLCHGenderMale];
        woman = [LCHHuman humanWithGender:kLCHGenderFemale];
        
        id firstChild = [LCHHuman humanWithGender:kLCHGenderMale];
        id secondChild = [LCHHuman humanWithGender:kLCHGenderFemale];
        
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
        
        // After remove secondChild from children array
        [man removeChild:secondChild];
        
        // Children count must not be 0
        NSAssert(0 != [[man children] count], @"Children array is empty");
        
        // Children count must be 1
        NSAssert(1 == [[man children] count], @"Child was not removed");
        
        // Children array must not contain secondChild
        NSAssert(NO == [[man children] containsObject:secondChild], @"Children array contains secondChild");
    });
    
    context(@"when performGenderSpecificOperation was invoked", ^{
        NSMutableArray *array = [NSMutableArray array];
        NSUInteger humanCount = 20;
        
        // Create test instances and add to test array
        for (uint8_t count = 0; count < humanCount; count++) {
            id man = [LCHHuman humanWithGender:kLCHGenderMale];
            id woman = [LCHHuman humanWithGender:kLCHGenderFemale];
            [array addObject:man];
            [array addObject:woman];
        }
        
        // Send message performGenderSpecificOperation to all instances in array
        for (LCHHuman *human in array) {
            id result = [human performGenderSpecificOperation];
            
            if (result && [result isKindOfClass:[LCHHuman class]]) {
                [human addChild:result];
            }
        }
        
        // Say hello from everyone
        [array makeObjectsPerformSelector:@selector(sayHello)];
    });
});

SPEC_END
