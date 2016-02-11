#import <Foundation/Foundation.h>

@protocol PUShopListItemObserverProtocol <NSObject>

@optional
- (void)shopListItemModelDidChange:(id)model;

@end
