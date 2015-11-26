#import "LCHWoman.h"

@implementation LCHWoman

#pragma mark -
#pragma mark Public Implementations

- (LCHHumanGenderType)gender {
    return kLCHGenderFemale;
}

#pragma mark -
#pragma mark LCHHumanProtocol

- (void)reproduce {
    NSLog(@"Went to reproduce %@", self);
}

- (void)performGenderSpecificOperation {
    [self reproduce];
}

@end
