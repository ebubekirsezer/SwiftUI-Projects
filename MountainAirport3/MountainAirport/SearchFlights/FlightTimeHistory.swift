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

struct FlightTimeHistory: View {
    
    var flight: FlightInformation
    
    var timeFormatter: RelativeDateTimeFormatter {
        let rtf = RelativeDateTimeFormatter()
        rtf.unitsStyle = .full
        rtf.dateTimeStyle = .named
        return rtf
    }
    
    let minuteRange = 75.0
    
    func minuteLength(_ minutes: Int, proxy: GeometryProxy) -> CGFloat {
        let pointsPerMinute = proxy.size.width / minuteRange
        return Double(abs(minutes)) * pointsPerMinute
    }
    
    func relativeDate(_ date: Date) -> String {
        return timeFormatter.localizedString(for: date, relativeTo: Date())
    }
    
    func minuteOffset(_ minutes: Int, proxy: GeometryProxy) -> CGFloat {
        let pointsPerMinute = proxy.size.width / minuteRange
        let offset = minutes < 0 ? 15 + minutes : 15
        return CGFloat(offset) * pointsPerMinute
    }
    
    func chartGradient(_ history: FlightHistory) -> Gradient {
        if history.status == .canceled {
            return Gradient(colors: [
                .green,
                .yellow,
                .red,
                Color(red: 0.5, green: 0, blue: 0)
            ])
        }
        
        if history.timeDifference <= 0 {
            return Gradient(colors: [.green])
        }
        
        if history.timeDifference <= 15 {
            return Gradient(colors: [.green, .yellow])
        }
        
        return Gradient(colors: [.green, .yellow, .red])
        
    }
    
    func minuteLocation(_ minutes: Int, proxy: GeometryProxy) -> CGFloat {
        let minMinutes = 15
        let pointsPerMinute = proxy.size.width / minuteRange
        let offset = CGFloat(minutes - minMinutes) * pointsPerMinute
        return offset
    }
    
    var body: some View {
        ZStack {
            Image("background-view")
                .resizable()
                .aspectRatio(contentMode: .fill)
            VStack {
                Text("On Time History for \(flight.statusBoardName)")
                    .font(.title2)
                    .padding(.top, 30)
                
                ScrollView {
                    ForEach(flight.history, id: \.day) { history in
                        
                        HStack {
                            Text("\(history.day) day(s) ago")
                                .padding()
                                .frame(width: 110, alignment: .trailing)
                            
                            GeometryReader { proxy in
                                
                                Rectangle()
                                    .fill(
                                        LinearGradient(gradient: chartGradient(history),
                                                       startPoint: .leading,
                                                       endPoint: .trailing)
                                    )
                                    .frame(width: minuteLength(history.timeDifference, proxy: proxy))
                                    .offset(x: minuteOffset(history.timeDifference, proxy: proxy))
                                
                                ForEach(-1..<6) { val in
                                    Rectangle()
                                        .stroke(val == 0 ? Color.white : Color.gray, lineWidth: 1.0)
                                        .frame(width: 1)
                                        .offset(x: minuteLocation(val * 10, proxy: proxy))
                                }
                            }
                            
                        }
                        .padding()
                        .background(Color.white.opacity(0.2))
                    }
                } //: Scroll View
                HistoryPieChart(flightHistory: flight.history)
                    .font(.footnote)
                    .frame(width: 250, height: 250)
                    .padding(5)
            }
        }
        .foregroundColor(.white)
    }
}

struct FlightTimeHistory_Previews: PreviewProvider {
    static var previews: some View {
        FlightTimeHistory(flight: FlightData.generateTestFlight(date: Date()))
    }
}
