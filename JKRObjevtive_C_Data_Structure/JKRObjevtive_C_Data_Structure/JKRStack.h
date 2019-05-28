//
//  JKRStack.h
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/5/28.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JKRStack<ObjectType> : NSObject

- (NSUInteger)count;
- (void)push:(nullable ObjectType)anObject;
- (ObjectType)pop;
- (ObjectType)peek;

@end

NS_ASSUME_NONNULL_END
