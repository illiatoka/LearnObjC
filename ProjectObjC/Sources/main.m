#import <Foundation/Foundation.h>

#import "LCHHuman.h"
#import "LCHMan.h"
#import "LCHWoman.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        id man = [LCHHuman humanWithGender:kLCHGenderMale];
        
        NSLog(@"Man class is %@", [man class]);
        NSLog(@"Man is instance of class %@", [man className]);
        
        id woman = [LCHHuman humanWithGender:kLCHGenderFemale];
        [woman sayHello];
        [woman reproduce];
        
        NSLog(@"Human class is %@", [woman class]);
        NSLog(@"Human is instance of class %@", [woman className]);
        
        id child = [woman reproduce];
        NSLog(@"Child is instance of class %@", [child className]);
        
        [woman addChild:child];
        NSLog(@"Children count = %lu", (unsigned long)[[woman children] count]);
        
        NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
        
        for (uint8_t count = 0; count < 20; count++) {
            id man = [LCHHuman humanWithGender:kLCHGenderMale];
            id woman = [LCHHuman humanWithGender:kLCHGenderFemale];
            [array addObject:man];
            [array addObject:woman];
        }
        
        for (LCHHuman *human in array) {
            [human performGenderSpecificOperation];
        }
    }
    
    return 0;
}
