//
//  ViewController.swift
//  SwiftPlayer
//
//  Created by Cesar on 06/04/17.
//  Copyright © 2017. All rights reserved.
//

import UIKit
import AVFoundation
import GameplayKit

final class ViewController: UIViewController {
	
	// MARK: - IBOutles
	
	@IBOutlet weak var coverAlbumImageView: UIImageView!
	@IBOutlet weak var slider: UISlider!
	@IBOutlet weak var displayView: UIView!
	@IBOutlet weak var songNameLabel: UILabel!
	@IBOutlet weak var bandAlbumNameLabel: UILabel!
	@IBOutlet weak var tableView: UITableView!
	
	// MARK: - Properties
	
	fileprivate var audioPlayer = AVAudioPlayer()
	fileprivate var playlist = [Song]()
	fileprivate var songVolume = Float()
	fileprivate var selectedSong: Song!
	
	
	// MARK: - Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()

		createPlaylist()
		selectedSong = playlist[0]
		updateUI()

		do {
			try audioPlayer = AVAudioPlayer(contentsOf: selectedSong.getURL())
			audioPlayer.volume = songVolume
		} catch let error {
			print("⛔️ An error ocurred when loading a song\n❗️\(error.localizedDescription)")
		}

	}
	

	// MARK: - IBActions
	
	@IBAction func play(_ sender: UIButton) {
		if !audioPlayer.isPlaying {
			audioPlayer.play()
		}
	}
	
	
	@IBAction func pause(_ sender: UIButton) {
		if audioPlayer.isPlaying {
			audioPlayer.pause()
		}
	}
	
	
	@IBAction func stop(_ sender: UIButton) {
		audioPlayer.stop()
		audioPlayer.currentTime = 0
	}
	
	
	@IBAction func shuffle(_ sender: UIButton) {
		let randomInt = GKRandomSource.sharedRandom().nextInt(upperBound: playlist.count)
		selectedSong = playlist[randomInt]
		playThis(song: selectedSong)
		tableView.reloadData()
	}
	
	
	@IBAction func volumeChanged(_ sender: UISlider) {
		songVolume = sender.value
		audioPlayer.volume = songVolume
	}
	
	
	// MARK: - Functions
	
	func createPlaylist() {
		playlist.append(Song(name: "Tornado of Souls", albumName: "Megadeth - Rust in Peace", albumArt: "01"))
		playlist.append(Song(name: "Train of Consequences", albumName: "Megadeth - Youthanasia", albumArt: "02"))
		playlist.append(Song(name: "Countdown to Extinction", albumName: "Megadeth - Countdown to Extinction", albumArt: "03"))
		playlist.append(Song(name: "The Emperor", albumName: " Megadeth - Dystopia", albumArt: "04"))
		playlist.append(Song(name: "Dread and the Fugitive Mind", albumName: "Megadeth - The World Needs a Hero", albumArt: "05"))
	}
	
	func playThis(song: Song) {
		do {
			try audioPlayer = AVAudioPlayer(contentsOf: song.getURL())
			audioPlayer.volume = songVolume
			audioPlayer.play()
			
			songNameLabel.text = song.name
			bandAlbumNameLabel.text = song.albumName
			coverAlbumImageView.image = UIImage(named: song.albumArt)	
		} catch let error {
			print("⛔️ An error ocurred when loading a song\n❗️\(error.localizedDescription)")
		}
	}
	
	
	func updateUI() {
		songNameLabel.text = selectedSong.name
		bandAlbumNameLabel.text = selectedSong.albumName
		coverAlbumImageView.image = UIImage(named: selectedSong.albumArt)
		songVolume = slider.value
		
		displayView.layer.cornerRadius = 10
		
		displayView.layer.shadowOffset = CGSize(width: 1, height: 4)
		displayView.layer.shadowOpacity = 0.4
		displayView.layer.shadowRadius = 10
		displayView.clipsToBounds = false

		coverAlbumImageView.layer.cornerRadius = 7
		coverAlbumImageView.clipsToBounds = true
	}
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		selectedSong = playlist[indexPath.row]
		
		playThis(song: selectedSong)
		
		tableView.reloadData()
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return playlist.count
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let song = playlist[indexPath.row]
		let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		configure(cell: cell, with: song)
		
		return cell
	}
	
	
	func configure(cell: UITableViewCell, with song: Song) {
		cell.textLabel?.text = song.name

		if selectedSong.name == song.name {
			cell.imageView?.image = UIImage(named: "headphone")
			cell.textLabel?.textColor = .black
		} else {
			cell.imageView?.image = nil
			cell.textLabel?.textColor = .gray
		}
	}
	
}
