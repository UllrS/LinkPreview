import SwiftUI
import LinkPresentation


struct PreloadView: View{

    let url: URL
    
    //LinkView parameters
    let linkVideo: Bool?
    let linkImage: Bool?
    let linkIcon: Bool?
    var body: some View{
        LinkPreview(url: url)
            .aspectRatio(1.0, contentMode: .fit)
    }
}

class LinkPreviewSizeController: LPLinkView {
//    override var intrinsicContentSize: Size { UISize(width: 150, height: super.intrinsicContentSize.height) }
}


struct LinkPreview: UIViewRepresentable {
    typealias UIViewType = LinkPreviewSizeController
    
//    typealias NSViewType = LinkPreviewSizeController

    let url: URL
    let linkVideo: Bool = true
    let linkImage: Bool = true
    let linkIcon: Bool = true
    
    func makeUIView(context: Context) -> LinkPreviewSizeController {
        return LinkPreviewSizeController(url: url)
    }

    func updateUIView(_ nsView: LinkPreviewSizeController, context: Context) {
        let provider = LPMetadataProvider()

        provider.startFetchingMetadata(for: url) { metadata, error in
            guard let metaData = metadata, error == nil else {
                return
            }
            DispatchQueue.main.async {
                if !self.linkVideo{
                    metaData.videoProvider = nil
                }
                if !self.linkIcon{
                    metaData.iconProvider = nil
                }
                if !self.linkImage{
                    metaData.imageProvider = nil
                }
                nsView.metadata = metaData
            }
        }
    }
}
