#import <Foundation/Foundation.h>

#import "LCHCashProtocol.h"

@interface LCHCar : NSObject <LCHCashProtocol>
@property (nonatomic, readwrite, assign, getter=isClean)    BOOL    clean;

+ (instancetype)car;
+ (instancetype)carWithMoney:(NSUInteger)money;

- (instancetype)initWithMoney:(NSUInteger)money;

@end
