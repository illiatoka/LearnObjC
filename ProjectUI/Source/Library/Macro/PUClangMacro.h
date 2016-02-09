#define PUClangDiagnosticPushExpressionPerformSelectorLeakWarning \
    PUClangDiagnosticPushExpression("clang diagnostic ignored \"-Warc-performSelector-leaks\"")

#define PUClangDiagnosticPushExpression(key) \
    PUClangDiagnosticPush; _Pragma(key);

#define PUClangDiagnosticPopExpression PUClangDiagnosticPop;

#define PUClangDiagnosticPush _Pragma("clang diagnostic push")
#define PUClangDiagnosticPop _Pragma("clang diagnostic pop")
