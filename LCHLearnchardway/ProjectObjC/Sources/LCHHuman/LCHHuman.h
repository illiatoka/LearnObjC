#import <Foundation/Foundation.h>

#import "LCHHumanProtocol.h"
#import "LCHTypeDefs.h"

@interface LCHHuman : NSObject <LCHHumanProtocol>

+ (instancetype)humanWithGender:(LCHHumanGenderType)gender;

- (instancetype)initWithGender:(LCHHumanGenderType)gender;

- (void)addChild:(id<LCHHumanProtocol>)child;
- (void)removeChild:(id<LCHHumanProtocol>)child;

@end
