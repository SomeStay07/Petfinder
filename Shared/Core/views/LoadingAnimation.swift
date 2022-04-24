//
//  LoadingAnimation.swift
//  Petfinder
//
//  Created by Timur Cheberda on 24.04.2022.
//

import Foundation
import SwiftUI

struct LoadingAnimation: UIViewRepresentable {
    
    let animatedFrames: UIImage
    let image: UIImageView
    let squareDimension: CGFloat = 125
    
    init() {
        var images: [UIImage] = []
        
        for i in 1...127 {
            guard let image = UIImage(named: "dog_\(String(format: "%03d", i))") else { continue }
            images.append(image)
        }
        
        animatedFrames = UIImage.animatedImage(with: images, duration: 4) ?? UIImage()
        image = UIImageView(frame: CGRect(x: 0, y: 0, width: squareDimension, height: squareDimension))
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: squareDimension, height: squareDimension))
        
        image.clipsToBounds = true
        image.autoresizesSubviews = true
        image.contentMode = .scaleAspectFit
        image.image = animatedFrames
        image.center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        view.backgroundColor = .red
        view.addSubview(image)
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // no code here, just for protocol
    }
}

struct LoadingAnimationView: View {
    
    var body: some View {
        VStack {
            LoadingAnimation()
        }
    }
    
}

struct LoadingAnimationView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoadingAnimationView()
            .frame(width: 125, height: 125, alignment: .center)
            .previewLayout(.sizeThatFits)
    }
    
}
