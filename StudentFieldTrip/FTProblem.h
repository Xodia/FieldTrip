//
//  FTProblem.h
//  StudentFieldTrip
//
//  Created by Morgan Collino on 16/11/2013.
//  Copyright (c) 2013 Morgan Collino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTProblem : NSObject
{
    NSString *pb;
    int rate;
}

@property (nonatomic, copy) NSString *pb;
@property (nonatomic) int rate;
@end
