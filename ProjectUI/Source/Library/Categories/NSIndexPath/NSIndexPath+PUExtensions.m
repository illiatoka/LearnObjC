#import "NSIndexPath+PUExtensions.h"

#import <UIKit/UIKit.h>

@implementation NSIndexPath (PUExtensions)

#pragma mark -
#pragma mark Class Methods

+ (instancetype)indexPathForRow:(NSUInteger)row {
    return [self indexPathForRow:row inSection:0];
}

@end
