
import SwiftUI
import LinkPresentation

struct LinkViewUllr: View{

    let url: URL
    
    //LinkView parameters
    let linkVideo: Bool?
    let linkImage: Bool?
    let linkIcon: Bool?
    var body: some View{
        LinkPreview(url: url)
    }
}

class LinkPreviewSizeController: LPLinkView {
    override var intrinsicContentSize: NSSize { NSSize(width: 150, height: super.intrinsicContentSize.height) }   //super.intrinsicContentSize.height
}


struct LinkPreview: NSViewRepresentable {
    typealias NSViewType = LinkPreviewSizeController

    let url: URL
    let linkVideo: Bool = true
    let linkImage: Bool = true
    let linkIcon: Bool = true
    
    func makeNSView(context: Context) -> LinkPreviewSizeController {
        return LinkPreviewSizeController(url: url)
    }

    func updateNSView(_ nsView: LinkPreviewSizeController, context: Context) {
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
                    metaData.videoProvider = nil
                }
                if !self.linkImage{
                    metaData.videoProvider = nil
                }
                nsView.metadata = metaData
            }
        }
    }
}
