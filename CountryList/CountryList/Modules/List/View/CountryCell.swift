//
//  CountryCell.swift
//  CountryList
//
//  Created by Nivedita Angadi on 11/02/25.
//

import SwiftUI

struct CountryCell: View {
    let country: Country
    
    var body: some View {
        HStack {
            HStack {
                AsyncImage(url: URL(string: country.media.flag)){ result in
                            result.image?
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                .frame(width: 70, height: 70)
                
                Text(country.name)
                    .font(.subheadline)

            }

            Spacer()
            
            VStack(alignment: .trailing) {
                Text("Capital: \(country.capital)")
                    .font(.caption2)
                Text("Currency: \(country.currency)")
                    .font(.caption2)
                if let population = country.population {
                    let formattedPopulation = String(format: "%.1f", population)
                    Text("Population: \(formattedPopulation)")
                        .font(.caption2)
                }
            }
        }
    }
}

#Preview {
    CountryCell(country: Country(abbreviation: "BD",
                                 capital: "Dhaka",
                                 currency: "BDT",
                                 id: 1,
                                 name: "Bangladesh",
                                 phone: "880",
                                 population: 162951560,
                                 media: Media(
                                    flag: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f9/Flag_of_Bangladesh.svg/1280px-Flag_of_Bangladesh.svg.png",
                                    emblem: "https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/National_emblem_of_Bangladesh.svg/1280px-National_emblem_of_Bangladesh.svg.png",
                                    orthographic: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f2/Bangladesh_%28orthographic_projection%29.svg/1280px-Bangladesh_(orthographic_projection).svg.png")))
}
