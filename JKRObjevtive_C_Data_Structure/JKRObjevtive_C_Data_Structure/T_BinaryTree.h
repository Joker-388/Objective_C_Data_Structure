//
//  T_BinaryTree.h
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/6/12.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface T_BinaryTreeNode : NSObject

@property (nonatomic, strong, nonnull) id object;
@property (nonatomic, strong, nullable) T_BinaryTreeNode *left;
@property (nonatomic, strong, nullable) T_BinaryTreeNode *right;
@property (nonatomic, weak, nullable) T_BinaryTreeNode *parent;

- (instancetype)initWithObject:(nonnull id)object parent:(nullable T_BinaryTreeNode *)parent;

@end

@interface T_BinaryTree : NSObject {
@protected
    NSUInteger _size;
    T_BinaryTreeNode *_root;
}

@end

NS_ASSUME_NONNULL_END
