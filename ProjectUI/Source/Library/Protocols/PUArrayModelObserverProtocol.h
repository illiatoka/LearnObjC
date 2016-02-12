#import <Foundation/Foundation.h>

@protocol PUArrayModelObserverProtocol <NSObject>

@optional
- (void)arrayModelDidChange:(id)model;

@end
