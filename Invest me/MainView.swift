//
//  MainView.swift
//  Invest me
//
//  Created by Ismatillo Marufkhonov on 29/05/22.
//

import SwiftUI
import AVKit
import AVFoundation
import youtube_ios_player_helper

struct MainView: View {
    var array = ["All","Bussines","Technology","Social"]
    var firstVideoUrl = Bundle.main.path(forResource: "aziza", ofType:"MOV")
    @State var isLiked = [false, false, false, false, false]
    @State var videoIds = ["q-Q2bsAOEhw",
                           "Q2bsAOEhw",
                           "LRgsIWi-5FI",
                           "4DloH-WS2Vs",
                            "8mowEvRCVRg"]
    @State var isVerification = false
    @State var selection = 0
    
    
    @State var titles = [
        "Bussines Startup",
        "Establishment of an unusual training center",
       "Ensuring that women make money sitting at home",
        "Invest in Africa",
        "Why you must invest to Africa"
        ]
    
    var body: some View {
        VStack
        {
            self.scroll
            
            self.title
            
            self.video
            
            Spacer()
            
            
            if isVerification
            {
                NavigationLink(destination: Verification(), isActive: $isVerification) {}
            }
            
            
        }.navigationTitle("Main View")
    }
}




struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


extension MainView
{
    var scroll: some View
    {
        ScrollView(.horizontal)
        {
            HStack
            {
                ForEach(0..<array.count, id: \.self) {index in
                    Button(action: {
                        self.selection = index
                    }) {
                        Text(array[index])
                            .frame(width: 100, height: 50)
                            .background(self.selection == index ? .green : Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                           
                    }
                }
            }
        }
    }
    
    
    
    var title: some View
    {
        Text("From Peaople To People")
            .font(.system(size: 20))
            .padding(.top)
    }
}

extension MainView
{
    var video: some View
    {
        VStack
        {
            ScrollView
            {
                VStack
                {
                    ForEach(0..<5) { index in
                        VStack
                        {
                            VideoView(videoId: self.videoIds[index])
                                .frame(width: UIScreen.main.bounds.width - 40, height: 270)
                                .padding()
                            .overlay(
                                Button(action:
                                {
                                    
                                    if UserDefaults.standard.bool(forKey: "isVerification") == false
                                    {
                                        self.isVerification = true
                                        return
                                    }
                                    self.isLiked[index].toggle()
                                })
                                {
                                    Image(systemName: self.isLiked[index] ? "heart.circle.fill" : "heart.circle")
                                        .resizable()
                                        .foregroundColor(self.isLiked[index] ? Color.red : Color.white)
                                        .frame(width: 35, height: 35)
                                        .padding(5)
                                        .padding(.top, 15)
                                }
                                
                                , alignment: .topTrailing)
                            .padding()
                            
                            Text(titles[index])
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal, 20)
                                .font(.system(size: 20))
                                
                            
                            
                            Divider()
                            
                            
                            HStack
                            {
                                Spacer()
                                    VStack
                                    {
                                        Text("292")
                                            .foregroundColor( Color.black)
                                        Text("funned")
                                            .foregroundColor( Color.black)
                                    
                                    }
                                Spacer()
                                VStack
                                {
                                    Text("200")
                                        .foregroundColor( Color.black)
                                    Text("bakers")
                                        .foregroundColor( Color.black)
                                
                                }
                                
                                
                                Spacer()
                                
                                VStack
                                {
                                    Text("53")
                                        .foregroundColor( Color.black)
                                    Text("days ago")
                                        .foregroundColor( Color.black)
                                
                                }
                                Spacer()
                            }
                            
                        }.cornerRadius(12)
                           
                        
                        
                    }
                
                    
                }
            }
        }
    }
}





struct VideoView: UIViewControllerRepresentable
{
    
    let videoId: String
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context)
    {
        
    }
    
    func makeUIViewController(context: Context) -> UIViewController
    {
        return YoutubeVideoPlayerViewController(videoId: videoId)
    }
}



class YoutubeVideoPlayerViewController: UIViewController
{
    var videoId: String
    let youtubeView = YTPlayerView()
    
    init(videoId: String)
    {
        self.videoId = videoId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        self.view.addSubview(youtubeView)
        self.youtubeView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20, height: 270)
        self.youtubeView.layer.cornerRadius = 12
        self.youtubeView.clipsToBounds = true
        youtubeView.load(withVideoId: videoId)
        
        
    }
}
