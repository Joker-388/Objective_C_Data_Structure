//
//  JKRStack.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/5/28.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRStack.h"
#import "JKRLinkedList.h"

@interface JKRStack ()

@property (nonatomic, strong) JKRLinkedList *array;

@end

@implementation JKRStack

- (NSUInteger)count {
    return self.array.count;
}

- (void)push:(id)anObject {
    [self.array addObject:anObject];
}

- (id)pop {
    [self rangeCheck];
    id object = self.array.lastObject;
    [self.array removeLastObject];
    return object;
}

- (id)peek {
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
