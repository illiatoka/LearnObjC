#import "UITableView+PUExtensions.h"

#import "UINib+PUExtensions.h"

@implementation UITableView (PUExtensions)

#pragma mark -
#pragma mark Public

- (id)cellWithClass:(Class)cls {
    id cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass(cls)];
    if (!cell) {
        cell = [UINib objectWithClass:cls];
    }
    
    return cell;
}

@end
