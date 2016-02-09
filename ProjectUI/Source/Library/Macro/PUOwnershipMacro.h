#import "PUClangMacro.h"

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
