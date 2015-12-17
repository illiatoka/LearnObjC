#import <Foundation/Foundation.h>

@protocol LCHCashProtocol <NSObject>
@property (nonatomic, readonly) NSUInteger          wallet;

- (void)giveMoney:(NSUInteger)money toReceiver:(id<LCHCashProtocol>)receiver;
- (void)takeMoney:(NSUInteger)money;

- (BOOL)canGiveMoney:(NSUInteger)money;

@optional
- (void)giveAllMoneyToReceiver:(id<LCHCashProtocol>)receiver;

@end
