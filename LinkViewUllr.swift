
import SwiftUI
import LinkPresentation


class LinkPreviewSizeController: LPLinkView {
//    override var intrinsicContentSize: Size { UISize(width: 150, height: super.intrinsicContentSize.height) }
}

#if os(iOS)
struct LinkPreview: UIViewRepresentable {
    typealias UIViewType = LinkPreviewSizeController
    

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

#elseif os(OSX)
import AppKit
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
#endif
