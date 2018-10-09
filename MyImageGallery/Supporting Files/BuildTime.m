//
//  BuildTime.m
//  MyImageGallery
//
//  Created by RGhate on 08/10/18.
//  Copyright © 2018 rghate. All rights reserved.
//

#import "BuildTime.h"

@implementation BuildTime
NSString *compileDate() {
    return [NSString stringWithUTF8String:__DATE__];
}

NSString *compileTime() {
    return [NSString stringWithUTF8String:__TIME__];
}

@end
