//
//  DetailView.swift
//  LOCALANE
//
//  Created by Catherine Candice on 26/05/23.
//

import SwiftUI
import MapKit

// Detail information about the chosen location memory lane
struct DetailView: View {
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text("HYDE PARK")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            }
            
            VStack (alignment: .leading) {
                // Phone Call
                Text("Phone")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(EdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 20))
                
                Link("(62)818-0988-8811", destination: URL(string: "tel:081809888811")!)
                    .padding(EdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 20))
                
                Divider()
                
                // Social Media
                Text("Media Platform")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(EdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 20))
                
                Link(destination: URL(string: "https://www.instagram.com/hydepark.id")!, label: {
                    Label("Follow me on Instagram @hydepark.id", systemImage: "link")
                })
                .padding(EdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 20))
                
                Link(destination: URL(string: "https://www.tiktok.com/@hydepark.id")!, label: {
                    Label("Follow me on TikTok @hydepark.id", systemImage: "link")
                })
                .padding(EdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 20))
                
                Divider()
                
                // Address
                Text("Address")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(EdgeInsets(top: 5, leading: 20, bottom: 0, trailing: 20))
                
                Link(destination: URL(string: "https://maps.apple.com/?address=Jalan%20Marina%20Indah,%20Jakarta%20Utara,%20Jakarta,%20Indonesia&auid=17058189229531808822&ll=-6.109867,106.739221&lsp=9902&q=Goobne%20Indonesia%20PIK%20Central%20Market")!, label: {
                    Label("Golf Island Kawasan Pantai Maju, Central Market PIK, Jalan Boulevard Raya, Kamal Muara, Daerah Khusus Ibukota Jakarta 14470", systemImage: "map")
                })
                .padding(EdgeInsets(top: 5, leading: 20, bottom: 10, trailing: 20))
                
                Divider()
            }
            .padding(20)
            .background(Color.white.edgesIgnoringSafeArea(.all))
            Spacer()
            
            MapView()
                .background(Color.white.edgesIgnoringSafeArea(.all))
        }

    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}

