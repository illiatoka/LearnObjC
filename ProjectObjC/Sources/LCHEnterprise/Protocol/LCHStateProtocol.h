#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LCHEmployeeState) {
    kLCHEmployeeIsWorking,
    kLCHEmployeeProcessingNeeded,
    kLCHEmployeeIsReadyToWork
};

@protocol LCHStateProtocol <NSObject>
@property (nonatomic, readonly, assign)     LCHEmployeeState    state;

- (void)employeeDidFinishWithObject:(id<LCHCashProtocol>)object;

- (SEL)selectorForState:(LCHEmployeeState)state;

- (void)setStateIsWorking;
- (void)setStateProcessingNeeded;
- (void)setStateIsReadyToWork;

@end
