#import <Foundation/Foundation.h>

@protocol PUCollectionObserver <NSObject>

@optional
- (void)collectionDidChange:(id)collection;
- (void)collection:(id)collection didChangeWithModel:(id)changeModel;

@end
