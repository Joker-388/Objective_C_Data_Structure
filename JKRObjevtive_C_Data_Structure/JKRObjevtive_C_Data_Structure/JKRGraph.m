//
//  JKRGraph.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/11/12.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRGraph.h"

@implementation JKRGraph

@end

@implementation JKREdgeInfo

- (NSString *)description {
    NSMutableString *str = [NSMutableString string];
    [str appendString:[NSString stringWithFormat:@"<%@: %p>: [From: %@] -- [To: %@] == [Weight: %@]", self.className, self, self.from, self.to, self.weight]];
    return str;
}

@end


@implementation JKRPathInfo

- (NSString *)description {
    NSMutableString *str = [NSMutableString string];
    [str appendString:[NSString stringWithFormat:@"%@ (\n",  self.weight]];
    for (JKREdgeInfo *edgeInfo in self.edgeInfos) {
        [str appendString:[NSString stringWithFormat:@"   [From: %@] -- [To: %@] == [Weight: %@]\n", edgeInfo.from, edgeInfo.to, edgeInfo.weight]];
    }
    [str appendString:@")"];
    
    return str;
}

@end
