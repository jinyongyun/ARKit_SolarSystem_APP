//
//  ViewController.swift
//  ARKitTest
//
//  Created by jinyong yun on 2/16/24.
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
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        self.makeUNIV()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func makePlanetParent() -> SCNNode {
        let parentNode = SCNNode()
        parentNode.position = SCNVector3(0, 0, -1)
        sceneView.scene.rootNode.addChildNode(parentNode)
        let randomDur = Int.random(in: 20...50)
        let parentRotaion = SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: TimeInterval(randomDur))
        let parentRotationRepeat = SCNAction.repeatForever(parentRotaion)
        parentNode.runAction(parentRotationRepeat)
        return parentNode
    }
    
    func makePlanet( _ radius: Double, _ planetname: String, _ zposition: Float) -> SCNNode {
        // 구 모양을 원하는 반지름의 크기로 생성한다. 행성간 실제 비율을 cm로 환산하여 적용했다.
        let sphere = SCNSphere(radius: radius)
        
        let material = SCNMaterial()
        
        // 추가한 texture 파일을 UIImage로 불러오기만 하면된다.
        // art.scnassets 폴더 안에 있으므로 (/)를 통해 경로를 추가하여 넣어준다.
        material.diffuse.contents = UIImage(named: "art.scnassets/\(planetname).jpeg")
        
        sphere.materials = [material]
        
        let node = SCNNode()
        
        node.position = SCNVector3(x: 0, y: 0, z: zposition)
        
        node.geometry = sphere
        
        let action = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreeToRadians), z: 0, duration: 8)
        let forever = SCNAction.repeatForever(action)
        node.runAction(forever)
        
        return node
    }
    
    
    func makeUNIV() {
        
        let mercuryParentNode = makePlanetParent()
        let venusParentNode = makePlanetParent()
        let earthParentNode = makePlanetParent()
        let marsParentNode = makePlanetParent()
        let jupiterParentNode = makePlanetParent()
        let saturnParentNode = makePlanetParent()
        let uranusParentNode = makePlanetParent()
        let neptuneParentNode = makePlanetParent()
        
        let nodeSun = makePlanet(0.9, "sun", -1)
        let nodeMercury = makePlanet(0.1, "mercury", 5.1)
        let nodeVenus = makePlanet(0.6, "venus", 10.3)
        let nodeEarth = makePlanet(0.7, "earth", 30.4)
        let nodeMars = makePlanet(0.2, "mars", 50.2)
        let nodeJupiter = makePlanet(10.9, "jupiter", 150.0)
        let nodeSaturn = makePlanet(9.1, "saturn", 170.2)
        let nodeUranus = makePlanet(3.7, "uranus", 190.4)
        let nodeNeptune = makePlanet(3.6, "neptune", 210.0)
        
        sceneView.scene.rootNode.addChildNode(nodeSun)
        mercuryParentNode.addChildNode(nodeMercury)
        venusParentNode.addChildNode(nodeVenus)
        earthParentNode.addChildNode(nodeEarth)
        marsParentNode.addChildNode(nodeMars)
        jupiterParentNode.addChildNode(nodeJupiter)
        saturnParentNode.addChildNode(nodeSaturn)
        uranusParentNode.addChildNode(nodeUranus)
        neptuneParentNode.addChildNode(nodeNeptune)
        
        // 배경을 추가하기
        // sceneView 자체의 background에 접근하여 배경을 설정해줌
        sceneView.scene.background.contents = UIImage(named: "art.scnassets/space.jpeg")
        
        
        sceneView.autoenablesDefaultLighting = true
        
        
    }
    

}


extension Int {
    var degreeToRadians: Double { return Double(self) * .pi/180 }
}
