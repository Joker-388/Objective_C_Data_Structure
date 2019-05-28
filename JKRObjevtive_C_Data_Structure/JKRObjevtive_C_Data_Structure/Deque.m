//
//  Deque.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/5/28.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "Deque.h"
#import "JKRLinkedList.h"

@interface Deque ()

@property (nonatomic, strong) JKRLinkedList *array;

@end

@implementation Deque

- (NSUInteger)count {
    return self.array.count;
}

- (void)enQueueRear:(id)anObject {
    [self.array addObject:anObject];
}

- (id)deQueueRear {
    [self rangeCheck];
    id object = self.array.lastObject;
    [self.array removeLastObject];
    return object;
}

- (void)enQueueFront:(id)anObject {
    [self.array insertObject:anObject atIndex:0];
}

- (id)deQueueFront {
    [self rangeCheck];
    id object = self.array.firstObject;
    [self.array removeFirstObject];
    return object;
}

- (id)front {
    [self rangeCheck];
    return self.array.firstObject;
}

- (id)rear {
    [self rangeCheck];
    return self.array.lastObject;
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
