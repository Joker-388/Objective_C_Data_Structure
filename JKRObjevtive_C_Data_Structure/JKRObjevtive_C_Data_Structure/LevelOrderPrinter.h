//
//  LevelOrderPrinter.h
//  TreeDemo
//
//  Created by Lucky on 2019/5/1.
//  Copyright © 2019 Lucky. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LevelOrderPrinterDelegate <NSObject>

@required
- (id)print_root;
- (id)print_left:(id)node;
- (id)print_right:(id)node;
- (id)print_string:(id)node;

@end

@interface LevelOrderPrinter : NSObject

@property (nonatomic, weak) id<LevelOrderPrinterDelegate> tree;

+ (void)printTree:(id<LevelOrderPrinterDelegate>)tree;
+ (NSString *)printStringWithTree:(id<LevelOrderPrinterDelegate>)tree;
- (instancetype)init __unavailable;
+ (instancetype)new __unavailable;
- (instancetype)initWithTree:(id<LevelOrderPrinterDelegate>)tree;

/// 返回二叉树的字符串
- (NSString *)printString;
/// 打印二叉树
- (void)print;

@end

@interface PrintNode : NSObject

/// 被打印二叉树的原节点
@property (nonatomic, strong) id btNode;
@property (nonatomic, strong) PrintNode *left;
@property (nonatomic, strong) PrintNode *right;
@property (nonatomic, weak) PrintNode *parent;

@property (nonatomic, assign) int x;
@property (nonatomic, assign) int y;
@property (nonatomic, assign) int treeHeight;
@property (nonatomic, strong) NSString *string;
@property (nonatomic, assign) int width;

- (instancetype)init __unavailable;
+ (instancetype)new __unavailable;
- (instancetype)initWithString:(NSString *)string;
- (instancetype)initWithBtNode:(id)btNode tree:(id<LevelOrderPrinterDelegate>)tree;

@end

@interface LevelInfo : NSObject

@property (nonatomic, assign) int leftX;
@property (nonatomic, assign) int rightX;

- (instancetype)init __unavailable;
+ (instancetype)new __unavailable;
- (instancetype)initWithLeft:(PrintNode *)left right:(PrintNode *)right;

@end

NS_ASSUME_NONNULL_END
