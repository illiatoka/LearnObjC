#import <Foundation/Foundation.h>

#import "LCHObservableObject.h"
#import "LCHCashProtocol.h"

typedef NS_ENUM(NSUInteger, LCHObjectState) {
    kLCHEmployeeDidStartWork,
    kLCHEmployeeDidFinishWork,
    kLCHEmployeeDidBecomeFree
};

@interface LCHEmployee : LCHObservableObject <LCHCashProtocol>

- (void)performWorkWithObject:(id<LCHCashProtocol>)object;

- (void)completeProcessingObject:(id<LCHCashProtocol>)object;
- (void)cleanupAfterProcessing;

@end
