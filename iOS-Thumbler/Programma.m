//
//  Programma.m
//  iOS-Thumbler
//
//  Created by Dominick Swinnen on 12/11/12.
//  Copyright (c) 2012 PHL. All rights reserved.
//

#import "Programma.h"

@implementation Programma

-(NSString *) description {
    return [NSString stringWithFormat: @"Tijd: %@  Titel: %@  Omschrijving: %@  Rating: %@", _tijd, _titel, _omschrijving, _rating];
}


@synthesize tijd = _tijd;
@synthesize titel = _titel;
@synthesize omschrijving = _omschrijving;
@synthesize rating = _rating;
@synthesize seen = _seen;

@end
