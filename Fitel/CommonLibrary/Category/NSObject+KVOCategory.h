//
//  NSObject+KVOCategory.h
//  iLunch
//
//  Created by James on 5/16/14.
//  Copyright (c) 2014 James. All rights reserved.
//

#import <Foundation/Foundation.h>

//@protocol KVOCategoryProtocol <NSObject>
//
//
//
//@end


@interface NSObject (KVOCategory)


- (void)observedBy:(NSObject *)observer forKeyPaths:(NSArray *)keyPaths;

- (void)observedBy:(NSObject *)observer forKeyPaths:(NSArray *)keyPaths options:(NSKeyValueObservingOptions)options;

- (void)cancelObservedBy:(NSObject *)observer forKeyPaths:(NSArray *)keyPaths;

@end
