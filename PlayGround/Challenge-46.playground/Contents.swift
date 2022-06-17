import UIKit

let alfabeto : [String] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "x", "y", "z"]

var senha : String = alfabeto[Int.random(in:0...24)]
let qtd_caracteres = 6

for _ in (0...qtd_caracteres-1) {
    senha += alfabeto[Int.random(in:0...24)]
    
}

print(senha)

