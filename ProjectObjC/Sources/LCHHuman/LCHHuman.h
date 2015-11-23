#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LCHHumanGenderType) {
    kLCHHumanUnknown,
    kLCHHumanMale,
    kLCHHumanFemale
};

@interface LCHHuman : NSObject

@property (nonatomic, readonly, copy)   NSString    *firstName;
@property (nonatomic, readonly)         NSArray     *children;

@property (nonatomic, assign)   uint8_t     age;
@property (nonatomic, assign)   uint8_t     weight;

@property (nonatomic, readonly) LCHHumanGenderType  gender;

+ (instancetype)human;
+ (instancetype)humanWithFirstName:(NSString *)name gender:(LCHHumanGenderType)gender;

- (instancetype)init;
- (instancetype)initWithFirstName:(NSString *)name gender:(LCHHumanGenderType)gender;

- (void)sayHello;

- (void)fight;
- (instancetype)reproduce;

- (void)addChild:(LCHHuman *)child;
- (void)removeChild:(LCHHuman *)child;

@end
