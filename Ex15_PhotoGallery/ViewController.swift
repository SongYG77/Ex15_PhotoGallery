//
//  ViewController.swift
//  Ex15_PhotoGallery
//
//  Created by 송윤근 on 2022/01/09.
//

import UIKit
import MobileCoreServices   // 아이폰이 기본 내장하고있는 포토앨범, 카메라를 사용할 수 있는 라이브러리

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var ImageView: UIImageView!
    
    let imagePickerVC : UIImagePickerController! = UIImagePickerController()
    
    //선택된 이미지 데이터를 가지고 있어야 하는 변수
    var captureImage : UIImage!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func onBtnGallery(_ sender: UIButton) {
        //포토앨번에 접근이 가능한가 코드적으로 물어봐야함
        if(UIImagePickerController.isSourceTypeAvailable(.photoLibrary)){
            imagePickerVC.delegate = self
            imagePickerVC.sourceType = .photoLibrary
            imagePickerVC.mediaTypes = [kUTTypeImage as String]
            
            //ui image picker view con의 기본 기능인 잘라내기
            imagePickerVC.allowsEditing = false
            
            //팝업
            present(imagePickerVC, animated: true, completion: nil)
        } else{
            print("포토 앨범에 접근할 수 없습니다.")
        }
        
    }
    
    //선택된 이미지를 받아오는 함수
    //자동완성.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! String
        
        if mediaType.isEqual(kUTTypeImage as NSString as String) // NSString과 String계열이 혼합되어 있어 타입변경을 두번. 그래서 이미지 타입이 맞는지 확인
        {
            if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
                ImageView.image = editedImage
                captureImage = editedImage
                print("editing pic")
            }// 편집된 이미지와 편집안한 이미지의 접근 방식이 infokey에 다르게 담긴다.
            else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                ImageView.image = originalImage
                captureImage = originalImage
                print("original pic")
            }//여기의 경우 위 이미지 픽커 옵션에서 imageeditingallow를 false로 할시 이걸로 실행되는듯.
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

