#import <Foundation/Foundation.h>

#import "LCHObservable.h"
#import "LCHCashProtocol.h"
#import "LCHObserverProtocol.h"

@interface LCHEmployee : LCHObservable <LCHCashProtocol>

- (void)performWorkWithObject:(id<LCHCashProtocol>)object;

@end
