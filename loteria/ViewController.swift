//
//  ViewController.swift
//  loteria
//
//  Created by Matheus on 21/06/20.
//  Copyright © 2020 matheusess. All rights reserved.
//

import UIKit

enum GameType: String {
    case sixNum = "Seis números"
    case sevenNum = "Sete números"
    case eightNum = "Oito números"
}

infix operator >=<
func >=< (total:Int, universe:Int) -> [Int] {
    var result: [Int] = []
    while result.count < total {
        let randomNumber = Int(arc4random_uniform(UInt32(universe))+1)
        if !result.contains(randomNumber){
            result.append(randomNumber)
        }
    }
    return result.sorted();
}

class ViewController: UIViewController {

    @IBOutlet weak var lbNumbersQuantity: UILabel!
    @IBOutlet weak var scNumbersQuantity: UISegmentedControl!
    @IBOutlet var ballsSequence: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNumbers(for: .sixNum)
    }
    
    func showNumbers(for type: GameType) {
        lbNumbersQuantity.text = type.rawValue
        var game: [Int] = []
        switch type {
            case .sixNum:
                game = 6>=<60
                ballsSequence[6].isHidden = true
                ballsSequence[7].isHidden = true
                lbNumbersQuantity.text = "Jogo para 6 números"
            case .sevenNum:
                game = 7>=<60
                ballsSequence[6].isHidden = false
                ballsSequence[7].isHidden = true
                lbNumbersQuantity.text = "Jogo para 7 números"
            case .eightNum:
                game = 8>=<60
                ballsSequence[6].isHidden = false
                ballsSequence[7].isHidden = false
                lbNumbersQuantity.text = "Jogo para 8 números"
            
        }
        for (index, game) in game.enumerated() {
            ballsSequence[index].setTitle("\(game)", for: .normal)
        }
    }
    
    @IBAction func generateGame() {
        switch scNumbersQuantity.selectedSegmentIndex {
            case 0:
                showNumbers(for: .sixNum)
            case 1:
                showNumbers(for: .sevenNum)
            default:
                showNumbers(for: .eightNum)
        }
    }
}

