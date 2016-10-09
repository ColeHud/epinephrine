//
//  Scan.swift
//  Epinephrine
//
//  Created by Cole on 10/8/16.
//  Copyright © 2016 MHacks. All rights reserved.
//

import UIKit

class Scan: NSObject, NSCoding {
    
    // MARK: Properties
    var idNumber: String
    
    // MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("scans")
    
    // MARK: Types
    struct PropertyKey {
        static let idNumberKey = "idNumber"
    }
    
    // MARK: Initialization
    init?(idNumber: String) {
        // Initialize stored properties.
        self.idNumber = idNumber
        
        super.init()
        
        // Initialization should fail if there is no name or if the rating is negative.
        if idNumber.isEmpty {
            return nil
        }
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(idNumber, forKey: PropertyKey.idNumberKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let idNumber = aDecoder.decodeObjectForKey(PropertyKey.idNumberKey) as! String
        
        // Must call designated initializer.
        self.init(idNumber: idNumber)
    }

}
