#import <Foundation/Foundation.h>

#import "LCHHumanProtocol.h"

typedef NS_ENUM(NSUInteger, LCHHumanGender) {
    kLCHGenderMale,
    kLCHGenderFemale,
    kLCHHumanUnknown
};

@interface LCHHuman : NSObject <LCHHumanProtocol>
@property (nonatomic, copy)     NSString    *name;
@property (nonatomic, readonly) NSSet       *children;

@property (nonatomic, assign)   uint8_t     age;
@property (nonatomic, assign)   uint8_t     weight;

+ (instancetype)humanWithGender:(LCHHumanGender)gender;

- (instancetype)initWithGender:(LCHHumanGender)gender;

- (void)addChild:(id<LCHHumanProtocol>)child;
- (void)removeChild:(id<LCHHumanProtocol>)child;

@end
