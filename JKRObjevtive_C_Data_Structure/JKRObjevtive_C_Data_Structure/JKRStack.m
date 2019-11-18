//
//  JKRStack.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/5/28.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRStack.h"
#import "JKRLinkedList.h"
//#import "JKRLinkedCircleList.h"
//#import "JKRSingleLinkedList.h"
//#import "JKRSingleCircleLinkedList.h"
//#import "JKRArrayList.h"

@interface JKRStack ()

@property (nonatomic, strong) JKRBaseList *array;

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

- (JKRBaseList *)array {
    if (!_array) {
        _array = [JKRLinkedList new];
//        _array = [JKRLinkedCircleList new];
//        _array = [JKRSingleLinkedList new];
//        _array = [JKRSingleCircleLinkedList new];
//        _array = [JKRArrayList new];
    }
    return _array;
}

- (NSString *)description {
    NSMutableString *str = [NSMutableString string];
    [str appendString:[NSString stringWithFormat:@"<%@: %p> : %@", self.className, self, _array]];
    return str;
}

- (void)dealloc {
//    NSLog(@"<%@: %p>: dealloc", self.class, self);
}

@end
