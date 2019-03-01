/*
 MIT License
 
 Copyright (c) 2017-2018 MessageKit
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

import UIKit
import MessageInputBar

class iMessageInputBar: MessageInputBar {

    private let githawkImages: [UIImage] = [#imageLiteral(resourceName: "ic_eye"), #imageLiteral(resourceName: "ic_bold"), #imageLiteral(resourceName: "ic_italic"), #imageLiteral(resourceName: "ic_at"), #imageLiteral(resourceName: "ic_list"), #imageLiteral(resourceName: "ic_code"), #imageLiteral(resourceName: "ic_link"), #imageLiteral(resourceName: "ic_hashtag"), #imageLiteral(resourceName: "ic_upload")]

    var collectionView: AttachmentCollectionView!
    var toggleButton: InputBarButtonItem!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {

        let camera = InputBarButtonItem()

        camera.setSize(CGSize(width: 36, height: 36), animated: false)
        camera.setImage( UIImage(named: "camera")?.withRenderingMode(.alwaysTemplate), for: .normal)
        camera.imageView?.contentMode = .scaleAspectFit
        camera.tintColor = .black

        toggleButton = InputBarButtonItem()
        toggleButton.setSize(CGSize(width: 36, height: 36), animated: false)
        toggleButton.setImage(UIImage(named: "grid")?.withRenderingMode(.alwaysTemplate), for: .normal)
        toggleButton.imageView?.contentMode = .scaleAspectFit
        toggleButton.tintColor = .black
        toggleButton.addTarget(self, action: #selector(showApps), for: .touchUpInside)


        setLeftStackViewWidthConstant(to: 100, animated: false)
        setStackViewItems([camera, toggleButton, InputBarButtonItem.fixedSpace(8)], forStack: .left, animated: false)

        inputTextView.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        inputTextView.placeholderTextColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        inputTextView.textContainerInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 36)
        inputTextView.placeholderLabelInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 36)
        inputTextView.layer.borderColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1).cgColor
        inputTextView.layer.borderWidth = 1.0
        inputTextView.layer.cornerRadius = 16.0
        inputTextView.layer.masksToBounds = true
        inputTextView.scrollIndicatorInsets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        setRightStackViewWidthConstant(to: 38, animated: false)
        setStackViewItems([ sendButton, InputBarButtonItem.fixedSpace(2)], forStack: .right, animated: false)
        sendButton.imageView?.backgroundColor = tintColor
        sendButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        sendButton.setSize(CGSize(width: 36, height: 36), animated: false)
        sendButton.image = #imageLiteral(resourceName: "ic_up")
        sendButton.title = nil
        sendButton.imageView?.layer.cornerRadius = 16
        sendButton.backgroundColor = .clear
        textViewPadding.right = -38
        separatorLine.isHidden = true
        backgroundView.backgroundColor = .white
        isTranslucent = true

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 30, height: 30)
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 20)
        collectionView = AttachmentCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.intrinsicContentHeight = 60
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseIdentifier)
        bottomStackView.addArrangedSubview(collectionView)
        collectionView.reloadData()
        collectionView.isHidden = true

       }

    @objc func showApps() {
        collectionView.isHidden = !collectionView.isHidden

        if collectionView.isHidden {
            toggleButton.setImage(UIImage(named: "grid")?.withRenderingMode(.alwaysTemplate), for: .normal)
        } else {
            toggleButton.setImage(UIImage(named: "grid-filled")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }
    
}


extension iMessageInputBar: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return githawkImages.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseIdentifier, for: indexPath) as! ImageCell
        cell.imageView.image = githawkImages[indexPath.section].withRenderingMode(.alwaysTemplate)
        cell.imageView.tintColor = .black
        return cell
    }

}

extension iMessageInputBar: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("clicked")
    }
}
