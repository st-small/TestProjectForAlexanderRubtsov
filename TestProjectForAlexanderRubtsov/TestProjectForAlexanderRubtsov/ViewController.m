//
//  ViewController.m
//  TestProjectForAlexanderRubtsov
//
//  Created by Stanly Shiyanovskiy on 30.05.16.
//  Copyright © 2016 Stanly Shiyanovskiy. All rights reserved.
//

#import "ViewController.h"
#import "SiSStudent.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray* students;

@end

@implementation ViewController

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Студенты";
    
    UIBarButtonItem* addingStudent = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                      target:self
                                      action:@selector(actionAdd:)];
    
    
    self.navigationItem.rightBarButtonItems = @[addingStudent];
    
    self.students = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < 5; i++) {
        
        SiSStudent* student = [[SiSStudent alloc] init];
        [self.students addObject:student];
    }
    
}

#pragma mark - === ACTIONS ===

- (void) actionAdd:(UIBarButtonItem*) sender {
    
    SiSStudent* student = [[SiSStudent alloc] init];
    
    [self.students addObject:student];
    
    [self.tableView reloadData];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.students count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                      reuseIdentifier:identifier];
    }
    SiSStudent* student = [self.students objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f", student.grade];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SiSStudent* student = [self.students objectAtIndex:indexPath.row];
    SiSAddStudentViewController* vc = [[SiSAddStudentViewController alloc] init];
    vc.student = student;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
