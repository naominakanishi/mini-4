import SwiftUI
import AcademyUI

struct DashboardView: View {
    @StateObject
    private var viewModel = DashboardViewModel()
    
    var body: some View {
        HStack(alignment: .top) {
            helpListView
            if viewModel.shouldShowEvents {
                eventsView
//                    .frame(maxWidth: UIScreen.main.bounds.width * 0.4) // TODO remove frame
            }
        }
    }
    
    @ViewBuilder
    private var helpListView: some View {
        HStack {
            ForEach(viewModel.helpList) { helpColumn in
                VStack(alignment: .leading) {
                    Text(helpColumn.name)
                        .font(.tvTitle)
                    ScrollView {
                        VStack {
                            ForEach(helpColumn.cards, id: \.helpModel.id) { help in
                                HelpCard(
                                    queuePosition: help.queuePosition,
                                    isFromUser: false,
                                    helpModel: help.helpModel,
                                    assignHelpHandler: {},
                                    completeHelpHandler: {}
                                )
                            }
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var eventsView: some View {
        if let month = viewModel.todayEvents {
            MonthView(month: month)
        }
    }
}
