#import "LCHManager.h"

@implementation LCHManager

#pragma mark -
#pragma mark Public Implementations

- (void)performEmployeeSpecificOperationWithPrice:(NSUInteger)price {
    NSLog(@"Last income is: %lu", price);
    NSLog(@"Wallet count is: %lu", self.wallet);
}

@end
