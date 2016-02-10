#import <Foundation/Foundation.h>

@protocol PUFoodListItemObserverProtocol <NSObject>

@optional
- (void)foodListItemModelDidChange:(id)model;

@end
