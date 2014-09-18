//
//  NetworkParser.swift
//  Neckst
//
//  Created by William Huang on 9/16/14.
//  Copyright (c) 2014 Stanford University. All rights reserved.
//

import Foundation

class NetworkParser {
    
    var eventArray: Array<Dictionary<String, String>> = []
    
    init(){
        println("Network Parser initialized.")
        self.refreshEvents()
    }
    
    func refreshEvents(){
        let urlPath = "http://neckst.herokuapp.com/api/events"
        let url: NSURL = NSURL(string: urlPath)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url, completionHandler: { (data, response, error) -> Void in
            if error != nil{
                println(error.localizedDescription)
            }
            var err: NSError?
            
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            if err != nil{
                println("JSON Error: \(err?.localizedDescription)")
            }
            if let element: Array<Dictionary<String, String>> = jsonResult["events"] as? Array<Dictionary<String, String>>{
                self.eventArray = element
                self.printArray()
            }
        })
        task.resume()
    }
    
    func printArray(){
        for dict: Dictionary<String, String> in self.eventArray{
            println("NEW DICTIONARY: ")
            for (key, value) in dict{
                println("key: \(key), value: \(value)")
            }
        }
    }
}