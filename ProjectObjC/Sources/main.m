#import <Foundation/Foundation.h>

#import "LCHHuman.h"
#import "LCHMan.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        LCHHuman *human = [LCHHuman human];
        [human sayHello];
        [human fight];
        [human reproduce];
        
        NSLog(@"Human class is %@", [human class]);
        NSLog(@"Human is instance of class %@", [human className]);
        
        LCHMan *man = [LCHMan human];
        
        NSLog(@"Man class is %@", [man class]);
        NSLog(@"Man is instance of class %@", [man className]);
        
        if ([man isKindOfClass:[human class]]) {
            NSLog(@"Man is kind of class LCHHuman");
        }
        
        LCHMan *child = [man reproduce];
        [man addChild:child];
        
        NSLog(@"Children count = %lu", (unsigned long)[man.children count]);
    }
    
    return 0;
}
