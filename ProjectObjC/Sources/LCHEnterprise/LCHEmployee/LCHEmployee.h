#import <Foundation/Foundation.h>

#import "LCHObservableObject.h"
#import "LCHCashProtocol.h"

typedef NS_ENUM(NSUInteger, LCHObjectState) {
    kLCHEmployeeDidStart,
    kLCHEmployeeDidFinish,
    kLCHEmployeeDidBecomeFree
};

@interface LCHEmployee : LCHObservable <LCHCashProtocol>

- (void)performWorkWithObject:(id<LCHCashProtocol>)object;

@end
