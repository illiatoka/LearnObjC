#import "UITableView+PUExtensions.h"

#import "UINib+PUExtensions.h"

@implementation UITableView (PUExtensions)

#pragma mark -
#pragma mark Class Methods

- (id)cellWithClass:(Class)class {
    id cell = [self dequeueReusableCellWithIdentifier:NSStringFromClass(class)];
    if (!cell) {
        cell = [UINib objectWithClass:class];
    }
    
    return cell;
}

@end
