struct Cidade {
    let name : String
    var citizens : [String]
    var resources : [String : Int]
    
    init(name: String, citizens: [String], resources: [String: Int]) {
        self.name = name
        self.citizens = citizens
        self.resources = resources
        
    }
    
    func fortify(){
        print("Defesas aumentadas!")
    }
}

var anotherTown = Cidade(name: "Ilha sem nome", citizens: ["Benjamin"], resources: ["Silício" : 109302])

var ghostTown = Cidade(name: "Cidade Fanstasma", citizens: [], resources: ["GNV": 30988])



