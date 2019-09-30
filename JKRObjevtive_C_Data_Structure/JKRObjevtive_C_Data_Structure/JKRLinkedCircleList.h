//
//  JKRLinkedCircleList.h
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/5/28.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRBaseList.h"
#import "JKRLinkedListNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface JKRLinkedCircleList<ObjectType> : JKRBaseList<ObjectType> {
@public
    JKRLinkedListNode *_first;
    JKRLinkedListNode *_last;
}

@end

NS_ASSUME_NONNULL_END
