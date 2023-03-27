//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by user on 20/07/22.
//

import UIKit
//MARK: -- Protocol
protocol AdicionaRefeicaoDelegate {
    func add(_ refeicao: Refeicao)
}

class ViewController: UIViewController {
    
//MARK: -- Outlets
    @IBOutlet weak var labelName: UITextField?
    @IBOutlet weak var labelHappiness: UITextField?
    
//MARK: -- Delegates
    var delegate: RefeicoesTableViewController?
    
//MARK: -- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//MARK: -- Actions
    @IBAction func ActionButtonPressed(_ sender: UIButton) {
        if let happiness = labelHappiness?.text, let name = labelName?.text {
            guard let happinessInt = Int(happiness) else { return }
            let refeicao = Refeicao(name: name, happiness: happinessInt)
            delegate?.add(refeicao)
            navigationController?.popViewController(animated: true)
        }
    }
    
}
