//
//  JKRUnionFind_QU_S.h
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/10/25.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRUnionFind_QU.h"
#import "JKRArray.h"

NS_ASSUME_NONNULL_BEGIN

@interface JKRUnionFind_QU_S : JKRUnionFind_QU {
@private
    JKRArray<NSNumber *> *_sizes;
}

@end

NS_ASSUME_NONNULL_END
