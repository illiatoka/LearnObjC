#import "LCHMan.h"

@implementation LCHMan

#pragma mark -
#pragma mark Public Implementations

- (LCHHumanGenderType)gender {
    return kLCHGenderMale;
}

#pragma mark -
#pragma mark LCHHumanProtocol

- (void)fight {
    NSLog(@"%@ Went to fight", self);
}

- (void)performGenderSpecificOperation {
    [self fight];
}

@end
