//
//  JKRSingleLinkedListNode.h
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/5/28.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JKRSingleLinkedListNode : NSObject

@property (nonatomic, strong, nullable) id object;
@property (nonatomic, weak, nullable) JKRSingleLinkedListNode *weakNext;
@property (nonatomic, strong, nullable) JKRSingleLinkedListNode *next;

- (instancetype)init __unavailable;
+ (instancetype)new __unavailable;
- (instancetype)initWithObject:(nullable id)object next:(nullable JKRSingleLinkedListNode *)next;

@end

NS_ASSUME_NONNULL_END
