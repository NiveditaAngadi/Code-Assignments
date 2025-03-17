//
//  CountryView.swift
//  CountryList
//
//  Created by Nivedita Angadi on 11/02/25.
//

import SwiftUI

struct CountryListView: View {
    @StateObject private var viewModel = CountriesViewModel()
    @State var searchText: String = ""
    @State var showSheet: Bool = false
    @State var selectedFilter: FilterOption?
    
    enum FilterOption: String, CaseIterable, Identifiable {
        case oneMillion = ">1M"
        case fiveMillion = ">5M"
        case tenMillion = ">10M"

        var id: String { self.rawValue }
        
        var threshold: Double {
            switch self {
            case .oneMillion: return 1_000_000
            case .fiveMillion: return 5_000_000
            case .tenMillion: return 10_000_000
            }
        }
    }
    
    var body: some View {
        VStack {
            // Header
            HStack {
                Text("Wrk Spot")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.blue)
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 24)
                
                Spacer()
                
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .foregroundStyle(.gray)
                    .padding(.trailing, 24)
            }
            
            HStack {
                UIKitSearchBar(text: $searchText)
                
                Button(action: {
                    selectedFilter = nil
                    showSheet.toggle()
                }) {
                    Image(systemName: "line.3.horizontal.decrease")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(.gray)
                        .padding(.trailing, 24)
                }
            }
            
            // List of country
            NavigationStack {
                switch viewModel.state {
                case .loading:
                    ProgressView()
                case .loaded:
                    List(finalResults) { country in
                        CountryCell(country: country)
                            .listRowSeparator(.hidden)
                            .background(Color.purple.opacity(0.1))
                    }
                case .idle:
                    Text("Ready to load countries")
                        .onAppear {
                            Task {
                                await viewModel.fetchCountries()
                            }
                        }
                case .failed(let error):
                    ErrorView(error: error) {
                        Task {
                            await viewModel.fetchCountries()
                        }
                    }
                }
            }
            //.searchable(text: $searchText, prompt: "Search Country")
            .sheet(isPresented: $showSheet) {
                VStack {
                    List {
                        ForEach(FilterOption.allCases) { option in
                            Text(option.rawValue)
                                .font(.caption)
                                .gesture(TapGesture().onEnded {
                                    selectedFilter = option
                                })
                                .listRowBackground(selectedFilter == option ? Color.gray.opacity(0.2) : Color.clear)
                        }
                    }
                }.presentationDetents([.height(200)])
            }
            .navigationTitle("Countries")
            .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage ?? "Unknown error")
            } .onChange(of: selectedFilter) { oldValue, newValue  in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    showSheet.toggle()
                }
            }
        } .onTapGesture {
            hideKeyboard()
        }
    }
    
    var finalResults: [Country] {
        if selectedFilter == nil {
            return searchResults
        } else {
           return filteredCountries
        }
    }
    
    var searchResults: [Country] {
        if searchText.isEmpty {
            return viewModel.data ?? []
        } else {
            guard let countries = viewModel.data else { return [Country]() }
            return countries.filter { $0.name.contains(searchText) }
        }
    }
    
    var filteredCountries: [Country] {
        guard let selectedPopulation = selectedFilter else { return [] }
        return searchResults.filter { $0.population ?? 0 >= selectedPopulation.threshold }
    }
}

struct ErrorView: View {
    let error: Error
    let retryAction: () -> Void
    
    var body: some View {
        VStack {
            Text("Error occurred:")
                .font(.headline)
            Text(error.localizedDescription)
                .foregroundColor(.red)
                .padding()
            
            Button("Retry", action: retryAction)
                .buttonStyle(.borderedProminent)
        }
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

    }
}

#Preview {
    CountryListView()
}

