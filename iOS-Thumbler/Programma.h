//
//  Programma.h
//  iOS-Thumbler
//
//  Created by Dominick Swinnen on 12/11/12.
//  Copyright (c) 2012 PHL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Programma : NSObject

-(NSString *) description;

@property (nonatomic, copy) NSString *tijd;
@property (nonatomic, copy) NSString *titel;
@property (nonatomic, copy) NSString *omschrijving;
@property (nonatomic, copy) NSString *rating;
@property bool *seen;

@end
