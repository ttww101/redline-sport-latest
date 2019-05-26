#import <Foundation/Foundation.h>
#undef	INTERFACE_SINGLETON
#define INTERFACE_SINGLETON( __class ) \
    - (__class *)sharedInstance; \
    + (__class *)sharedInstance;
#undef	IMPLEMENTATION_SINGLETON
#define IMPLEMENTATION_SINGLETON( __class ) \
    - (__class *)sharedInstance \
    { \
        return [__class sharedInstance]; \
    } \
    + (__class *)sharedInstance \
    { \
        static dispatch_once_t once; \
        static __class * __singleton__; \
        dispatch_once( &once, ^{ __singleton__ = [[[self class] alloc] init]; } ); \
        return __singleton__; \
    }
