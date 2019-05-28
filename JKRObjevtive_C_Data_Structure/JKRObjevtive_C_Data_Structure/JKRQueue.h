//
//  JKRQueue.h
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/5/28.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JKRQueue<ObjectType> : NSObject

- (NSUInteger)count;
- (void)enQueue:(nullable ObjectType)anObject;
- (ObjectType)deQueue;
- (ObjectType)front;

@end

NS_ASSUME_NONNULL_END
