//
//  SiSStident.m
//  40_CoreData_KVC_KVO_DZ_
//
//  Created by Stas on 14.04.16.
//  Copyright © 2016 Stas. All rights reserved.
//

#import "SiSStudent.h"

static NSString* firstNameMale[] = {@"Эммануил", @"Петр", @"Сидор", @"Семен", @"Федор",
                                    @"Степан", @"Олег", @"Андрей", @"Борис", @"Николай",
                                    @"Игорь", @"Иван", @"Владимир", @"Кирилл", @"Максим",
                                    @"Михаил", @"Александр", @"Алексей", @"Павел", @"Роман",
                                    @"Руслан", @"Сергей", @"Станислав", @"Юрий", @"Поликарп"};

static NSString* lastNameMale[] = {@"Абрамов", @"Петров", @"Сидоров", @"Семенов", @"Федоров",
                                    @"Степанов", @"Олегов", @"Андреев", @"Борисов", @"Николаев",
                                    @"Игорев", @"Иванов", @"Владимиров", @"Кириллов", @"Максимов",
                                    @"Михайлов", @"Александров", @"Алексеев", @"Павлов", @"Романов",
                                    @"Русланов", @"Сергеев", @"Станиславов", @"Юрьев", @"Поликарпов"};


@implementation SiSStudent

+ (SiSStudent*)createNewStudent {
    
    SiSStudent* student = [[SiSStudent alloc] init];
    
    student.firstName = firstNameMale[arc4random() % 25];
    
    student.lastName = lastNameMale[arc4random() % 25];
    
    student.grade = ((CGFloat)((arc4random() % 301) + 200)) / 100;
    
    return student;
}

@end
