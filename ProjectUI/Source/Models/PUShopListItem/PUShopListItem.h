#import <UIKit/UIKit.h>

#import "PUObservableObject.h"
#import "PUShopListItemObserverProtocol.h"

@interface PUShopListItem : PUObservableObject <PUShopListItemObserverProtocol>
@property (nonatomic, strong)   NSString    *name;

@property (nonatomic, assign, getter=isChecked) BOOL    checked;

- (instancetype)initWithName:(NSString *)name;

@end
