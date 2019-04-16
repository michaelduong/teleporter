
//
//  AudienceViewController.swift
//  Teleporter
//
//  Created by Michael Duong on 4/12/2019.
//  Copyright © 2019 Michael Duong. All rights reserved.
//

import UIKit
import SVProgressHUD

final class AudienceViewController: UIViewController {

    // MARK: - Properties & Variables
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var closeButton: DesignableButton!
    
    var room: String!
    private var player: IJKFFMoviePlayerController!
    
    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.isHidden = true
        SVProgressHUD.show()
        setupVideoStreamPlayer()
        setupTapGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(forName: NSNotification.Name.IJKMPMoviePlayerLoadStateDidChange, object: player, queue: OperationQueue.main, using: { [weak self] notification in
            
            guard let this = self else {
                return
            }
            let state = this.player.loadState
            switch state {
            case IJKMPMovieLoadState.stalled:
                this.statusLabel.text = "Buffering"
            default:
                break
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SVProgressHUD.dismiss()
        audioPlayer?.stop()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player.shutdown()
        NotificationCenter.default.removeObserver(self)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
    
    // MARK: - Functions
    private func setupVideoStreamPlayer() {
        let urlString = Config.rtmpPlayUrl + self.room
        
        player = IJKFFMoviePlayerController(contentURLString: urlString, with: IJKFFOptions.byDefault())
        player.prepareToPlay()
        
        player.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        player.view.frame = previewView.bounds
        previewView.addSubview(player.view)
        
        DispatchQueue.global().async {
            self.player.play()
        }
    }
    
    private func setupTapGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeButtonPressed(_:)))
        tapGesture.numberOfTapsRequired = 2
        previewView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Actions
    @IBAction func closeButtonPressed(_ sender: AnyObject) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
