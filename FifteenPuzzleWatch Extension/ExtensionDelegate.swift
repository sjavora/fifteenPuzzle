import WatchKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        backgroundTasks.forEach { $0.setTaskCompletedWithSnapshot(false) }
    }
}
