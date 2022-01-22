//
//  MenuItemDetail+ViewModelTests.swift
//  AlbertosTests
//
//  Created by Ebubekir Sezer on 22.01.2022.
//

import XCTest
@testable import Albertos

class MenuItemDetail_ViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testWhenItemInIsInOrderButtonSaysRemove() {
        // Arrange Inputs
        let item = MenuItem.fixture()
        let orderController = OrderController()
        orderController.addToOrder(item: item)
        let viewModel = MenuItemDetail.ViewModel(item: item, orderController: orderController)
        // Act by reading the button text from the ViewModel
        let text = viewModel.addOrRemoveFromOrderButtonText
        XCTAssertEqual(text, "Remove from order")
    }
    
    func testWhenItemIsNotInOrderButtonSaysAdd() {
        let item = MenuItem.fixture()
        let orderController = OrderController()
        let viewModel = MenuItemDetail.ViewModel(item: item, orderController: orderController)
        let text = viewModel.addOrRemoveFromOrderButtonText
        XCTAssertEqual(text, "Add to order")
    }
    
    func testWhenItemIsInOrderButtonActionRemovesIt() {
        let item = MenuItem.fixture()
        let orderController = OrderController()
        orderController.addToOrder(item: item)
        let viewModel = MenuItemDetail.ViewModel(item: item, orderController: orderController)
        viewModel.addOrRemoveFromOrder()
        XCTAssertFalse(orderController.order.items.contains(where: { $0 == item }))
    }
    
    func testWhenItemIsNotInOrderButtonActionAddsIt() {
        let item = MenuItem.fixture()
        let orderController = OrderController()
        let viewModel = MenuItemDetail.ViewModel(item: item, orderController: orderController)
        viewModel.addOrRemoveFromOrder()
        XCTAssertTrue(orderController.order.items.contains(where: { $0 == item }))
    }
}
