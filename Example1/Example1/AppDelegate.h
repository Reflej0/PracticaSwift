//
//  AppDelegate.h
//  Example1
//
//  Created by Juan Tocino on 18/03/2020.
//  Copyright © 2020 Reflejo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentCloudKitContainer *persistentContainer;

- (void)saveContext;


@end

