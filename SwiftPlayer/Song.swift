//
//  Song.swift
//  SwiftPlayer
//
//  Created by Cesar on 07/04/17.
//  Copyright © 2017 Metalbytes. All rights reserved.
//

import Foundation

struct Song {
	var name: String
	var albumName: String
	var albumArt: String
	var isPlaying = false
	
	
	init(name: String, albumName: String, albumArt: String, isPlaying: Bool = false) {
		self.name =  name
		self.albumName = albumName
		self.albumArt =  albumArt
		
	}
	
	func getURL() -> URL {
		return Bundle.main.url(forResource: name, withExtension: "m4a")!
	}
	

}


