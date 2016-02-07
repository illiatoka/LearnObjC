#import "PUTableViewCell.h"

@implementation PUTableViewCell

#pragma mark -
#pragma mark Accessors

- (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

@end
