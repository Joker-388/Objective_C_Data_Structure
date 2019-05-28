//
//  JKRLinkedListNode.h
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/5/28.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JKRLinkedListNode : NSObject

@property (nonatomic, strong, nullable) id object;
@property (nonatomic, weak, nullable) JKRLinkedListNode *weakNext;
@property (nonatomic, strong, nullable) JKRLinkedListNode *next;
@property (nonatomic, weak, nullable) JKRLinkedListNode *prev;

- (instancetype)init __unavailable;
+ (instancetype)new __unavailable;

- (instancetype)initWithPrev:(JKRLinkedListNode *)prev object:(nullable id)object next:(nullable JKRLinkedListNode *)next;

@end

NS_ASSUME_NONNULL_END
