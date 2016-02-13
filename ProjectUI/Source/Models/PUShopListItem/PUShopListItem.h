#import <UIKit/UIKit.h>

#import "PUObservableObject.h"
#import "PUShopListItemObserver.h"

@interface PUShopListItem : PUObservableObject
@property (nonatomic, strong)   NSString    *name;

@property (nonatomic, assign, getter=isChecked) BOOL    checked;

+ (instancetype)shopListItemWithName:(NSString *)name;

- (instancetype)initWithName:(NSString *)name;

@end
