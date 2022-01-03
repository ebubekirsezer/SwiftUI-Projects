/// Copyright (c) 2022 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct FlightSearchDetails: View {
    var flight: FlightInformation
    @EnvironmentObject var lastFlightInfo: AppEnvironment
    @Binding var showModal: Bool
    @State private var rebookAlert = false
    @State private var checkInFlight: CheckInInfo?
    @State private var showCheckIn = false
    @State private var showFlightHistory = false
    
    var body: some View {
        ZStack {
            Image("background-view")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            VStack(alignment: .leading) {
                HStack {
                    FlightDetailHeader(flight: flight)
                    Spacer()
                    Button("Close") {
                        showModal = false
                    }
                }
                
                if flight.status == .canceled {
                    Button("Rebook Flight") {
                        rebookAlert = true
                    }
                    .alert("Contact your Airline", isPresented: $rebookAlert, actions: {
                        Button("OK", role: .cancel) {
                            
                        }
                    }, message: {
                        Text("We cannot rebook this flight, Please contact the airline to reschedule this flight")
                    })
                }
                
                if flight.isCheckInAvailable {
                    
                    
                    Button("Check In for flight") {
                        checkInFlight = CheckInInfo(airline: flight.airline, flight: flight.number)
                        showCheckIn = true
                    }
                    .alert("Check In", isPresented: $showCheckIn, presenting: checkInFlight, actions: { checkIn in
                        Button("Check In") {
                            print("Check in for \(checkIn.airline)" + "Flight \(checkIn.flight)")
                        }
                        
                        Button("Reschedule", role: .destructive) {
                            print("Reschedule flight")
                        }
                        
                        Button("Not Now", role: .cancel) {
                            
                        }
                    }, message: { checkIn in
                        Text("Check in for \(checkIn.airline)" + "Flight \(checkIn.flight)")
                    })
                    
//                    Button("Check in for flight") {
//                        checkInFlight = CheckInInfo(airline: flight.airline, flight: flight.number)
//                    }
//                    .actionSheet(item: $checkInFlight) { checkIn in
//                        ActionSheet(title: Text("Check In"),
//                                    message: Text("Check in for \(checkIn.airline)" + "Flight \(checkIn.flight)"),
//                                    buttons: [
//                                        .cancel(Text("Not Now")),
//                                        .destructive(Text("Reschedule"), action: {
//                                            print("Reschedule flight")
//                                        }),
//                                        .default(Text("Check ın"), action: {
//                                            print("Check in for \(checkIn.airline) \(checkIn.flight)")
//                                        })
//                                    ])
//                    }
                }
                
                Button("On-Time History") {
                    showFlightHistory.toggle()
                }
                .popover(isPresented: $showFlightHistory,
                         arrowEdge: .top) {
                    FlightTimeHistory(flight: flight)
                }
                
                FlightInfoPanel(flight: flight)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20.0)
                            .opacity(0.3)
                    )
                Spacer()
            }
            .foregroundColor(.white)
            .padding()
        }
        .onAppear {
            lastFlightInfo.lastFlightId = flight.id
        }
        .interactiveDismissDisabled()
    }
}

struct FlightSearchDetails_Previews: PreviewProvider {
    static var previews: some View {
        FlightSearchDetails(flight: FlightData.generateTestFlight(date: Date()),
                            showModal: .constant(true))
            .environmentObject(AppEnvironment())
    }
}
