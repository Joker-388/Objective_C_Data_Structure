//
//  JKRRedBlackTreeNode.m
//  TreeDemo
//
//  Created by Joker on 2019/5/20.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import "JKRRedBlackTreeNode.h"

@implementation JKRRedBlackTreeNode

- (instancetype)initWithObject:(id)object parent:(JKRBinaryTreeNode *)parent {
    self = [super init];
    self.object = object;
    self.parent = parent;
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@%@", self.color == RBT_Color_RED ? @"R_" : @"", self.object];
}

@end
