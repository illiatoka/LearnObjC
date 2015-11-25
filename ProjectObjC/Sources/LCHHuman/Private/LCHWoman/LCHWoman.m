#import "LCHWoman.h"

@implementation LCHWoman

#pragma mark -
#pragma mark Public Implementations

- (LCHHumanGenderType)gender {
    return kLCHGenderFemale;
}

#pragma mark -
#pragma mark LCHHumanProtocol

- (instancetype)reproduce {
    LCHHumanGenderType randomGender = (arc4random_uniform(kLCHHumanUnknown));
    
    return [[self class] humanWithGender:randomGender];
}

- (void)performGenderSpecificOperation {
    [self reproduce];
}

@end
