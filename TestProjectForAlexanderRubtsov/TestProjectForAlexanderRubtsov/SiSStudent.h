//
//  SiSStident.h
//  40_CoreData_KVC_KVO_DZ_
//
//  Created by Stas on 14.04.16.
//  Copyright © 2016 Stas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SiSStudent : NSObject

@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (assign, nonatomic) CGFloat grade;

+ (SiSStudent*)createNewStudent;

@end
