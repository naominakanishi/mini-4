import SwiftUI
import AcademyUI

struct CalendarEventListView: View {
    @StateObject
    var viewModel = CalendarEventListViewModel()
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ForEach(viewModel.calendar) { month in
                    MonthView(month: month)
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
