//
//  main.swift
//  PropertyAdder
//
//  Created by Joel Pridgen on 12/14/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

import Foundation

print("Howdy")

if let path = ProcessInfo.processInfo.environment["productDir"] {
	
	let isSectors = ProcessInfo.processInfo.environment["isSector"] == "isSector"
	var url = URL.init(fileURLWithPath: path)
	url.deleteLastPathComponent()
	url.appendPathComponent("SHModels")
	url.appendPathComponent("SHModels")
	let fileName = isSectors ? "SectorInfo.plist" : "MonsterInfo.plist"
	url.appendPathComponent(fileName, isDirectory: false)
	
	let parentProps = try NSMutableDictionary(contentsOf: url, error: ())
	for (k, _) in parentProps {
		for (_, v1) in parentProps[k] as! NSMutableDictionary {
			let dict = v1 as! NSMutableDictionary
			dict["test"] = "Test"
		}
	}
	print(parentProps)
	print(url)
}

print("howdy")
//let fm = FileManager.default





