#import <Foundation/Foundation.h>

typedef enum {
    kLCHHumanUnknown,
    kLCHHumanMale,
    kLCHHumanFemale
} LCHHumanGenderType;

@interface LCHHuman : NSObject

@property   (nonatomic, readonly, copy)      NSString              *firstName;
@property   (nonatomic, readonly, retain)    NSSet                 *children;

@property   (nonatomic, assign)              uint8_t               age;
@property   (nonatomic, assign)              uint8_t               weight;
@property   (nonatomic, readonly, assign)    LCHHumanGenderType    gender;

+ (LCHHuman *)LCHHumanCreate;
+ (LCHHuman *)LCHHumanCreateWithGender:(LCHHumanGenderType)gender;

- (void)sayHello;

- (void)goFight;
- (void)goBorn;

- (void)addChild:(LCHHuman *)child;
- (void)removeChild:(LCHHuman *)child;

@end
