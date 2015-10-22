//
//  WebLoadingView.m
//  ChangDu
//
//  Created by Reader on 15/6/5.
//
//

#import "WebLoadingView.h"

static WebLoadingView* g_webLoading = nil;

@implementation WebLoadingView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        NSMutableArray* images = [[NSMutableArray alloc] init];
        for (NSInteger i = 1; i <= 16; i++) {
//            UIImage* img = [UIImage imageNamed:[NSString stringWithFormat:@"%@webLoading/progress_loading_%ld.png", [ReaderGUICtrl getAppResourcePath], (long)i]];
//            [images addObject:img];
        }
        
        UIImage* img = [images objectAtIndex:0];
        CGRect imgRc = frame;
        imgRc.size = img.size;
        imgRc.origin.x = (CGRectGetWidth(frame) - CGRectGetWidth(imgRc))/2;
        imgRc.origin.y = (CGRectGetHeight(frame) - CGRectGetHeight(imgRc))/2;
        
        UIImageView* loadingImageView = [[UIImageView alloc] initWithFrame:imgRc];
        loadingImageView.animationImages = images;
        loadingImageView.animationDuration = 1.6f;
        [self addSubview:loadingImageView];
        [loadingImageView release];
        [images release];
        
        [loadingImageView startAnimating];
    }
    
    return self;
}

+ (void) showWebLoading{
//    if (g_webLoading == nil)
//    {
//        UIView *mainView = AppKeyWindow;
//        if (mainView)
//        {
//            g_webLoading = [[WebLoadingView alloc] initWithFrame:mainView.bounds];
//            [mainView addSubview:g_webLoading];
//            [g_webLoading release];
//            if (![[UIApplication sharedApplication] isIgnoringInteractionEvents])
//                [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
//        }
//    }
}

+ (void)hiddenWebLoading{
    if (g_webLoading)
    {
        [g_webLoading removeFromSuperview];
        g_webLoading = nil;
    }
    
    while ([[UIApplication sharedApplication] isIgnoringInteractionEvents])
    {
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }
}

@end
