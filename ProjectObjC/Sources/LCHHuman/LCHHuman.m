#import "LCHHuman.h"

@interface LCHHuman ()
@property    (readwrite)    LCHHumanGenderType    gender;
@end

@implementation LCHHuman

#pragma mark -
#pragma mark Initializations and Deallocations

+ (LCHHuman *)LCHHumanCreate {
    return [[LCHHuman new] autorelease];
}

+ (LCHHuman *)LCHHumanCreateWithGender:(LCHHumanGenderType)gender {
    LCHHuman *object = [[LCHHuman new] autorelease];
    
    object.gender = gender;
    
    return object;
}

#pragma mark -
#pragma mark Public Implementations

- (void)sayHello {

}

- (void)goFight {

}

- (void)goBorn {

}

- (void)addChild:(LCHHuman *)child {

}

- (void)removeChild:(LCHHuman *)child {

}

@end
