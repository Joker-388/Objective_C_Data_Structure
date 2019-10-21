//
//  JKRSingleLinkedListNode.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/5/28.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRSingleLinkedListNode.h"

@implementation JKRSingleLinkedListNode

- (instancetype)initWithObject:(id)object next:(JKRSingleLinkedListNode *)next {
    self = [super init];
    self.object = object;
    self.next = next;
    return self;
}

- (JKRSingleLinkedListNode *)next {
    if (_next) {
        return _next;
    } else {
        return _weakNext;
    }
}

- (void)dealloc {
//    NSLog(@"<%@: %p>: %@ dealloc", self.class, self, self.object);
}

- (NSString *)description {
    NSString *tipString = @"";
    if (_next && _weakNext) {
        tipString = @"E ";
        NSAssert(NO, @"节点指针维护错误");
    } else if (_weakNext) {
        tipString = @"W ";
    }
    return [NSString stringWithFormat:@"%@ -> (%@%@)", self.object, tipString, self.next.object];
}

@end
