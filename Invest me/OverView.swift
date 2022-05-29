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
    
    var body: some View {
        ScrollView
        {
            VStack
            {
            self.video
            
            self.titleView
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
            .frame(width: UIScreen.main.bounds.width - 40)
            .padding(.trailing, 20)
    }
    
    
    
    var titleView: some View
    {
            Text(title)
                .font(.largeTitle)
    }
}
