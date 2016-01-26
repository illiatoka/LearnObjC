#import "LCHMan.h"

@implementation LCHMan

#pragma mark -
#pragma mark Public Implementations

- (LCHHumanGenderType)gender {
    return kLCHGenderMale;
}

#pragma mark -
#pragma mark LCHHumanProtocol

- (id)performGenderSpecificOperation {
    NSLog(@"%@ Went to fight", self);
    
    return nil;
}

@end
