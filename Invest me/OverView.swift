//
//  OverView.swift
//  Invest me
//
//  Created by Ismatillo Marufkhonov on 29/05/22.
//

import SwiftUI
struct OverView: View {
    @State var videoId: String
    @State var title: String
    @State var paymentView = false
    
    
    var body: some View {
        
        ScrollView
        {
            
            self.video
            
            self.titleView
            
            self.infoView
            
            self.aboutBusinnes
            
            self.paymentButton
            Spacer()
            
            
            if self.paymentView
            {
                NavigationLink(destination: PurchasingView(), isActive: self.$paymentView) {}
            }
            
        }
        .navigationTitle("Overview")
    }
}

struct OverView_Previews: PreviewProvider {
    static var previews: some View {
        OverView(videoId: "", title: "")
        
    }
}




extension OverView

{
    var video: some View
    {
        VideoView(videoId: self.videoId)
            .frame(width: UIScreen.main.bounds.width - 40,
                   height: 300)
            .padding(.trailing, 20)
    }
    
    
    
    var titleView: some View
    {
            Text(title)
                .font(.largeTitle)
    }
    
    
    
    var infoView: some View
    {
        HStack
        {
            Image("myPhoto")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .padding()
            
            VStack(spacing: 5)
            {
                Text("Created by: ")
                
                Text("Ismatillo Marufkhonov")
            }
            
            Spacer()
        }
    }
    
    
    
    var aboutBusinnes: some View
    {
        Text("A business is defined as an organization or enterprising entity engaged in commercial, industrial, or professional activities. Businesses can be for-profit entities or non-profit organizations. Business types range from limited liability companies, sole proprietorships, corporations, and partnerships.")
            .padding()
    }
    
    
    
    var paymentButton: some View
    {
        Button(action:
        {
            self.paymentView = true
        }) {
            Text("Pay for project")
                .frame(width: UIScreen.main.bounds.width - 40, height: 60)
                .foregroundColor(.white)
        }
        .background(Color.green)
        .clipShape(Capsule())
    }
}


