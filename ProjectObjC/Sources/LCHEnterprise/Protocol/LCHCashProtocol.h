#import <Foundation/Foundation.h>

@protocol LCHCashProtocol <NSObject>
@property (nonatomic, readonly) NSUInteger  cash;
@property (nonatomic, readonly) id          receiver;

- (void)sendCash:(NSUInteger)cash;

@optional
- (BOOL)canPay;

@end
