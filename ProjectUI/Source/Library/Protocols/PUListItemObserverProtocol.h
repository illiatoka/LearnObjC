#import <Foundation/Foundation.h>

@protocol PUListItemObserverProtocol <NSObject>

@optional
- (void)listItemModelDidChange:(id)model;

@end
