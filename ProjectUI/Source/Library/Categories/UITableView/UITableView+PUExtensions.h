#import <UIKit/UIKit.h>

@interface UITableView (PUExtensions)

- (id)cellWithClass:(Class)cls;

- (void)updateWithBlock:(void(^)(UITableView *))block;

@end
