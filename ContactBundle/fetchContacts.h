//
//  fetchContacts.h
//  Contacts
//
//  Created by Rashid on 24/07/12.
//  Copyright 2012 CSS Corp  P Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import "JSON.h"

@interface fetchContacts : NSObject
{
    NSMutableDictionary *appPrefDict;
    
	NSString   *prefDictFilePath;
    
    NSMutableDictionary *contacts;
}

@property (nonatomic, retain) NSMutableDictionary *appPrefDict;
@property (nonatomic,retain) NSString   *prefDictFilePath;
@property (nonatomic,retain) NSMutableDictionary *contacts;

-(NSMutableDictionary*) rertieveContactsDictionary;
-(NSString*) retrieveContactsJason;
@end
