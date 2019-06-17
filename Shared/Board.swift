
struct Board {
    
    let size: Int
    
    // 0 represents empty space
    private(set) var tiles: [Int]
    
    init(size: Int) {
        self.size = max(size, 1)
        
        tiles = Array(0 ..< size * size).shuffled()
    }
    
    func numberCanBeMoved(_ number: Int) -> Bool {
        
        let tileIndex = tiles.firstIndex(of: number)!
        let indexOfZero = tiles.firstIndex(of: 0)!
        
        return indexOfZero == tileIndex - size
            || indexOfZero == tileIndex + size
            || (indexOfZero == tileIndex + 1 && indexOfZero % size > 0)
            || (indexOfZero == tileIndex - 1 && indexOfZero % size < size - 1)
    }
    
    mutating func move(number: Int) {
        
        guard numberCanBeMoved(number) else { return }
        
        let tileIndex = tiles.firstIndex(of: number)!
        let indexOfZero = tiles.firstIndex(of: 0)!
        
        tiles.swapAt(indexOfZero, tileIndex)
    }
}
