@testable import Albertos
import XCTest

class OrderDetailViewModelTests: XCTestCase {

    func testWhenOrderIsEmptyShouldNotShowTotalAmount() {
        let viewModel = OrderDetail.ViewModel(orderController: OrderController())

        XCTAssertNil(viewModel.totalText)
    }

    func testWhenOrderIsNonEmptyShouldShowTotalAmount() {
        let orderController = OrderController()
        orderController.addToOrder(item: .fixture(price: 1.0))
        orderController.addToOrder(item: .fixture(price: 2.3))
        let viewModel = OrderDetail.ViewModel(orderController: orderController)

        XCTAssertEqual(viewModel.totalText, "Total: $3.30")
    }

    func testWhenOrderIsEmptyHasNotItemNamesToShow() {
        let viewModel = OrderDetail.ViewModel(orderController: OrderController())

        XCTAssertEqual(viewModel.menuListItems.count, 0)
    }

    func testWhenOrderIsNonEmptyMenuListItemIsOrderItems() {
        let orderController = OrderController()
        orderController.addToOrder(item: .fixture(name: "a name"))
        orderController.addToOrder(item: .fixture(name: "another name"))
        let viewModel = OrderDetail.ViewModel(orderController: orderController)

        XCTAssertEqual(viewModel.menuListItems.count, 2)
        XCTAssertEqual(viewModel.menuListItems.first?.name, "a name")
        XCTAssertEqual(viewModel.menuListItems.last?.name, "another name")
    }
    
    func testWhenCheckoutButtonTappedStartsPaymentProcessingFlow() {
        // Create an OrderController and add some items to it
        let orderController = OrderController()
        orderController.addToOrder(item: .fixture(name: "name"))
        orderController.addToOrder(item: .fixture(name: "other name"))
        // Create the Spy
        let paymentProcessingSpy = PaymentProcessingSpy()
        let viewModel = OrderDetail.ViewModel(orderController: orderController, paymentProcessor: paymentProcessingSpy)
        viewModel.checkout()
        XCTAssertEqual(paymentProcessingSpy.receivedOrder, orderController.order)
    }
}
