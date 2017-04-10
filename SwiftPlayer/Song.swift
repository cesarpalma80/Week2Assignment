//
//  Song.swift
//  SwiftPlayer
//
//  Created by Cesar on 07/04/17.
//  Copyright © 2017. All rights reserved.
//

import Foundation

struct Song {
	var name: String
	var albumName: String
	var albumArt: String
	

	func getURL() -> URL {
		return Bundle.main.url(forResource: name, withExtension: "m4a")!
	}
	
}


