//
//  BuildTime.h
//  MyImageGallery
//
//  Created by RGhate on 08/10/18.
//  Copyright © 2018 rghate. All rights reserved.
//
#import <Foundation/Foundation.h>

#ifndef BuildTime_h
#define BuildTime_h

@interface BuildTime: NSObject

NSString *compileDate(void);

NSString *compileTime(void);

@end

#endif /* BuildTime_h */
