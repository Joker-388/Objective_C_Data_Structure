//
//  ArrayListTest.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/12/10.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "ArrayListTest.h"
#import "JKRArray.h"
#import "JKRArrayList.h"

@implementation ArrayListTest

- (void)test {
    [self testArrayList];
}

- (void)testArray {
    JKRArray *array = [JKRArray arrayWithLength:10];
    NSLog(@"%@", array);
    for (NSInteger i = 0; i < array.length; i++) {
        array[i] = [NSNumber numberWithInteger:i * 2];
    }
    NSLog(@"%@", array);
    array[3] = nil;
    array[8] = nil;
    NSLog(@"%@", array);
}

- (void)testArrayList {
    JKRArrayList<NSObject *> *array = [JKRArrayList new];
    NSLog(@"%@", array);
    for (NSInteger i = 0; i < 10; i++) {
        [array addObject:[NSNumber numberWithInteger:i]];
    }
    NSLog(@"%@", array);
    [array insertObject:@"Jack" atIndex:3];
    [array insertObject:nil atIndex:3];
    NSLog(@"%@", array);
    [array removeFirstObject];
    NSLog(@"%@", array);
}

@end
