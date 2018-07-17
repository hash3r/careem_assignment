//
//  DetachableExt.swift
//  careem_test
//
//  Created by Hnatiuk, Volodymyr on 16.07.18.
//  Copyright © 2018 careem. All rights reserved.
//

import RealmSwift
import Realm

// MARK: Needed to fully detach a Realm object AND its relations out from realm

public protocol DetachableObject: AnyObject {
    func detached() -> Self
}

extension Object: DetachableObject {
    
    public func detached() -> Self {
        let detached = type(of: self).init()
        for property in objectSchema.properties {
            guard let value = value(forKey: property.name) else { continue }
            
            if let detachable = value as? DetachableObject {
                detached.setValue(detachable.detached(), forKey: property.name)
            } else {
                detached.setValue(value, forKey: property.name)
            }
        }
        return detached
    }
}

extension List: DetachableObject {
    
    public func detached() -> List<Element> {
        let result = List<Element>()
        
        forEach {
            if let detachable = $0 as? DetachableObject {
                //swiftlint:disable force_cast
                let detached = detachable.detached() as! Element
                //swiftlint:enable force_cast
                result.append(detached)
            } else {
                result.append($0)
            }
        }
        return result
    }
}
