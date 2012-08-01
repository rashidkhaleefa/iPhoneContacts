//
//  ContactsViewController.h
//  Contacts
//
//  Created by Rashid_Macmini on 7/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import "JSON.h"
#import "fetchContacts.h"
@interface ContactsViewController : UIViewController {
    
	NSMutableDictionary *appPrefDict;
   
	NSString   *prefDictFilePath;
}

@property (nonatomic, retain) NSMutableDictionary *appPrefDict;

@property (nonatomic,retain) NSString   *prefDictFilePath;

-(NSMutableDictionary*) deviceContactsDictionary;

@end

