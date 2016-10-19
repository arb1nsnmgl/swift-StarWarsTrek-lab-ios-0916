//
//  ViewController.swift
//  StarWarTrek
//
//  Created by James Campagno on 10/17/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
  
    @IBOutlet weak var starTrekSV: UIScrollView!
    @IBOutlet weak var starWarsSV: UIScrollView!
    
    var starWarsCharacters = [UIImage]()
    var starTrekCharacters = [UIImage]()
    
    @IBOutlet weak var viewForStarWars: UIView!
    @IBOutlet weak var viewForStarTrek: UIView!
    
    var selectedCharacter = [UIImageView]()
    var isSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        starWarsCharacters = [#imageLiteral(resourceName: "AnakinJedi"), #imageLiteral(resourceName: "LukeSkywalker"),#imageLiteral(resourceName: "HanSolo"), #imageLiteral(resourceName: "Chewbacca")]
        starTrekCharacters = [#imageLiteral(resourceName: "CaptainKirk"), #imageLiteral(resourceName: "Spock"), #imageLiteral(resourceName: "Uhuru"), #imageLiteral(resourceName: "DrMcCoy")]
        setupStarWars()
        setupStarTrek()
        
    }
    
    func setupStarWars() {
        
        for i in 0..<starWarsCharacters.count {
            
            let imageView = UIImageView()
            imageView.image = starWarsCharacters[i]
            imageView.contentMode = .scaleAspectFit
            let xPos = self.starWarsSV.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPos, y: 0.0, width: self.starWarsSV.frame.width, height: self.starWarsSV.frame.height)
            
            //Add TapRecognizer
            let tapped = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
            tapped.numberOfTapsRequired = 2
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapped)
            
            starWarsSV.contentSize.width = starWarsSV.frame.width * CGFloat(i + 1)
            starWarsSV.addSubview(imageView)
            
        }
    
    }
    
    func setupStarTrek() {
        
        for i in 0..<starTrekCharacters.count {
            print(i)
            let imageView = UIImageView()
            imageView.image = starTrekCharacters[i]
            imageView.contentMode = .scaleAspectFit
            let xPos = self.starTrekSV.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPos, y: 0.0, width: self.starTrekSV.frame.width, height: self.starTrekSV.frame.height)
            
            //Add TapRecognizer
            let tapped = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
            tapped.numberOfTapsRequired = 2
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapped)
            
            starTrekSV.contentSize.width = starTrekSV.frame.width * CGFloat(i + 1)
            starTrekSV.addSubview(imageView)
            
        }
        
    }
    
    func imageTapped(_ sender: UITapGestureRecognizer) {
    
        let image = sender.view as! UIImageView
        
        if sender.state == .ended && !isSelected {
            
            image.layer.borderWidth = 5.0
            image.layer.cornerRadius = 5.0
            image.layer.borderColor = UIColor.black.cgColor
            selectedCharacter.append(image)
            isSelected = true
            
        } else {
            
            image.layer.cornerRadius = 5.0
            image.layer.borderWidth = 0.0
            image.layer.borderColor = UIColor.clear.cgColor
            selectedCharacter = selectedCharacter.filter({$0 != image})
            isSelected = false
            
        }
        
        if selectedCharacter.count == 2 {
            performSegue(withIdentifier: "fight", sender: nil)
        }
        
        print("\n")
        print(selectedCharacter)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier != "fight" { return }
        
        if let dest = segue.destination as? AnotherViewController {
            dest.firstImage = selectedCharacter[0].image
            dest.secondImage = selectedCharacter[1].image
        }
        
    }
    
}


