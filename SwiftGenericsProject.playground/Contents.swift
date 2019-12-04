import Foundation

struct CountedSet<Element: Hashable>: ExpressibleByArrayLiteral {
    private var items: [Element: Int] = [:] // Dictionaries being stored
    
    init(arrayLiteral: Element...) {
        for element in arrayLiteral {
            self.insert(element)
        }
    }
    
    mutating func insert(_ item: Element) {
        items[item, default: 0] += 1
    }

    mutating func remove(_ element: Element) -> Int {
        
        guard let count = items[element] else { return 0 }
        items[element] = count - 1
        
        if items[element] == 0 {
            items.removeValue(forKey: element)
        }
        
        return items[element] ?? 0
    }
    
    subscript(_ member: Element) -> Int {
        get {
            return items[member] ?? 0
        }
        
        set {
            // not needed
        }
    }

}

enum Arrow {
    case iron, wooden, elven, dwarvish, magic, silver
}

var aCountedSet = CountedSet<Arrow>()
aCountedSet[.iron] // 0
var myCountedSet: CountedSet<Arrow> = [.iron, .magic, .iron, .silver, .iron, .iron]
myCountedSet[.iron] // 4
myCountedSet.remove(.iron) // 3
myCountedSet.remove(.dwarvish) // 0
myCountedSet.remove(.magic) // 0
