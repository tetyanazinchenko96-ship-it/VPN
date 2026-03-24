import Combine
import Foundation

final class RootViewModel: ObservableObject {
    @Published var showSplash = true

    func completeSplash() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            self.showSplash = false
        }
    }
}
