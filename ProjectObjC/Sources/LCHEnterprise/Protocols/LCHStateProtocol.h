#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LCHEmployeeState) {
    kLCHEmployeeIsWorking,
    kLCHEmployeeIsFinished,
    kLCHEmployeeIsFree
};

@protocol LCHStateProtocol <NSObject>
@property (nonatomic, assign)   LCHEmployeeState    state;

- (SEL)selectorForState:(LCHEmployeeState)state;

@end
