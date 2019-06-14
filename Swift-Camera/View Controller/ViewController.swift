//
//  ViewController.swift
//  Swift-Camera
//
//  Created by Tc Pun on 14/6/19.
//  Copyright © 2019 Element 43 Services. All rights reserved.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
    // MARK: Outlet
    @IBOutlet weak var viewCamera: UIView!
    @IBOutlet weak var viewResult: UIImageView!
    @IBOutlet weak var constraintImageHeight: NSLayoutConstraint!
    @IBOutlet weak var constraintImageWidth: NSLayoutConstraint!
    
    // MARK: Camera
    var isFrontCamera = false
    lazy var captureSession = AVCaptureSession()
    lazy var previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
    lazy var sessionQueue = DispatchQueue(label: "SessionQueue")
    lazy var outputQueue = DispatchQueue(label: "OutputQueue")

    var imageOrientation: UIImage.Orientation?
    
    // MARK: - App Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCaptureSessionOutput()
        initCaptureSessionInput()
        
        let rotate: (Notification) -> Void = { _ in self.setRotation() }
        NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main, using: rotate)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startSession()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopSession()
    }
}

