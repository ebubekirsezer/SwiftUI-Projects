import Combine
import HippoPayments
import SwiftUI

extension OrderDetail {
    
    class ViewModel: ObservableObject {
        
        let headerText = "Your Order"
        let menuListItems: [MenuItem]
        let emptyMenuFallbackText = "Add dishes to the order to see them here"
        let totalText: String?
        let onAlertDismiss: () -> Void
        private let paymentProcessor: PaymentProcessing
        private let orderController: OrderController
        private(set) var cancellables = Set<AnyCancellable>()
        
        @Published private(set) var checkoutButtonText = "Checkout Order"
        @Published var alertToShow: Alert.ViewModel?
        
        init(orderController: OrderController,
             onAlertDismiss: @escaping () -> Void,
             paymentProcessor: PaymentProcessing = HippoPaymentsProcessor.init(apiKey: "A1B2C3")) {
            self.orderController = orderController
            self.onAlertDismiss = onAlertDismiss
            self.paymentProcessor = paymentProcessor
            totalText = orderController.order.items.isEmpty
            ? .none
            : "Total: $\(String(format: "%.2f", orderController.order.total))"
            
            menuListItems = orderController.order.items
        }
        
        func checkout() {
            paymentProcessor.process(order: orderController.order)
                .sink { [weak self] completion in
                    guard case .failure = completion else { return }
                    guard let self = self else { return }
                    self.alertToShow = Alert.ViewModel(title: "",
                                                       message: "There's been an error with your order. Please contact a waiter",
                                                       buttonText: "Ok",
                                                       buttonAction: self.onAlertDismiss)
                } receiveValue: { [weak self] _ in
                    guard let self = self else { return }
                    self.alertToShow = Alert.ViewModel(title: "",
                                                       message: "The payment was successful. Your food will be with you shortly.",
                                                       buttonText: "Ok",
                                                       buttonAction: self.onAlertDismiss)
                }
                .store(in: &cancellables)
            
        }
    }
}
