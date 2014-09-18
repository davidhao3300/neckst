//
//  MapsParser.swift
//  Neckst
//
//  Created by William Huang on 9/18/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

import Foundation

class MapsParser {
    
    class var sharedObj: MapsParser {
        struct Singleton{
            static let mapsParser = MapsParser()
        }
        return Singleton.mapsParser
    }

}