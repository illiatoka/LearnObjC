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

// You should never call this method directly, should be overridden in subclass
- (void)processObject:(id<LCHCashProtocol>)object;

// This methods should be overridden in subclass
- (void)completeProcessingObject:(id<LCHCashProtocol>)object;
- (void)cleanupAfterProcessing;

@end
