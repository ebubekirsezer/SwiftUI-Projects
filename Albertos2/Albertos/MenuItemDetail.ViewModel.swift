import Combine
import HippoAnalytics

extension MenuItemDetail {

    class ViewModel: ObservableObject {

        let name: String
        let spicy: String?
        let price: String

        @Published private(set) var addOrRemoveFromOrderButtonText = ""

        private let item: MenuItem
        private let orderController: OrderController
        private let eventLogging: EventLogging

        private var cancellables = Set<AnyCancellable>()

        init(item: MenuItem, orderController: OrderController, eventLogging: EventLogging = HippoAnalyticsClient(apiKey: "abcd")) {
            self.item = item
            self.orderController = orderController
            self.eventLogging = eventLogging

            name = item.name
            spicy = item.spicy ? "Spicy" : .none
            price = "$\(String(format: "%.2f", item.price))"

            self.orderController.$order
                .sink { [weak self] order in
                    guard let self = self else { return }

                    if (order.items.contains { $0 == self.item }) {
                        self.addOrRemoveFromOrderButtonText = "Remove from order"
                    } else {
                        self.addOrRemoveFromOrderButtonText = "Add to order"
                    }
                }
                .store(in: &cancellables)
        }

        func addOrRemoveFromOrder() {
            if (orderController.order.items.contains { $0 == item }) {
                orderController.removeFromOrder(item: item)
            } else {
                orderController.addToOrder(item: item)
                eventLogging.log(name: "menu_item_ordered", properties: ["item_name": item.name])
            }
        }
        
        func onAppear() {
            eventLogging.log(name: "menu_item_detail_visited", properties: ["item_name": item.name])
        }
    }
}
