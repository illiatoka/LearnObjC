#import "LCHAccountant.h"

@implementation LCHAccountant

- (void)performEmployeeSpecificOperationWithPrise:(NSUInteger)price {
    [self.receiver takeMoney:price];
    [self.receiver performEmployeeSpecificOperationWithPrise:price];
}

@end
