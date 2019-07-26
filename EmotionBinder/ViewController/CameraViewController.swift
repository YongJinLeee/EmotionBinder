//
//  CameraViewController.swift
//  EmotionBinder
//
//  Created by LeeYongJin on 23/07/2019.
//  Copyright © 2019 vian. All rights reserved.
//

import UIKit
import AVFoundation
import Dispatch

@available(iOS 10.2, *)
class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate,AVCaptureVideoDataOutputSampleBufferDelegate {
    
    
    @IBOutlet weak var filterTitleLabel: UILabel!
    
    @IBOutlet weak var settingToolbar: UIToolbar! //화면 상단. 비율, 플래시 설정 툴바
    
    @IBOutlet weak var cameracntrToolbar: UIToolbar! //화면 하단. 카메라 전환, 앨범
    
    @IBOutlet weak var flashSetBarbButtonItem: UIBarButtonItem! //플래시 모드 설정 버튼
    
    @IBOutlet weak var ratioSetBarButtonItem: UIBarButtonItem! // 사진 비율 조정 버튼
   
    @IBOutlet weak var emojiEditorBarButtonItem: UIBarButtonItem! // 이모지, 미모지 모드(애플이 권한을 줄까?)
    
    @IBOutlet weak var photoLibraryBarButtonItem: UIBarButtonItem! // 사진앨범 진입버튼
    
    @IBOutlet weak var shutterBarButtonItem: UIBarButtonItem! // 카메라 셔터
    
    @IBOutlet weak var cameraSwichBarbuttonItem: UIBarButtonItem! //전후방 카메라 전환버튼
    
    @IBOutlet weak var cameraPreview: UIImageView! // 카메라로 비춰지는 화면 프리뷰
    
    
    var focusBox: UIView!
    var emojiFaceIcon: UIImageView?
    var isAddFunEmoticon: Bool?
    var originalImage: UIImage?
    
    var filterTitle: String? //필터 이름 지정
    var filterIndex: Int? // 현재 필터를 저장해둘 인덱스 변수. 스와이프 기능으로 동작할 때 사용
    var cameraPosition: AVCaptureDevice.Position?
    var flashModeStatus: Int = 0 // 플래시 모드(항상끔 켬 등..)의 상태 저장하는 프로퍼티
    var screenRatioStatus: Int = 0 // 화면 비율조정 상태 저장 프로퍼티
    var previewImage: CGRect?
    
    var captureSession: AVCaptureSession? // AV 장치 데이터 흐름 조정
    var sessionOutput = AVCapturePhotoOutput()
    var previewLayer = AVCaptureVideoPreviewLayer()
    var cameraView: UIView!
    
    //developer.apple.com의 AVFoundation 문서 참조
    
    var protection: String?
    
    //상태 바 숨김
    var isHidden: Bool = true{
        didSet{
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    override var prefersStatusBarHidden: Bool {
        return isHidden
    }
    
    
    
    override func viewDidLoad() {
        

        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MAKR: - View Controller Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        captureSession = AVCaptureSession()
    
        if let session = captureSession {
            
            let deviceSession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera, AVCaptureDevice.DeviceType.builtInTelephotoCamera, AVCaptureDevice.DeviceType.builtInDualCamera],  mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
            
            if let session = captureSession {
                for discoveredDevice in (deviceSession.devices) {
                    
                    if discoveredDevice.position == AVCaptureDevice.Position.back {
                        do {
                            let input = try AVCaptureDeviceInput(device: discoveredDevice)
                            if session.canAddInput(input){
                                session.addInput(input)
                            
                                if session.canAddOutput(sessionOutput){
                                    session.addOutput(sessionOutput)
                                    
                                    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                                    previewLayer.videoGravity = AVLayerVideoGravity.resize
                                    previewLayer.connection?.videoOrientation = .portrait
                                    
                                    cameraView.layer.addSublayer(previewLayer)
                                    
                                    previewLayer.position = CGPoint(x: self.cameraView.frame.width / 2, y: self.cameraView.frame.height / 2)
                                    previewLayer.bounds = cameraView.frame
                                    
                                    session.stopRunning()
                                }
                            }
                        } catch let avCaptureError {
                            print(avCaptureError)
                        }
                    }
                } //기기 상태 확인 끝
            
          /*  if #available(iOS 10.2, *) {
                let devicesession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera, AVCaptureDevice.DeviceType.builtInTelephotoCamera, AVCaptureDevice.DeviceType.builtInDualCamera],  mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
            } else {
                // Fallback on earlier versions
            }
        } */
            }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    //카메라 전후방 변경
    
   
    
}