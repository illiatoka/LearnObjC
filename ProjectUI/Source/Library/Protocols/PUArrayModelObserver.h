#import <Foundation/Foundation.h>

@protocol PUArrayModelObserver <NSObject>

@optional
- (void)arrayModelDidChange:(id)model;
- (void)arrayModel:(id)model didChangeWithModel:(id)changeModel;

@end
