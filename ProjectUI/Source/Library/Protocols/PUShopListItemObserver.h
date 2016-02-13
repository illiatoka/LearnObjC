#import <Foundation/Foundation.h>

@protocol PUShopListItemObserver <NSObject>

@optional
- (void)shopListItemModelDidChange:(id)model;

@end
