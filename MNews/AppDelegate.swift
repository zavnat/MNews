//
//  AppDelegate.swift
//  MNews
//
//  Created by admin on 28.05.2020.
//  Copyright © 2020 Natali. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
   
    return true
  }

  func applicationWillTerminate(_ application: UIApplication) {
    self.saveContext()
  }

  lazy var persistentContainer: NSPersistentContainer = {
    
      let container = NSPersistentContainer(name: "MNews")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
          if let error = error as NSError? {
         
              fatalError("Unresolved error \(error), \(error.userInfo)")
          }
      })
      return container
  }()


  func saveContext () {
      let context = persistentContainer.viewContext
      if context.hasChanges {
          do {
              try context.save()
          } catch {
          
              let nserror = error as NSError
              fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
          }
      }
  }

}

