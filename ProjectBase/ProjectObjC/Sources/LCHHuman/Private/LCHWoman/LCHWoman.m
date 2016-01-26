#import "LCHWoman.h"

@implementation LCHWoman

#pragma mark -
#pragma mark Public Implementations

- (LCHHumanGenderType)gender {
    return kLCHGenderFemale;
}

#pragma mark -
#pragma mark LCHHumanProtocol

- (id)performGenderSpecificOperation {
    LCHHumanGenderType randomGender = (arc4random_uniform(kLCHHumanUnknown));
        
    return [[self class] humanWithGender:randomGender];
}

@end
