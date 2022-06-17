func loveCalculator() -> Int{
    return Int.random(in: 0...100)
}

let loveScore : Int = loveCalculator()

switch loveScore {
    case 81...100:
        print("You love each other like Kanye loves Kanye")
    case 41..<81:
        print("You go together like Coke and Mentos")
    case ...40:
        print("You'll be forever alone")
    default:
        print("Out of range")
}
