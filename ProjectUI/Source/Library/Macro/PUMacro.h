// ARC Ownership Macro

#define PUClangDiagnosticPush _Pragma("clang diagnostic push")
#define PUClangDiagnosticPop _Pragma("clang diagnostic pop")

#define PUClangDiagnosticPushExpression(key) \
    PUClangDiagnosticPush; _Pragma(key);

#define PUClangDiagnosticPopExpression PUClangDiagnosticPop;

#define PUWeakify(variable) \
    __weak __typeof(variable) __PUWeakified_##variable = variable

#define PUStrongify(variable) \
    PUClangDiagnosticPushExpression("clang diagnostic ignored \"-Wshadow\"") \
    __strong __typeof(variable) variable = __PUWeakified_##variable \
    PUClangDiagnosticPopExpression

#define PUStrongifyAndReturnResultIfNil(variable, result) \
    PUStrongify(variable) \
    if (!variable) { \
        return result; \
    }

#define PUStrongifyAndReturnIfNil(variable) \
    PUStrongifyAndReturnResultIfNil(variable, PUEmptyResult)

#define PUStrongifyAndReturnNilIfNil(variable) \
    PUStrongifyAndReturnResultIfNil(variable, nil)

#define PUEmptyResult

// Base View for View Controller Macro

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
