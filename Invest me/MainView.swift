//
//  MainView.swift
//  Invest me
//
//  Created by Ismatillo Marufkhonov on 29/05/22.
//

import SwiftUI
import AVKit
import AVFoundation

struct MainView: View {
    var array = ["All","Bussines","Technology","Social"]
    var firstVideoUrl = Bundle.main.path(forResource: "aziza", ofType:"MOV")
    @State var isLiked = [false, false, false, false, false]
    @State var titles = [
        "klsdmckldsmlkcmdsklmc as;lmfldsc s;zknckldsc",
        "sdlmfckld a;sldmcdsl;kmc las;m;ldsamc",
        "dscmlsdkmc dsc laskzclksdmc lka.s,dxlks",
        "sdlmclk aklsnclksam.cx paoslkdmxlkasmx",
        ".sd,clks ioaslknc.kds,mc laskdm.askmzc"
        ]
    
    var body: some View {
        VStack
        {
            self.scroll
            
            self.title
            
            self.video
            
            Spacer()
        }
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
                        
                    }) {
                        Text(array[index])
                            .padding()
                            .background(Color.blue)
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
                        VideoView(videoUrl: self.firstVideoUrl ?? "")
                            .frame(width: UIScreen.main.bounds.width - 40,
                                   height: 200)
                            
                            .overlay(
                                Button(action:
                                {
                                    self.isLiked[index].toggle()
                                })
                                {
                                    Image(systemName: self.isLiked[index] ? "heart.circle.fill" : "heart.circle")
                                        .resizable()
                                        .foregroundColor(self.isLiked[index] ? Color.red : Color.white)
                                        .frame(width: 35, height: 35)
                                        .padding(5)
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



// MARK: USE UIKIT CLASS ON SWIFTUI
struct VideoView: UIViewControllerRepresentable {
    
    var url: String

    init(videoUrl: String) {
        self.url = videoUrl
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {

    }

    func makeUIViewController(context: Context) -> UIViewController {
        return VideoViewController(url: self.url)
    }
}

class VideoViewController: UIViewController, AVPlayerViewControllerDelegate {
    
    @Published var url: String
    var statusVideo: StatusVideo = .pause
    var player: AVPlayer?
    var playerController = AVPlayerViewController()
    var height = UIScreen.main.bounds.height
    
    init(url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var shouldAutorotate: Bool {
        return true
    }
    
    override func viewDidLoad() {
        let url = URL(fileURLWithPath: self.url)
        
            self.player = AVPlayer(url: url)
            self.playerController.delegate = self
            self.playerController.player = self.player!
            self.addChild(self.playerController)
            self.view.addSubview(self.playerController.view)
            
       
      
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player?.pause()
    }
    
    deinit {
        print("class VideoViewController is deinit")
    }
}


enum StatusVideo
{
    case play
    case pause
}
