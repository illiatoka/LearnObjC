#import <Foundation/Foundation.h>

#import "LCHObservable.h"
#import "LCHCashProtocol.h"
#import "LCHStateProtocol.h"
#import "LCHObserverProtocol.h"

@interface LCHEmployee : LCHObservable <LCHCashProtocol, LCHStateProtocol, LCHObserverProtocol>

- (void)performWorkWithObject:(id<LCHCashProtocol>)object;

@end
