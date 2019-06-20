//
//  ViewController.swift
//  AR-App
//
//  Created by Harshit Jindal on 17/06/19.
//  Copyright © 2019 Harshit Jindal. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints]
        
//        // Create a new scene
//        let moon = SCNSphere(radius: 0.2)
//        let material = SCNMaterial()
//
//        material.diffuse.contents = UIImage(named: "art.scnassets/8k_moon.jpg")
//        moon.materials = [material]
//
//        let node = SCNNode()
//        node.position = SCNVector3(0, 0.1, -0.5)
//        node.geometry = moon
        
        // Create a new scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
//        let configuration = AROrientationTrackingConfiguration()
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if anchor is ARPlaneAnchor {
            print("Surface Detected")
            let planeAnchor = anchor as! ARPlaneAnchor
            let sofa = SCNScene(named: "art.scnassets/sofa.scn")
            if let sofaNode = sofa?.rootNode.childNode(withName: "sofa", recursively: true) {
                sofaNode.position = SCNVector3(x: planeAnchor.center.x, y: 0, z: planeAnchor.center.z)
                sofaNode.scale = SCNVector3(0.0005, 0.0005, 0.0005)
                sceneView.scene.rootNode.addChildNode(sofaNode)
                print("sofa yayy")
            }
        }
    }
}
