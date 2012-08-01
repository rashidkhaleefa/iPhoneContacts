//
//  ContactsAppDelegate.h
//  Contacts
//
//  Created by Rashid_Macmini on 7/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContactsViewController;

@interface ContactsAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ContactsViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ContactsViewController *viewController;

@end

