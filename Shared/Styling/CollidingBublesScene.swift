//
//  CollidingBublesScene.swift
//  Watched It?
//
//  Created by Joe Maghzal on 21/01/2023.
//

import SwiftUI
import SpriteKit
import STools

struct CollidingBubblesView: View {
    var scene: SKScene {
        let scene = CollidingBublesScene()
        scene.size = CGSize(width: screenWidth, height: screenHeight)
        scene.scaleMode = .fill
        return scene
    }
    var body: some View {
        SpriteView(scene: scene)
            .frame(width: screenWidth, height: screenHeight)
            .edgesIgnoringSafeArea(.all)
    }
}

class CollidingBublesScene: SKScene, SKPhysicsContactDelegate {
//MARK: - Properties
    let ballCategory: UInt32 = 0xb0001
    let edgeCategory: UInt32 = 0xb0010
    var nodeCount = 0
//MARK: - Lifecycle
    override func sceneDidLoad() {
        super.sceneDidLoad()
        setUp()
    }
//MARK: - Functions
    func setUp() {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        let edge = SKPhysicsBody(edgeLoopFrom: self.frame)
        edge.friction = 0
        edge.categoryBitMask = edgeCategory
        physicsBody = edge
        initializeNode()
        initializeNode()
        initializeNode()
        initializeNode()
    }
    func initializeNode() {
        let bubbleTexture = SKTexture(imageNamed: "test")
        let bubble = SKSpriteNode(texture: bubbleTexture)
        let bphysicsBody = SKPhysicsBody(circleOfRadius: bubbleTexture.size().height/2)
        bphysicsBody.isDynamic = true
        bphysicsBody.usesPreciseCollisionDetection = true
        bphysicsBody.restitution = 1
        bphysicsBody.friction = 0
        bphysicsBody.angularDamping = 0
        bphysicsBody.linearDamping = 0
        bphysicsBody.categoryBitMask = ballCategory
        bphysicsBody.collisionBitMask = ballCategory | edgeCategory
        bphysicsBody.contactTestBitMask = ballCategory | edgeCategory
        bubble.physicsBody = bphysicsBody
        bubble.position.x = CGFloat(randomize(number: Int(size.width - 40)))
        bubble.position.y = CGFloat(randomize(number: Int(size.height - 40)))
        add(node: bubble)
    }
    func add(node: SKSpriteNode){
        addChild(node)
        node.physicsBody?.applyForce(CGVector(dx: 10, dy: -2))
        nodeCount += 1
    }
    func randomize(number: Int) -> Int{
        return Int(arc4random()) % number
    }
}
