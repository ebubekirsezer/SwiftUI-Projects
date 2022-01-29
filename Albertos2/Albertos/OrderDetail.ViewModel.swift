import Combine
import HippoPayments

extension OrderDetail {

    class ViewModel: ObservableObject {

        let headerText = "Your Order"
        let menuListItems: [MenuItem]
        let emptyMenuFallbackText = "Add dishes to the order to see them here"
        let totalText: String?
        private let paymentProcessor: PaymentProcessing
        private let orderController: OrderController
        
        @Published private(set) var checkoutButtonText = "Checkout Order"

        init(orderController: OrderController,
             paymentProcessor: PaymentProcessing = HippoPaymentsProcessor.init(apiKey: "A1B2C3")) {
            self.orderController = orderController
            self.paymentProcessor = paymentProcessor
            totalText = orderController.order.items.isEmpty
                ? .none
                : "Total: $\(String(format: "%.2f", orderController.order.total))"

            menuListItems = orderController.order.items
        }
        
        func checkout() {
            paymentProcessor.process(order: orderController.order)
        }
    }
}
