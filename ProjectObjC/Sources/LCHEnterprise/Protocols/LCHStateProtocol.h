#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LCHEmployeeState) {
    kLCHEmployeeIsWorking,
    kLCHEmployeeProcessingNeeded,
    kLCHEmployeeIsFree
};

@protocol LCHStateProtocol <NSObject>
@property (nonatomic, assign)     LCHEmployeeState    state;

- (void)employeeDidFinishWithObject:(id<LCHCashProtocol>)object;

- (SEL)selectorForState:(LCHEmployeeState)state;

@end
