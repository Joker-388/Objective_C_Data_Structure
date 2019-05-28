//
//  Deque.h
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/5/28.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Deque<ObjectType> : NSObject

- (NSUInteger)count;
- (void)enQueueRear:(nullable ObjectType)anObject;
- (nullable ObjectType)deQueueRear;
- (void)enQueueFront:(nullable ObjectType)anObject;
- (nullable ObjectType)deQueueFront;
- (nullable ObjectType)front;
- (nullable ObjectType)rear;

@end

NS_ASSUME_NONNULL_END
