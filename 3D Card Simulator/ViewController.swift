//
//  ViewController.swift
//  3D Card Simulator
//
//  Created by Aneesh Prabu on 29/04/20.
//  Copyright © 2020 Aneesh Prabu. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    var touch: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Weapons", bundle: Bundle.main) {
            configuration.trackingImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 1
            
            print("images Successfully Added")
        }

        // Run the view's session
        sceneView.autoenablesDefaultLighting = true
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let Barrel = sceneView.scene.rootNode.childNode(withName: "Barrel", recursively: true) else { return }
        guard let Boldcarriergroup = sceneView.scene.rootNode.childNode(withName: "Boldcarriergroup", recursively: true) else { return }
        guard let Boldcarrierspring = sceneView.scene.rootNode.childNode(withName: "Boldcarrierspring", recursively: true) else { return }
        guard let Cockinghandle = sceneView.scene.rootNode.childNode(withName: "Cockinghandle", recursively: true) else { return }
        guard let Frontsight = sceneView.scene.rootNode.childNode(withName: "Frontsight", recursively: true) else { return }
        guard let Handle = sceneView.scene.rootNode.childNode(withName: "Handle", recursively: true) else { return }
        guard let Magazine = sceneView.scene.rootNode.childNode(withName: "Magazine", recursively: true) else { return }
        guard let Pistolgrip = sceneView.scene.rootNode.childNode(withName: "Pistolgrip", recursively: true) else { return }
        guard let Rearsight = sceneView.scene.rootNode.childNode(withName: "Rearsight", recursively: true) else { return }
        guard let Stock = sceneView.scene.rootNode.childNode(withName: "Stock", recursively: true) else { return }

        
        
        if touch == false {
            touch = true
            
            Boldcarrierspring.position.y += 0.5
            Boldcarriergroup.position.y += 0.5
            Cockinghandle.position.y += 0.5
            Barrel.position.y += 1.0
            Frontsight.position.y += 1.5
            Handle.position.y += -0.5
            Handle.position.z += -1.0
            Magazine.position.y += -1.0
            Pistolgrip.position.y += -1.0
            Pistolgrip.position.z += 1.0
            Rearsight.position.y += 1.5
            Stock.position.z += 1.5
            
        }
        else {
            touch = false
            Boldcarrierspring.position.y += -0.5
            Boldcarriergroup.position.y += -0.5
            Cockinghandle.position.y += -0.5
            Barrel.position.y += -1.0
            Frontsight.position.y += -1.5
            Handle.position.y += 0.5
            Handle.position.z += 1.0
            Magazine.position.y += 1.0
            Pistolgrip.position.y += 1.0
            Pistolgrip.position.z += -1.0
            Rearsight.position.y += -1.5
            Stock.position.z += -1.5
        }
    }
    
    

    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width,
                                 height: imageAnchor.referenceImage.physicalSize.height)
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0)
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi/2
            
            node.addChildNode(planeNode)
            DispatchQueue.main.async {
                if let mp5Scene = SCNScene(named: "art.scnassets/hk-mp5-ext.scn") {
                    if let mp5Node = mp5Scene.rootNode.childNodes.first {
                        
                        mp5Node.eulerAngles.y = .pi/2
                        mp5Node.position.z = 0.2
                        planeNode.addChildNode(mp5Node)
                    }
                }
            }
        }
        return node
    }
}
