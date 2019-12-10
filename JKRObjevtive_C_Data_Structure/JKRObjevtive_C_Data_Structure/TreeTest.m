//
//  TreeTest.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/12/10.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "TreeTest.h"
#import "JKRRedBlackTree.h"
#import "Person.h"

@implementation TreeTest

- (void)test {
    JKRBinarySearchTree<Person *> *rb = [[JKRRedBlackTree alloc] initWithCompare:^NSInteger(Person *  _Nonnull e1, Person *  _Nonnull e2) {
        return e1.age - e2.age;
    }];
    rb.debugPrint = YES;
    int nums[] = {55,38,80,25,46,76,88,17,33,50,72,74};
    
    NSMutableArray *persons = [NSMutableArray array];
    for (int i = 0; i < sizeof(nums)/sizeof(nums[0]); i++) {
        printf("%d ", nums[i]);
        [persons addObject:[Person personWithAge:nums[i]]];
    }
    printf("\n-------------------------------------------------------------------\n\n\n");
    
    for (Person *person in persons) {
        printf("Add: %zd\n\n", person.age);
        [rb addObject:person];
        printf("--- 最终平衡后结果 ---\n%s\n\n", [rb.description UTF8String]);
        printf("-------------------------------------------------------------------\n\n\n");
    }
    
    for (Person *person in persons) {
        printf("Remove: %zd\n\n", person.age);
        [rb removeObject:person];
        printf("--- 最终平衡后结果 ---\n%s\n\n", [rb.description UTF8String]);
        printf("-------------------------------------------------------------------\n\n\n");
    }
}

@end
