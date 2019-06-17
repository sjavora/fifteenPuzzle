import WatchKit
import SwiftUI

class HostingController: WKHostingController<BoardView> {
    
    override var body: BoardView {
        BoardView()
    }
}
