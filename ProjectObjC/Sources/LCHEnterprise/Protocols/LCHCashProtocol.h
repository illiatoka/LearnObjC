#import <Foundation/Foundation.h>

@protocol LCHCashProtocol <NSObject>
@property (nonatomic, readonly) NSUInteger  wallet;

- (void)giveMoney:(NSUInteger)money toReceiver:(id<LCHCashProtocol>)receiver;

- (void)giveMoney:(NSUInteger)money;
- (void)takeMoney:(NSUInteger)money;

@optional
- (void)giveAllMoneyToReceiver:(id<LCHCashProtocol>)receiver;

@end
