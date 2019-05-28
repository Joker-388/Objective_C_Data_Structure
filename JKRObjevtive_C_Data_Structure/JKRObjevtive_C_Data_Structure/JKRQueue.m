//
//  JKRQueue.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/5/28.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRQueue.h"
#import "JKRLinkedList.h"

@interface JKRQueue ()

@property (nonatomic, strong) JKRLinkedList *array;

@end

@implementation JKRQueue

- (NSUInteger)count {
    return self.array.count;
}

- (void)enQueue:(id)anObject {
    [self.array addObject:anObject];
}

- (id)deQueue {
    [self rangeCheck];
    id object = self.array.firstObject;
    [self.array removeFirstObject];
    return object;
}

- (id)front {
    [self rangeCheck];
    return self.array.firstObject;
}

- (void)rangeCheck {
    if (self.array.count == 0) {
        NSAssert(NO, @"stack is empty");
    }
}

- (JKRLinkedList *)array {
    if (!_array) {
        _array = [JKRLinkedList new];
    }
    return _array;
}

- (void)dealloc {
//    NSLog(@"<%@: %p>: dealloc", self.class, self);
}

@end
