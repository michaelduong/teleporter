//
//  BroadcasterViewController.swift
//  Teleporter
//
//  Created by Michael Duong on 4/12/2019.
//  Copyright © 2019 Michael Duong. All rights reserved.
//

import UIKit
import LFLiveKit
import SVProgressHUD

final class BroadcasterViewController: UIViewController {
    
    // MARK: - Properties and variables
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var inputTitleOverlay: UIVisualEffectView!
    @IBOutlet weak var inputContainer: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var closeButton: DesignableButton!
    
    // Configure back camera with default stream settings
    lazy var session: LFLiveSession = {
        let audioConfiguration = LFLiveAudioConfiguration.default()
        let videoConfiguration = LFLiveVideoConfiguration.defaultConfiguration(for: .medium3)
        
        let session = LFLiveSession(audioConfiguration: audioConfiguration, videoConfiguration: videoConfiguration)!
        session.delegate = self
        session.captureDevicePosition = .back
        DispatchQueue.main.async {
            session.preView = self.previewView
        }
        return session
    }()

    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.isHidden = true
        SVProgressHUD.show()
        setupTapGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AppUtility.lockOrientation(.landscapeLeft, andRotateTo: .landscapeLeft)
        audioPlayer?.stop()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        session.running = true
        SVProgressHUD.dismiss()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        session.running = false
        stop()
        AppUtility.lockOrientation(.all)
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Functions
    // Starts the stream session and chooses the stream source
    private func start() {
        let stream = LFLiveStreamInfo()
        switch segmentControl.selectedSegmentIndex {
        case 0:
            stream.url = "\(Config.rtmpPushUrl)/left"
            session.muted = true
        case 1:
            stream.url = "\(Config.rtmpPushUrl)/center"
        case 2:
            stream.url = "\(Config.rtmpPushUrl)/right"
            session.muted = true
        default:
            break
        }
        session.startLive(stream)

    }
    
    // Stops and deallocates the stream session
    private func stop() {
        session.stopLive()
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeButtonPressed(_:)))
        tapGesture.numberOfTapsRequired = 2
        inputTitleOverlay.addGestureRecognizer(tapGesture)
        previewView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Actions
    @IBAction func startButtonPressed(_ sender: AnyObject) {
        start()
        UIView.animate(withDuration: 0.2, animations: {
            self.inputTitleOverlay.alpha = 0
        }, completion: { finished in
            self.inputTitleOverlay.isHidden = true
        })
    }
    
    @IBAction func closeButtonPressed(_ sender: AnyObject) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - LFTeleporterSession Delegate Methods
extension BroadcasterViewController: LFLiveSessionDelegate {
    
    func liveSession(_ session: LFLiveSession?, liveStateDidChange state: LFLiveState) {
        switch state {
        case .error:
            statusLabel.text = "error"
        case .pending:
            statusLabel.text = "pending"
        case .ready:
            statusLabel.text = "ready"
        case.start:
            statusLabel.text = "start"
        case.stop:
            statusLabel.text = "stop"
        case .refresh:
            statusLabel.text = "refresh"
        }
    }
    
    func liveSession(_ session: LFLiveSession?, debugInfo: LFLiveDebug?) {
        
    }
    
    func liveSession(_ session: LFLiveSession?, errorCode: LFLiveSocketErrorCode) {
        print("error: \(errorCode)")
        
    }
}

