//
//  HomeViewController.swift
//  Teleporter
//
//  Created by Michael Duong on 4/12/2019.
//  Copyright © 2019 Michael Duong. All rights reserved.
//

import UIKit
import SVProgressHUD
import AVFoundation

// Global audio player variable
var audioPlayer: AVAudioPlayer?

final class HomeViewController: UIViewController {

    // MARK: - Properties and variables
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var rooms = ["left", "center", "right"]
    
    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.separatorInset = .zero
        
        let path = Bundle.main.path(forResource: "bg-music.mp3", ofType: nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print(error)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refresh()
    }
    
    // MARK: - Functions
    private func refresh() {
        SVProgressHUD.show()
        self.tableView.reloadData()
        SVProgressHUD.dismiss()
    }
    
    private func createRoom() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "broadcast")
        present(vc, animated: true, completion: nil)
    }
    
    private func joinRoom(_ streamName: String) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "audience") as! AudienceViewController
        vc.room = streamName
        present(vc, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    @IBAction func newButtonPressed(_ sender: AnyObject) {
        createRoom()
    }
    
    @IBAction func refreshButtonPressed(_ sender: AnyObject) {
        refresh()
    }
}

// MARK: - TableView Delegate & Data Source
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = "Stream: \(rooms[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        joinRoom(rooms[indexPath.row])
    }
    
}

