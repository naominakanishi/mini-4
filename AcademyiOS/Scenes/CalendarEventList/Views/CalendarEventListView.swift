import SwiftUI
import AcademyUI

struct CalendarEventListView: View {
    @StateObject var viewModel = CalendarEventListViewModel()
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ForEach(viewModel.calendarEventList) { event in
                    CalendarEventBox(event: event)
                        .padding(.bottom, 4)
                }
            }
        }
        .onAppear {
            viewModel.handleOnAppear()
        }
    }
}

struct CalendarEventListView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarEventListView()
    }
}
