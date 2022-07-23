//
//  ViewController.swift
//  DiceGameSimple
//
//  Created by Boris Dudnik on 16.11.2021.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {
    var user1Score: Int = 0
    var user2Score: Int = 0
    var round: Int = 0
    var roll1: Int = 0
    var roll2: Int = 0
    let seconds = 0.25
    
    var message = ""
      
    let dice = Dice()
    
   //let width = UIScreen.main.bounds.width
  
    
    @IBOutlet var diceCollection: [UIImageView]!
    
    
    @IBOutlet weak var botDice1: UIImageView!
    @IBOutlet weak var botDice2: UIImageView!
    
    @IBOutlet weak var userDice1: UIImageView!
    @IBOutlet weak var userDice2: UIImageView!
    
    @IBOutlet weak var botNUser2Label: UILabel!
    
    @IBOutlet weak var user1Label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        botNUser2Label.isHidden = true
        user1Label.isHidden = true
        
    }

    
    
    @IBOutlet weak var rollButton: UIButton!
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        rollButton.isHidden = true
        
        roll1 = GKRandomSource.sharedRandom().nextInt(upperBound: 6)
        roll2 = GKRandomSource.sharedRandom().nextInt(upperBound: 6)
        
        for i in 0...5 {
            DispatchQueue.main.asyncAfter(deadline: .now() + (seconds * Double(i) )) { [self] in
                userDice1.image = self.dice.diceArray[i]
                userDice2.image = self.dice.diceArray[i]
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
            userDice1.image = dice.diceArray[roll1]
            userDice2.image = dice.diceArray[roll2]
            user1Score += roll1 + roll2 + 2
            user1Label.text = "Your score: \(user1Score)"
            
            user1Label.isHidden = false
            botMove()
        }
    }

    func botMove() {
        roll1 = GKRandomSource.sharedRandom().nextInt(upperBound: 6)
        roll2 = GKRandomSource.sharedRandom().nextInt(upperBound: 6)
          
        
        // animation of rolling cubes
        for i in 0...5 {
            DispatchQueue.main.asyncAfter(deadline: .now() + ((seconds * Double(i) ) + 1 )) { [self] in
                botDice1.image = self.dice.diceArray[i]
                botDice2.image = self.dice.diceArray[i]
                }
        }
        
        // code for dice numbers
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { [self] in
            botDice1.image = dice.diceArray[roll1]
            botDice2.image = dice.diceArray[roll2]
            user2Score += roll1 + roll2 + 2
            botNUser2Label.text = "Opponent score: \(user2Score)"
            botNUser2Label.isHidden = false
            rollButton.isHidden = false
            winnerShow()
        }
    }
    
    func winnerShow() {
        guard user1Score > 100 || user2Score > 100 else { return }
        
        if user1Score > 99 && user2Score < 100 {
            message = "You win!"
        } else if user1Score < 100 && user2Score > 99 {
            message = "You have lose!"
        } else {
            message = "It's draw!"
        }
        
        let alert = UIAlertController(
        title: "Game over",
        message: message,
        preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style:
       .default, handler: nil))
        present(alert, animated: true, completion: nil)
        
        startNewGame()
    }
    
    func startNewGame() {
        botNUser2Label.isHidden = true
        user2Score = 0
        user1Label.isHidden = true
        user1Score = 0
    }
    

    
    
}

