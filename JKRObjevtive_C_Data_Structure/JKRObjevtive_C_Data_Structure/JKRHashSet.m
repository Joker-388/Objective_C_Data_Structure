//
//  JKRHashSet.m
//  HashMapSet
//
//  Created by Joker on 2019/5/27.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRHashSet.h"
#import "JKRHashMap.h"

@interface JKRHashSet ()

@property (nonatomic, strong) JKRHashMap *map;

@end

@implementation JKRHashSet

- (NSUInteger)count {
    return self.map.count;
}

- (void)removeAllObjects {
    [self.map removeAllObjects];
}

- (void)removeObject:(id)object {
    [self.map removeObjectForKey:object];
}

- (void)addObject:(id)object {
    [self.map setObject:nil forKey:object];
}

- (BOOL)containsObject:(id)object {
    return [self.map containsKey:object];
}

- (void)enumerateObjectsUsingBlock:(void (^)(id _Nonnull, BOOL * _Nonnull))block {
    [self.map enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        block(key, stop);
    }];
}

- (JKRHashMap *)map {
    if (!_map) {
        _map = [JKRHashMap new];
    }
    return _map;
}

@end
