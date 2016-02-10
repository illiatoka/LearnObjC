#import <UIKit/UIKit.h>

#import "PUObservableObject.h"
#import "PUListItemObserverProtocol.h"

@interface PUListItem : PUObservableObject <PUListItemObserverProtocol>
@property (nonatomic, strong)   NSString    *itemText;

@property (nonatomic, getter=isChecked) BOOL    checked;

@end
