//
//  AnotherViewController.swift
//  StarWarTrek
//
//  Created by Arvin San Miguel on 10/19/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class AnotherViewController: UIViewController {
    
    
    @IBOutlet weak var firstChar: UIImageView!
    @IBOutlet weak var secondChar: UIImageView!
    
    var firstImage: UIImage!
    var secondImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        firstChar.image = firstImage
        secondChar.image = secondImage
        addGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func addGesture() {
        
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(drag))
        firstChar.isUserInteractionEnabled = true
        firstChar.addGestureRecognizer(recognizer) 
        let recognizer2 = UIPanGestureRecognizer(target: self, action: #selector(drag))
        secondChar.isUserInteractionEnabled = true
        secondChar.addGestureRecognizer(recognizer2)
        
    }
    
    func drag(_ sender: UIPanGestureRecognizer) {
        
        let point = sender.location(in: self.view)
        let image = sender.view as? UIImageView
        if let image = image {
            image.center = point
        }
        
        if sender.state == .ended {
            if collide() { self.view.backgroundColor = UIColor.gray } else { self.view.backgroundColor = UIColor(red: 175/255.0, green: 8/255.0, blue: 6/255.0, alpha: 1.0) }
        }
        
    }
    
    func collide() -> Bool {
        
        let frame1 = firstChar.frame
        let frame2 = secondChar.frame
        
        return frame1.intersects(frame2)
        
    }
    
    
    
}
