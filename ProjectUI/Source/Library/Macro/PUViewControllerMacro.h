#define PUDefineBaseViewProperty(propertyName, viewClass) \
@property (nonatomic, readonly) viewClass   *propertyName;

#define PUBaseViewGetterSynthesize(selector, viewClass) \
    - (viewClass *)selector { \
        if ([self isViewLoaded] && [self.view isKindOfClass:[viewClass class]]) { \
        return (viewClass *)self.view; \
        } \
        return nil; \
    }

#define PUViewControllerBaseViewProperty(viewControllerClass, propertyName, baseViewClass) \
    @interface viewControllerClass (__PUPrivateBaseView) \
    PUDefineBaseViewProperty(propertyName, baseViewClass) \
    @end \
    @implementation viewControllerClass (__PUPrivateBaseView) \
    @dynamic propertyName; \
    PUBaseViewGetterSynthesize(propertyName, baseViewClass) \
    @end
