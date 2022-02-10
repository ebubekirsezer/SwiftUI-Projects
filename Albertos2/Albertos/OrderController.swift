import Combine
import Foundation

class OrderController: ObservableObject {

    @Published private(set) var order: Order
    private let orderStoring: OrderStoring

    init(orderStoring: OrderStoring = UserDefaults.standard) {
        self.orderStoring = orderStoring
        order = orderStoring.getOrder()
    }

    func isItemInOrder(_ item: MenuItem) -> Bool {
        return order.items.contains { $0 == item }
    }

    func addToOrder(item: MenuItem) {
        order = Order(items: order.items + [item])
    }

    func removeFromOrder(item: MenuItem) {
        let items = order.items
        guard let indexToRemove = items.firstIndex(where: { $0.name == item.name }) else { return }

        let newItems = items.enumerated().compactMap { (index, element) -> MenuItem? in
            guard index == indexToRemove else { return element }
            return .none
        }

        order = Order(items: newItems)
    }
    
    func resetOrder() {
        order = Order(items: [])
    }
    
    private func updateOrder(with newOrder: Order) {
        orderStoring.updateOrder(newOrder)
        order = newOrder
    }
}
