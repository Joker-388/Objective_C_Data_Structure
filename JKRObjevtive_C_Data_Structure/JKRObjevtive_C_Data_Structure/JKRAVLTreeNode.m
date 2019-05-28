//
//  JKRAVLTreeNode.m
//  TreeDemo
//
//  Created by Joker on 2019/5/20.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import "JKRAVLTreeNode.h"

@implementation JKRAVLTreeNode

- (instancetype)initWithObject:(id)object parent:(JKRBinaryTreeNode *)parent {
    self = [super init];
    self.height = 1;
    self.object = object;
    self.parent = parent;
    return self;
}

- (NSInteger)balanceFactor {
    NSInteger leftHeight = self.left ? ((JKRAVLTreeNode *)self.left).height : 0;
    NSInteger rightHeight = self.right ? ((JKRAVLTreeNode *)self.right).height : 0;
    return leftHeight - rightHeight;
}

- (void)updateHeight {
    NSInteger leftHeight = self.left ? ((JKRAVLTreeNode *)self.left).height : 0;
    NSInteger rightHeight = self.right ? ((JKRAVLTreeNode *)self.right).height : 0;
    self.height = 1 + MAX(leftHeight, rightHeight);
}

- (JKRBinaryTreeNode *)tallerChild {
    NSInteger leftHeight = self.left ? ((JKRAVLTreeNode *)self.left).height : 0;
    NSInteger rightHeight = self.right ? ((JKRAVLTreeNode *)self.right).height : 0;
    if (leftHeight > rightHeight) {
        return self.left;
    }
    if (leftHeight < rightHeight) {
        return self.right;
    }
    return self.isLeftChild ? self.left : self.right;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ (p:%@) (h:%zd)", self.object, self.parent.object, self.height];
}

@end
