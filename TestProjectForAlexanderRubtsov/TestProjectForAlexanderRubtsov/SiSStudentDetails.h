//
//  SiSStudentDetails.h
//  TestProjectForAlexanderRubtsov
//
//  Created by Stanly Shiyanovskiy on 30.05.16.
//  Copyright © 2016 Stanly Shiyanovskiy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "SiSStudent.h"

@protocol SiSStudentDetailsDelegate;

@interface SiSStudentDetails : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) NSArray* labels;
@property (strong, nonatomic) NSArray* placeholders;
@property (strong, nonatomic) NSMutableArray* textFields;

@property (strong, nonatomic) SiSStudent* student;

@property (weak, nonatomic) id <SiSStudentDetailsDelegate> delegate;

@end

@protocol SiSStudentDetailsDelegate <NSObject>

@required

- (void)addStudentDetails:(SiSStudent*)student;

@end
