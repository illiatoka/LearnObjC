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

- (void)updateWithBlock:(void(^)(UITableView *))block {
    if (block) {
        [self beginUpdates];
        block(self);
        [self endUpdates];
    }
}

- (void)updateWithBlock:(void(^)(UITableView *))block completion:(void(^)(UITableView *))completion {
    [self updateWithBlock:block];
    
    if (completion) {
        completion(self);
    }
}

@end
