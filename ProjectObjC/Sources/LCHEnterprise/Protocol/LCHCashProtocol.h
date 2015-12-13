#import <Foundation/Foundation.h>

@protocol LCHCashProtocol <NSObject>
@property (nonatomic, readonly) NSUInteger  wallet;
@property (nonatomic, readonly) id          receiver;

- (void)giveMoney:(NSUInteger)money;
- (void)takeMoney:(NSUInteger)money;

- (BOOL)canGiveMoney:(NSUInteger)money;

- (void)addMoneyReceiver:(id)receiver;
- (void)removeMoneyReceiver;

@end
