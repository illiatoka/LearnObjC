#import <Foundation/Foundation.h>

#import "LCHCashProtocol.h"

@interface LCHCar : NSObject <LCHCashProtocol>
@property (nonatomic, readwrite, assign)                    NSUInteger  cash;
@property (nonatomic, readwrite, assign, getter=isClean)    BOOL        clean;

+ (instancetype)car;
+ (instancetype)carWithCash:(NSUInteger)cash;

- (instancetype)initWithCash:(NSUInteger)cash;

@end
