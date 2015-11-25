#import <Foundation/Foundation.h>

#import "LCHHumanProtocol.h"

typedef NS_ENUM(NSUInteger, LCHHumanGenderType) {
    kLCHGenderMale,
    kLCHGenderFemale,
    kLCHHumanUnknown
};

@interface LCHHuman : NSObject <LCHHumanProtocol>

+ (instancetype)humanWithGender:(LCHHumanGenderType)gender;

- (instancetype)initWithGender:(LCHHumanGenderType)gender;

- (void)addChild:(id<LCHHumanProtocol>)child;
- (void)removeChild:(id<LCHHumanProtocol>)child;

@end
