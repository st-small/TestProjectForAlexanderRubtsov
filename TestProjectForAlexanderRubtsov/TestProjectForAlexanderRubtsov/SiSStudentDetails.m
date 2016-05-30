//
//  SiSStudentDetails.m
//  TestProjectForAlexanderRubtsov
//
//  Created by Stanly Shiyanovskiy on 30.05.16.
//  Copyright © 2016 Stanly Shiyanovskiy. All rights reserved.
//

#import "SiSStudentDetails.h"

@interface SiSStudentDetails ()

@property (strong, nonatomic) UITextField* textFieldFirstName;
@property (strong, nonatomic) UITextField* textFieldLastName;
@property (strong, nonatomic) UITextField* textFieldGrade;
@property (assign, nonatomic) BOOL isEditMode;

@end

typedef enum {
    
    SiSTextFieldTypeFirstName,
    SiSTextFieldTypeLastName,
    SiSTextFieldTypeGrade,
    
} SiSTextFieldType;

@implementation SiSStudentDetails

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Редактировать профиль:";
    
    self.labels = @[@"Имя:", @"Фамилия:", @"Оценка:"];
    
    self.placeholders = @[@"Имя студента", @"Фамилия студента", @"Средний балл"];
    
    UIBarButtonItem* editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                target:self
                                                                                action:@selector(actionEdit:)];
    
    self.navigationItem.rightBarButtonItem = editButton;
}

#pragma mark - === ACTIONS ===

- (void) actionInfoChanged:(UITextField*) sender {
    
    switch (sender.tag) {
        case SiSTextFieldTypeFirstName:
            self.student.firstName = sender.text;
            break;
            
        case SiSTextFieldTypeLastName:
            self.student.lastName = sender.text;
            break;
            
        case SiSTextFieldTypeGrade:
            self.student.grade = [sender.text floatValue];
            break;
            
        default:
            break;
    }
    
}

- (void) actionSave:(UIBarButtonItem*) sender {
    
    UIBarButtonItem* editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                target:self
                                                                                action:@selector(actionSave:)];
    [self.navigationItem setRightBarButtonItem:editButton animated:YES];
    
    [self showAlertWhenSave];
}

- (void) showAlertWhenSave {
    
    UIAlertController* alert = [UIAlertController
                                alertControllerWithTitle:@"Сохранить изменения?!"
                                message:@"Ваши изменения сохранятся. Нажмите ""ДА"" для сохранения и возврата или ""НЕТ"" для продолжения редактирования" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"ДА"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         
                                                         [self returnBack];
                                                     }];
    
    UIAlertAction* NopeAction = [UIAlertAction actionWithTitle:@"НЕТ"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           
                                                       }];
    
    [alert addAction:okAction];
    [alert addAction:NopeAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void) actionEdit:(UIBarButtonItem*) sender {
    
    BOOL isEditing = self.tableView.editing;
    
    [self.tableView setEditing:!isEditing animated:YES];
    
    UIBarButtonSystemItem item = UIBarButtonSystemItemEdit;
    
    if (self.tableView.editing) {
        item = UIBarButtonSystemItemDone;
        self.isEditMode = YES;
        [self.textFieldFirstName becomeFirstResponder];
    } else {
        
        [self.textFieldFirstName resignFirstResponder];
        [self.textFieldLastName resignFirstResponder];
        [self.textFieldGrade resignFirstResponder];
        
        self.isEditMode = NO;
    }
    
    UIBarButtonItem* saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                                target:self
                                                                                action:@selector(actionSave:)];
    [self.navigationItem setRightBarButtonItem:saveButton animated:YES];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.labels count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* infoCellsIdentifier = @"infoCell";
        
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:infoCellsIdentifier];
        
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:infoCellsIdentifier];
    }
        
    cell.textLabel.text = [self.labels objectAtIndex:indexPath.row];
        
    // TEXT FIELDS FOR EDITING STUDENT INFO
    
    CGRect cellRect = cell.bounds;
    CGRect tfRect = CGRectMake(cellRect.origin.x+ 150, cellRect.origin.y + 5, cellRect.size.width - 165, cellRect.size.height - 10);
    
    UITextField* tf = [[UITextField alloc] initWithFrame:tfRect];
    [tf setBorderStyle:UITextBorderStyleRoundedRect];
    
    [tf setSpellCheckingType:UITextSpellCheckingTypeNo];
    [tf setAutocorrectionType:UITextAutocorrectionTypeNo];
    
    NSString* tfText = nil;
    switch (indexPath.row) {
        case SiSTextFieldTypeFirstName:
            tfText = self.student.firstName;
            tf.clearButtonMode = UITextFieldViewModeWhileEditing;
            [tf setReturnKeyType:UIReturnKeyNext];
            [tf setAutocapitalizationType:UITextAutocapitalizationTypeWords];
            [tf setKeyboardType:UIKeyboardTypeDefault];
            tf.tag = SiSTextFieldTypeFirstName;
            
            self.textFieldFirstName = tf;
            self.textFieldFirstName.delegate = self;
            break;
            
        case SiSTextFieldTypeLastName:
            tfText = self.student.lastName;
            tf.clearButtonMode = UITextFieldViewModeWhileEditing;
            [tf setReturnKeyType:UIReturnKeyNext];
            [tf setAutocapitalizationType:UITextAutocapitalizationTypeWords];
            [tf setKeyboardType:UIKeyboardTypeDefault];
            tf.tag = SiSTextFieldTypeLastName;
            
            self.textFieldLastName = tf;
            self.textFieldLastName.delegate = self;
            break;
            
        case SiSTextFieldTypeGrade:
            tfText = [NSString stringWithFormat:@"%2.2f", self.student.grade];
            tf.clearButtonMode = UITextFieldViewModeWhileEditing;
            [tf setReturnKeyType:UIReturnKeyDone];
            [tf setAutocapitalizationType:UITextAutocapitalizationTypeNone];
            [tf setKeyboardType:UIKeyboardTypeEmailAddress];
            tf.tag = SiSTextFieldTypeGrade;
            
            self.textFieldGrade = tf;
            self.textFieldGrade.delegate = self;
            break;
            
        default:
            break;
    }
        
        tf.text = tfText;
        tf.placeholder = [self.placeholders objectAtIndex:indexPath.row];
        
        [tf addTarget:self action:@selector(actionInfoChanged:) forControlEvents:UIControlEventEditingChanged];
        
        [cell addSubview:tf];
        
        return cell;
}

#pragma mark - UITextFieldDelegate

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return NO;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    return self.isEditMode ? YES : NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([textField isEqual:self.textFieldGrade]) {
        [textField resignFirstResponder];
        
    } else {
        
        if ([textField isEqual:self.textFieldFirstName]) {
            
            [self.textFieldLastName becomeFirstResponder];
            
        } else {
            
            [self.textFieldGrade becomeFirstResponder];
        }
    }
    
    return NO;
}

- (void) returnBack {
    
    [self.delegate addStudentDetails:self.student];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
