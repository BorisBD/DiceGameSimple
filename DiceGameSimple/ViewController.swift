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
        
    
    
    
    @IBOutlet weak var botDice1: UIImageView!
    @IBOutlet weak var botDice2: UIImageView!
    
    
    
    @IBOutlet weak var userDice1: UIImageView!
    @IBOutlet weak var userDice2: UIImageView!
    
    @IBOutlet weak var botNUser2Label: UILabel!
    
  
    
    @IBOutlet weak var user1Label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        botNUser2Label.isHidden = true
        
        user1Label.isHidden = true
        
    }

    let diceArray = [#imageLiteral(resourceName: "DiceOne"), #imageLiteral(resourceName: "DiceTwo"), #imageLiteral(resourceName: "DiceThree"), #imageLiteral(resourceName: "DiceFour"), #imageLiteral(resourceName: "DiceFive"), #imageLiteral(resourceName: "DiceSix")]
    
    
    @IBOutlet weak var rollButton: UIButton!
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        rollButton.isHidden = true
        //diceImageView1.image = diceArray[Int.random(in: 0...5)]
        roll1 = GKRandomSource.sharedRandom().nextInt(upperBound: 6)
            //Int(arc4random_uniform(5))
        
        roll2 = GKRandomSource.sharedRandom().nextInt(upperBound: 6)
        for i in 0...5 {
            DispatchQueue.main.asyncAfter(deadline: .now() + (seconds * Double(i) )) { [self] in
                userDice1.image = self.diceArray[i]
                userDice2.image = self.diceArray[i]
                //((Double(i) + 1) / 10))
            }
            
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
            userDice1.image = diceArray[roll1]
            userDice2.image = diceArray[roll2]
            user1Score += roll1 + roll2 + 2
            user1Label.text = "Ваш счет: \(user1Score)"
            
            user1Label.isHidden = false
            botMove()
            
        }
        
        
    }
    
    
    func botMove() {
        roll1 = GKRandomSource.sharedRandom().nextInt(upperBound: 6)
            //Int(arc4random_uniform(5))
        
        roll2 = GKRandomSource.sharedRandom().nextInt(upperBound: 6)
          
        
        
        for i in 0...5 {
            DispatchQueue.main.asyncAfter(deadline: .now() + ((seconds * Double(i) ) + 1 )) { [self] in
                botDice1.image = self.diceArray[i]
                botDice2.image = self.diceArray[i]
                }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) { [self] in
            botDice1.image = diceArray[roll1]
            print(roll1)
            print(roll2)
            botDice2.image = diceArray[roll2]
            user2Score += roll1 + roll2 + 2
            botNUser2Label.text = "Счет оппонента: \(user2Score)"
            botNUser2Label.isHidden = false
            rollButton.isHidden = false
            winnerShow()
        }
    }
    
    func winnerShow() {
        guard user1Score > 100 || user2Score > 100 else { return }
        
        if user1Score > 100 && user2Score < 100 {
            
            let alert = UIAlertController(
            title: "Игра окончена",
            message: "Вы победили!",
            preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ясно", style:
           .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else if user1Score < 100 && user2Score > 100 {
            let alert = UIAlertController(
            title: "Игра окончена",
            message: "Вы проиграли!",
            preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ясно", style:
           .default, handler: nil))
            present(alert, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(
            title: "Игра окончена",
            message: "Ничья!",
            preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ясно", style:
           .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
        startNewGame()
    }
    
    func startNewGame() {
        botNUser2Label.isHidden = true
        user2Score = 0
        user1Label.isHidden = true
        user1Score = 0
    }
}

