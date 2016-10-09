//
//  Allergy.swift
//  Epinephrine
//
//  Created by Cole on 10/8/16.
//  Copyright © 2016 MHacks. All rights reserved.
//

import UIKit

class Allergy: NSObject, NSCoding {
    
    // MARK: Properties
    var allergen: String
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("allergies")
    
    // MARK: Types
    struct PropertyKey {
        static let allergenKey = "allergen"
    }
    
    // MARK: Initialization
    init?(allergen: String) {
        // Initialize stored properties.
        self.allergen = allergen
        
        super.init()
        
        // Initialization should fail if there is no name or if the rating is negative.
        if allergen.isEmpty {
            return nil
        }
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(allergen, forKey: PropertyKey.allergenKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let allergen = aDecoder.decodeObjectForKey(PropertyKey.allergenKey) as! String
        
        // Must call designated initializer.
        self.init(allergen: allergen)
    }
}
