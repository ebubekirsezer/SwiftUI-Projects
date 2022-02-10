@testable import Albertos
import XCTest

class OrderDetailViewModelTests: XCTestCase {
    
    let alertDismissDummy: () -> Void = { }
    
    func testWhenOrderIsNonEmptyShouldShowTotalAmount() {
        let orderController = OrderController()
        orderController.addToOrder(item: .fixture(price: 1.0))
        orderController.addToOrder(item: .fixture(price: 2.3))
        let viewModel = OrderDetail.ViewModel(orderController: orderController, onAlertDismiss: {})

        XCTAssertEqual(viewModel.totalText, "Total: $3.30")
    }

    func testWhenOrderIsEmptyHasNotItemNamesToShow() {
        let viewModel = OrderDetail.ViewModel(orderController: OrderController(), onAlertDismiss: {})

        XCTAssertEqual(viewModel.menuListItems.count, 0)
    }

    func testWhenOrderIsNonEmptyMenuListItemIsOrderItems() {
        let orderController = OrderController()
        orderController.addToOrder(item: .fixture(name: "a name"))
        orderController.addToOrder(item: .fixture(name: "another name"))
        let viewModel = OrderDetail.ViewModel(orderController: orderController, onAlertDismiss: {})

        XCTAssertEqual(viewModel.menuListItems.count, 2)
        XCTAssertEqual(viewModel.menuListItems.first?.name, "a name")
        XCTAssertEqual(viewModel.menuListItems.last?.name, "another name")
    }
    
    func testWhenCheckoutButtonTappedStartsPaymentProcessingFlow() {
        // Create an OrderController and add some items to it
        let orderController = OrderController(orderStoring: OrderStoringFake())
        orderController.addToOrder(item: .fixture(name: "name"))
        orderController.addToOrder(item: .fixture(name: "other name"))
        // Create the Spy
        let paymentProcessingSpy = PaymentProcessingSpy()
        let viewModel = OrderDetail.ViewModel(orderController: orderController, onAlertDismiss: {}, paymentProcessor: paymentProcessingSpy)
        viewModel.checkout()
        XCTAssertEqual(paymentProcessingSpy.receivedOrder, orderController.order)
    }
    
    func testWhenPaymentSucceedsUpdatesPropertyToShowConfirmationAlert() {
        let viewModel = OrderDetail.ViewModel(orderController: OrderController(),
                                              onAlertDismiss: {},
                                              paymentProcessor: PaymentProcessingStub(returning: .success(())))
        let predicate = NSPredicate { _, _ in
            viewModel.alertToShow != nil
        }
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: .none)
        viewModel.checkout()
        wait(for: [expectation], timeout: timeoutForPredicateExpectations)
        XCTAssertEqual(viewModel.alertToShow?.title, "")
        XCTAssertEqual(viewModel.alertToShow?.message, "The payment was successful. Your food will be with you shortly.")
        XCTAssertEqual(viewModel.alertToShow?.buttonText, "Ok")
    }
    
    func testWhenPaymentFailsUpdatesPropertyToShowErrorAlert() {
        let viewModel = OrderDetail.ViewModel(orderController: OrderController(),
                                              onAlertDismiss: {},
                                              paymentProcessor: PaymentProcessingStub(returning: .failure(TestError(id: 123))))
        
        let predicate = NSPredicate(block: { _, _ in viewModel.alertToShow != nil })
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: .none)
        viewModel.checkout()
        
        wait(for: [expectation], timeout: timeoutForPredicateExpectations)
        XCTAssertEqual(viewModel.alertToShow?.title, "")
        XCTAssertEqual(viewModel.alertToShow?.message, "There's been an error with your order. Please contact a waiter")
        XCTAssertEqual(viewModel.alertToShow?.buttonText, "Ok")
        
    }
    
    func testWhenPaymentSucceedsDismissingTheAlertRunsTheGivenClosure() {
        var called = false
        let viewModel = OrderDetail.ViewModel(orderController: OrderController(),
                                              onAlertDismiss: { called = true },
                                              paymentProcessor: PaymentProcessingStub(returning: .success(())))
        let predicate = NSPredicate  { _, _ in
            viewModel.alertToShow != nil
        }
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: .none)
        viewModel.checkout()
        wait(for: [expectation], timeout: timeoutForPredicateExpectations)
        viewModel.alertToShow?.buttonAction?()
        XCTAssertTrue(called)
    }
    
    func testWhenPaymentSucceedsDismissingTheAlertResetsTheOrder() {
        // Arrange the input state with a valid order, one that has items
        let orderController = OrderController()
        let viewModel = OrderDetail.ViewModel(orderController: orderController,
                                              onAlertDismiss: {},
                                              paymentProcessor: PaymentProcessingStub(returning: .success(())))
        
        // Perform the checkout and wait for it to succeed
        let predicate = NSPredicate { _, _ in
            viewModel.alertToShow != nil
        }
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: .none)
        viewModel.checkout()
        wait(for: [expectation], timeout: timeoutForPredicateExpectations)
        // Run the alert dismiss code
        viewModel.alertToShow?.buttonAction?()
        // Verify the order has been reset
        XCTAssertTrue(orderController.order.items.isEmpty)
    }
    
    func testWhenOrderIsEmptyShouldNotShowTotalAmount() {
        let viewModel = OrderDetail.ViewModel(orderController: OrderController(orderStoring: OrderStoringFake()),
                                              onAlertDismiss: alertDismissDummy,
                                              paymentProcessor: PaymentProcessingDummy())
        
        XCTAssertNil(viewModel.totalText)
    }
}
