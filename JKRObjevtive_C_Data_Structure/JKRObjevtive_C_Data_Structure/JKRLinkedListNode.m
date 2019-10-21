//
//  JKRLinkedListNode.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/5/28.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRLinkedListNode.h"

@implementation JKRLinkedListNode

- (instancetype)initWithPrev:(JKRLinkedListNode *)prev object:(id)object next:(JKRLinkedListNode *)next {
    self = [super init];
    
    self.object = object;
    self.next = next;
    self.prev = prev;
    
    return self;
}

- (JKRLinkedListNode *)next {
    if (_next) {
        return _next;
    } else {
        return _weakNext;
    }
}

- (NSString *)description {
    NSString *tipString = @"";
    if (_next && _weakNext) {
        tipString = @"E ";
        NSAssert(NO, @"节点指针维护错误");
    } else if (_weakNext) {
        tipString = @"W ";
    }
    
    return [NSString stringWithFormat:@"(W %@) -> %@ -> (%@%@)", self.prev.object, self.object, tipString, self.next.object];
}

- (void)dealloc {
//    NSLog(@"<%@: %p>: %@ dealloc", self.class, self, self.object);
}

@end
