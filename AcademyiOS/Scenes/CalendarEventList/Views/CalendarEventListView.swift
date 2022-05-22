import SwiftUI
import AcademyUI

struct CalendarEventListView: View {
    
    @Environment(\.presentationMode)
    private var presentationMode: Binding<PresentationMode>
    
    @StateObject
    var viewModel = CalendarEventListViewModel()
    
    @State
    private var modal = false
    
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                ForEach(viewModel.calendar) { month in
                    MonthView(month: month)
                }
            }
        }
        .padding(.horizontal, DesignSystem.Spacing.generalHPadding / 2)
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Eventos")
        .background(Color.adaBackground)
        .onAppear {
            viewModel.handleOnAppear()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    modal = true
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .foregroundColor(Color.white)
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.system(size: 24, weight: .bold, design: .default))
                        .foregroundColor(Color.white)
                }
            }
        }
        .sheet(isPresented: $modal) {
            NewEventView()
        }
    }
}

struct CalendarEventListView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarEventListView()
    }
}
