import SwiftUI

let menu = [
    MenuItem(category: "starters", name: "Caprese Salad", spicy: false, price: 3.0),
    MenuItem(category: "starters", name: "Arancini Balls", spicy: false, price: 3.5),
    MenuItem(category: "pastas", name: "Penne all'Arrabbiata", spicy: true, price: 8.0),
    MenuItem(category: "pastas", name: "Spaghetti Carbonara", spicy: false, price: 9.0),
    MenuItem(category: "drinks", name: "Water", spicy: false, price: 1.5),
    MenuItem(category: "drinks", name: "Red Wine", spicy: false, price: 4.5),
    MenuItem(category: "desserts", name: "Tiramisù", spicy: false, price: 5.0),
    MenuItem(category: "desserts", name: "Crema Catalana", spicy: false, price: 4.5)
]

@main
struct AlbertosApp: App {
    
    let orderController = OrderController()
    
    var body: some Scene {
        WindowGroup {
            ZStack(alignment: .bottom) {
                NavigationView {
                    MenuList(viewModel: .init(menuFetching: MenuFetchingPlaceholder()))
                        .navigationTitle("Alberto's 🇮🇹")
                }
                OrderButton(viewModel: .init())
                    .padding(6)
            }
            .environmentObject(orderController)
        }
    }
    
    func numbers(a: Double...) {
        var test = ["a", "b","c"]
        
        test.sorted(by: <)
    }
}


