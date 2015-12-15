#import "LCHAccountant.h"

@implementation LCHAccountant

- (void)performEmployeeSpecificOperationWithPrice:(NSUInteger)price {
    [self.receiver takeMoney:price];
    [self.receiver performEmployeeSpecificOperationWithPrice:price];
}

@end
