import SwiftUI

struct BoardView: View {
    
    struct Tile: Equatable, Hashable, Identifiable {
        
        let value: Int
        let x: Int
        let y: Int
        
        var id: Int { value }
    }
    
    @State var board = Board(size: 4)
    
    static let spacing: Length = 5
    
    var tiles: [Tile] {
        
        let size = board.size
        
        return board.tiles.enumerated().filter({ $0.1 != 0 }).map { offset, value in
            Tile(value: value, x: offset % size, y: offset / size)
        }
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ForEach(self.tiles) { tile in
                    TileView(tile: tile, size: self.tileSize(from: geometry.size))
                    .tapAction {
                        withAnimation(.basic(duration: 0.2, curve: .easeOut)) {
                            self.board.move(number: tile.value)
                        }
                    }
                    .position(
                        x: self.tilePosition(forIndex: tile.x, boardSize: geometry.size),
                        y: self.tilePosition(forIndex: tile.y, boardSize: geometry.size)
                    )
                }
                .aspectRatio(.init(1), contentMode: .fit)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }.padding()
        }
    }
    
    private func tilePosition(forIndex index: Int, boardSize: CGSize) -> Length {
        let size = tileSize(from: boardSize)
        return Length(index) * (size + BoardView.spacing) + 0.5 * size
    }
    
    private func tileSize(from boardSize: CGSize) -> Length {
        let numberOfTiles = Length(board.size)
        let lengthOfSpaces = (numberOfTiles - 1) * Self.spacing
        let boardLength = min(boardSize.width, boardSize.height)
        return (boardLength - lengthOfSpaces) / numberOfTiles
    }
}

struct TileView: View {
    
    let tile: BoardView.Tile
    let size: Length
    
    var body: some View {
        Text("\(tile.value)")
            .frame(width: size, height: size)
            .background(Color.blue)
            .cornerRadius(min(10, size / 10))
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        BoardView()        
    }
}
#endif
