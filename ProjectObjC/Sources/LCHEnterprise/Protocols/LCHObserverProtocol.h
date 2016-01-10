#import <Foundation/Foundation.h>
#import "LCHCashProtocol.h"

@protocol LCHObserverProtocol <NSObject>

@optional
- (void)handlerDidStartWork:(id)handler;
- (void)handlerDidFinishWork:(id)handler;
- (void)handlerDidBecomeFree:(id)handler;

@end
