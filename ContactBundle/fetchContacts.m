//
//  fetchContacts.m
//  Contacts
//
//  Created by Rashid on 24/07/12.
//  Copyright 2012 CSS Corp  P Ltd. All rights reserved.
//

#import "fetchContacts.h"

@implementation fetchContacts

@synthesize appPrefDict;
@synthesize prefDictFilePath;
@synthesize contacts;

- (id)init
{
    self = [super init];
    if (self) {
        
        
        contacts = [NSMutableDictionary dictionary];
        
        
        ABAddressBookRef addressBook = ABAddressBookCreate();
		// Search for the person named "Appleseed" in the address book
        CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(addressBook);
		// Display "Appleseed" information if found in the address book 
        NSLog(@"the addressBook retrieved is :%@",people);
        CFMutableArrayRef peopleMutable = CFArrayCreateMutableCopy(kCFAllocatorDefault,
                                                                   CFArrayGetCount(people),
                                                                   people
                                                                   );
        
        CFArraySortValues(peopleMutable,
                          CFRangeMake(0, CFArrayGetCount(peopleMutable)),
                          (CFComparatorFunction) ABPersonComparePeopleByName,
                          (void*) ABPersonGetSortOrdering()
                          ); 
        
        NSArray *sortedAry = (NSArray*) peopleMutable;
        NSLog(@"the addressBook retrieved is :%@",sortedAry);
        ABRecordRef person = nil;
        NSEnumerator *objEnum = [sortedAry objectEnumerator];
        
        while (person = (ABRecordRef)[objEnum nextObject]) {            
            NSLog(@"the person object is :%@", person);
            NSString *name = (NSString*)ABRecordCopyCompositeName(person);            
            
            ABRecordID contID = ABRecordGetRecordID(person);
            
            NSString *dictKey = [NSString stringWithFormat:@"%@ - %d",name,contID];     
            
            ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
            NSArray *phonesNos = (NSArray*) ABMultiValueCopyArrayOfAllValues (phones);    
            
            NSMutableArray *ary = [NSMutableArray array];
            
            NSString *number = nil;
            NSEnumerator *numEnum = [phonesNos objectEnumerator];
            while (number = (NSString*)[numEnum nextObject] ) {
                
                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                
                [dict setObject:number forKey:@"ContactNumber"];
                [dict setObject:name forKey:@"ContactName"];
                [dict setObject:[NSNumber numberWithInt:contID] forKey:@"ContactRecordID"];
                [ary addObject:dict];
            }         
            
            [contacts setObject:ary forKey: dictKey];
        }
       
    }
    
    return self;
}
-(NSMutableDictionary*) rertieveContactsDictionary
{
    return contacts;
}
-(NSString*) retrieveContactsJason
{
    SBJsonWriter *jsonWriter = [SBJsonWriter new];  
	NSString *jsonString = [jsonWriter stringWithObject:contacts];  
	NSLog(@"the json string is : %@", jsonString);  
    return jsonString;
}

@end
