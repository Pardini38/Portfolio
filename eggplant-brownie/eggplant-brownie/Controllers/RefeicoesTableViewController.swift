//
//  RefeicoesTableViewController.swift
//  eggplant-brownie
//
//  Created by user on 26/07/22.
//

import UIKit

class RefeicoesTableViewController: UITableViewController, AdicionaRefeicaoDelegate {
    
//MARK: -- Variables
    var refeicoes = [Refeicao(name: "Macarrão", happiness: 4),
                     Refeicao(name: "Pizza", happiness: 3),
                     Refeicao(name: "Comida Japonesa", happiness: 5)]
    
//MARK: -- Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refeicoes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = refeicoes[indexPath.row].name
        return cell
    }
    
    func add(_ refeicao: Refeicao) {
        refeicoes.append(refeicao)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let VC = segue.destination as? ViewController {
            VC.delegate = self
        }
    }
}

