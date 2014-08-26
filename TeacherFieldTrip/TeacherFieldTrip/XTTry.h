//
//  XTTry.h
//  XeeTourizm
//
//  Created by Morgan Collino on 01/09/13.
//  Copyright (c) 2013 Morgan Collino. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 
        Make a try on a NSDictionary value and return if OK.
 
 */


@interface XTTry : NSObject

+ (NSString *) tryGettingString: (NSDictionary *) dictionary forKey: (NSObject *)key defaultValue: (NSString *) defaultValue;
+ (NSString *) tryGettingString: (NSDictionary *) dictionary forKey: (NSObject *)key;

+ (double) tryGettingDouble: (NSDictionary *) dictionary forKey: (NSObject *)key defaultValue: (double) defaultValue;
+ (double) tryGettingDouble: (NSDictionary *) dictionary forKey: (NSObject *)key;

+ (NSNumber *) tryGettingNumber: (NSDictionary *) dictionary forKey: (NSObject *)key defaultValue: (NSNumber *) defaultValue;
+ (NSNumber *) tryGettingNumber: (NSDictionary *) dictionary forKey: (NSObject *)key;

+ (NSDictionary *) tryGettingDictionary: (NSDictionary *) dictionary forKey: (NSObject *)key defaultValue: (NSDictionary *) defaultValue;
+ (NSDictionary *) tryGettingDictionary: (NSDictionary *) dictionary forKey: (NSObject *)key;

+ (NSArray *) tryGettingArray: (NSDictionary *) dictionary forKey: (NSObject *)key defaultValue: (NSArray *) defaultValue;
+ (NSArray *) tryGettingArray: (NSDictionary *) dictionary forKey: (NSObject *)key;

@end
