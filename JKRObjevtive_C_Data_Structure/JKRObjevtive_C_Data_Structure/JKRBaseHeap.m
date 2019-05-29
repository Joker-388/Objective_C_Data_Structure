//
//  JKRBaseHeap.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/5/29.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRBaseHeap.h"

@implementation JKRBaseHeap

- (instancetype)init {
    if (self.class == [JKRBaseHeap class]) {
        NSAssert(NO, @"只能使用BaseList的子类");
    }
    self = [super init];
    return self;
}

- (NSUInteger)count {
    return _size;
}

@end
