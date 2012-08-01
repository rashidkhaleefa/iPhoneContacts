//
//  ContactsViewController.m
//  Contacts
//
//  Created by Rashid_Macmini on 7/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ContactsViewController.h"

@implementation ContactsViewController
@synthesize appPrefDict = _appPrefDict;
@synthesize prefDictFilePath = _prefDictFilePath;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

-(NSMutableDictionary*) deviceContactsDictionary
{
		// Initialization ABAddressBook here.
    NSMutableDictionary *contacts = [NSMutableDictionary dictionary];
		// Fetch the address book 
	
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
    
    NSLog(@"contacts = %@",contacts);
    return contacts;
}


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	
    //initialte the class
    
    fetchContacts *contactCls = [[fetchContacts alloc]init];
   //gets the contact dictionary 
    NSMutableDictionary* contactlist =  [contactCls rertieveContactsDictionary];
    
    //gets the joson string of contacts in device
    NSString *contactstring = [contactCls retrieveContactsJason];
    
    NSLog(@"the retrieved contacts and joson are : %@  %@", contactlist,contactstring);
    

    
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
