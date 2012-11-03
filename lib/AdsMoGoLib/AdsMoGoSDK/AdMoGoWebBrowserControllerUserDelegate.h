//
//  AdMoGoWebBrowserControllerDelegate.h
//  AdsMogo
//
//  Created by MOGO on 12-6-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AdMoGoWebBrowserControllerUserDelegate <NSObject>
/*
    浏览器将要展示
 */
- (void)webBrowserWillAppear;

/*
    浏览器已经展示
 */
- (void)webBrowserDidAppear;

/*
    浏览器将要关闭
 */
- (void)webBrowserWillClosed;

/*
    浏览器已经关闭
 */
- (void)webBrowserDidClosed;
@end
