//
//  SRUITesting.m
//  SwiftRadio
//
//  Created by Joe McMahon on 7/16/18.
//  Copyright © 2018 matthewfecher.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@implementation SRUITesting : NSObject
+ (BOOL) isUITest {
#ifdef DEBUG
    return [[NSProcessInfo processInfo].environment hasKey:@"UITest"];
#else
    return NO;
#endif
}

@end
