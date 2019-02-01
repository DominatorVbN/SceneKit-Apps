//
//  GameViewController.swift
//  GeometryFighter
//
//  Created by mac on 01/02/19.
//  Copyright © 2019 MMF. All rights reserved.
//
import UIKit
import SceneKit

class GameViewController: UIViewController {
    
    //SCNView is that renders the content of the SCNScene on the display.
    var sceneView : SCNView!
    
    //SCNScene is the scene we want to render on SCNView.
    var scene:SCNScene!
    
    //camera node is the perpective of game's display but it is also a node.
    var cameraNode:SCNNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    func setUI(){
        setView()
        setScene()
        setUpCamera()
        spawnShape()
    }
    func setView(){
        //setting our viewcontroller view as SceneView.
        sceneView = self.view as? SCNView
        
        // showStatistics enables a real-time statistics panel at the bottom of your scene
        sceneView.showsStatistics = true
        
        // allowsCameraControl lets you manually control the active camera through simple gestures.
        sceneView.allowsCameraControl = true
        
        // autoenablesDefaultLighting creates a generic omnidirectional light in your scene
        sceneView.autoenablesDefaultLighting = true
    }
    func setScene(){
        //creating new blank scene.
        scene = SCNScene()
        
        //attaching scene to scene view.
        sceneView.scene = scene
        
        //adding Background_Diffuse.png as background
        scene.background.contents = "GeometryFighter.scnassets/Textures/Background_Diffuse.png"
    }
    func setUpCamera(){
        //creating instance of SCNNode.
        cameraNode = SCNNode()
        
        //attaching new instance of SCNCamera to newly created node
        cameraNode.camera = SCNCamera()
        
        //setting position of camera node w.r.t. its parent node.
        cameraNode.position = SCNVector3(0, 0, 10)
        
        //adding camera node to rootNode of our scene.
        scene.rootNode.addChildNode(cameraNode)
    }
    func spawnShape() {
        // create a placeholder geometry variable
        var geometry:SCNGeometry
        
        // handle the returned shape from ShapeType.random()
        switch ShapeType.random() {
        case .Box:
            geometry = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.0)
        case .Capsule:
            geometry = SCNCapsule(capRadius: 1, height: 2)
        case .Cone:
            geometry = SCNCone(topRadius: 0, bottomRadius: 1, height: 2)
        case .Cylinder:
            geometry = SCNCylinder(radius: 1, height: 2)
        case .Pyramid:
            geometry = SCNPyramid(width: 1, height: 2, length: 3)
        case .Sphere:
            geometry = SCNSphere(radius: 1)
        case .Torus:
            geometry = SCNTorus(ringRadius: 0.25, pipeRadius: 0.25)
        case .Tube:
            geometry = SCNTube(innerRadius: 0.25, outerRadius: 0.5, height: 2)
        }
        
        //  creates an instance of SCNNode named geometryNode.
        let geometryNode = SCNNode(geometry: geometry)
        
        // add the node as a child of the scene’s root node
        scene.rootNode.addChildNode(geometryNode)
    }
}
//NOTE: Each element of your game (such as lights, cameras, geometry, or particle emitters) is called a node and is stored in this tree-like structure.

//NOTE:A Scene Kit camera is represented by SCNCamera, whose xPov and yPov properties let you adjust the field of view, while zNear and zFar let you adjust the viewing frustum.

//NOTE:A geometry object represents a three-dimensional shape and is created of many points known as vertices.
