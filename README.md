# ARKit_SolarSystem_APP

☀️ ARKit을 이용한 태양계 증강현실 앱 만들기!
새로운 시리즈로 돌아왔다!
![KakaoTalk_Image_2024-02-20-14-17-03](https://github.com/jinyongyun/ARKit_SolarSystem_APP/assets/102133961/eac1b827-579e-4b8f-a6dc-5519083324fb)

이번 시리즈는 바로 AR(증강현실) 그리고 ML(머신러닝)을 이용한 앱을 만들어 볼 것이다.

이걸 내가 어떻게 만들어?! -라고 할 수도 있지만, 기특한 애플이 이미 라이브러리를 만들어 놓았다.

하지만 해당 라이브러리에 대한 정보가 공식문서를 제외하고 거의 없는 관계로 직접 조사해서 만들어야 한다.

***필자에게도 일종의 도전적인 시리즈가 될 것이다!!***

## ARKit 개요

- 증강현실(Augmented Reality)

카메라를 통해 라이브뷰에 2D or 3D 요소를 추가하여 사용자 앞에 존재하는 것처럼 보이게 하는 기술이다.

즉 현실 세계에서 우리가 만들어 준 가상의 오브젝트를 넣어줘서 현실과 가상의 경계를 허무는 기술이다!

필자가 자주 하는 포켓몬고가 대표적인 예시(필자는 포켓몬고 고인물이다.)

Swift에도 이런 증강현실을 이용할 수 있도록 해주는 라이브러리가 존재하는데, 바로 ARKit이 그 주인공이다.

But! ARkit을 사용하기 위해서는 디바이스적인 제약이 존재한다.

하드웨어가 A9 칩 이상의 스펙일 것

기본적으로 아이폰SE 이후 정도의 모델이면 충분할 것이다.

ARKit은 크게 다음의 프레임워크로 분류될 수 있다.

- Metal
- RealityKit (for 3D)
- SceneKit (for 3D)
- SpriteKit (for 2D)

이 중에서 가장 중요한 것이 바로 Metal이다.

[Metal 개요 - Apple Developer](https://developer.apple.com/kr/metal/)

> Metal은 Apple 플랫폼에서 오버헤드가 낮은 API, 풍부한 셰이딩 언어, 그래픽과 컴퓨팅 간의 긴밀한 통합 및 탁월한 GPU 프로파일링 및 디버깅 도구를 제공하고 하드웨어 가속 그래픽을 지원합니다. 게임과 전문가용 앱은 iPhone, iPad, Mac 및 Apple TV에서 Apple Silicon의 놀라운 성능과 효율성을 최대한 활용할 수 있습니다. 올해의 새로운 Game Porting Toolkit을 사용하면 다른 플랫폼의 게임을 그 어느 때보다 쉽게 Mac으로 가져올 수 있으며, Metal 셰이더 컨버터를 사용하면 게임의 셰이더와 그래픽 코드를 변환하는 과정이 대폭 간소화됩니다.
> 

공식문서에서 가져온 Metal의 소개이다.

마크에서부터 애플이 상당히 공을 들인 녀석이라는 것을 느낄 수 있는데, 

위에서 말한 ARKit의 프레임워크들 (SpriteKit, SceneKit, RealityKit)은 모두 Metal을 바탕으로 만들어진 것이다. 또한 우리가 나중에 다뤄 볼 예정인 CoreML에서도 사용한다고 한다!

Metal의 대표적인 기능은 다음과 같다.

### **MPS Graph**

MPS Graph 변환 도구를 사용하여 CoreML 및 ONNX 모델을 Metal 앱에 더 빠르게 통합하고, 새로운 직렬화 형식을 사용하여 네이티브 MPS Graph 모델을 더 빠르게 로드하세요.

### **오프라인 셰이더 컴파일**

빌드 타임에 GPU 바이너리를 생성하고 앱 내 셰이더 컴파일을 제거하여 게임 성능을 향상하고 로드 시간을 줄입니다. 이제 GPU 바이너리 컴파일러는 레이 트레이싱(Ray Tracing) 기법 및 동적 연결 라이브러리를 지원하며 macOS 또는 Windows용 툴체인을 제공합니다.

### **레이 트레이싱**

게임과 프로덕션 렌더러를 더욱 사실적이고 디테일한 장면으로 확장하세요. 여러 레벨의 인스턴싱과 커브 프리미티브 지원을 통해 나무, 머리카락, 털과 같은 복잡한 재질을 더욱 효율적으로 표현할 수 있습니다.

모두 공식문서에 써 있는 내용이다.

**쉽게 말해서 GPU의 성능을 최대한 끌어올릴 수 있도록 도와주고, 연관된 하드웨어를 정말 한계까지 쥐어짜내(죽여줘) 게임 등에서의 그래픽 성능을 올리며, 머신러닝에도 최적화 되어있는 API이다.**

## SceneKit

[SceneKit - Apple Developer](https://developer.apple.com/scenekit/)

> SceneKit is a high-level 3D graphics framework that helps you create 3D animated scenes and effects in your apps. It incorporates a physics engine, a particle generator, and easy ways to script the actions of 3D objects so you can describe your scene in terms of its content — geometry, materials, lights, and cameras — then animate it by describing changes to those objects.
> 

공식 사이트에는 앱에서 3D 애니메이션 장면 및 효과를 만드는 데 도움이 되는 고급 3D 그래픽 프레임워크라고 한다. 

이를 활용해서 3D 게임을 만들고 앱에 3D 컨텐츠를 추가할 수도 있다. 

더 놀라운 점은 3D 애니메이션까지 (물리 시뮬레이션까지!! 제작과정에 유니티가 많이 참여했다고 해서 더 기대가 된다.) 쉽게 추가할 수 있다고 한다.

SceneKit은 고성능 렌더링 엔진 + (3D asset 가져오기 및 조작을 위한 API)이다.

장면을 표시하는 렌더링 알고리즘을 우리가 구현해야 하는 Metal과 같은 로우 레벨 API와 달리

이녀석은 한 발 더 나아가서 우리가 수행하고 싶은 Scene이나, 애니메이션에 대한 Description만 추가한다면 쉽게 구현할 수 있다.

 

## SpriteKit

[SpriteKit - Apple Developer](https://developer.apple.com/spritekit/)

> The SpriteKit framework makes it easy to create high-performance, battery-efficient 2D games. With support for custom OpenGL ES shaders and lighting, integration with SceneKit, and advanced new physics effects and animations, you can add force fields, detect collisions, and generate new lighting effects in your games.
> 

공식 사이트에서는 SpriteKit을 다음과 같이 설명한다.

SpriteKit 프레임워크는 고성능의 배터리 효율적인 2D 게임을 쉽게 만들 수 있도록 한다….

즉 이녀석을 통해 우리는 부드러운 애니메이션 또는 2D asset을 앱에 추가하거나

높은 수준의 2D 게임 기반 도구 세트로 게임을 만들 수 있다!

SpriteKit은 2차원을 그리기 위한 프레임워크이다. 

Metal을 이용한 고성능 렌더링을 사용하는 동시에 SpriteKit에서 제공하는 간단한 인터페이스들을 통해 게임과 높은 수준의 그래픽 집약적인 앱을 만들 수 있다.

## RealityKit

[RealityKit 개요 - 증강 현실 - Apple Developer](https://developer.apple.com/kr/augmented-reality/realitykit/)

> RealityKit 프레임워크는 사진처럼 생생한 렌더링과 카메라 효과, 애니메이션, 물리적인 요소 등을 갖추고 특별히 증강 현실을 위해 완전히 새롭게 빌드되었습니다. RealityKit은 기본 Swift API, ARKit 통합, 놀랍도록 사실적인 물리적 요소 기반의 렌더링, 변형 및 스켈레톤 애니메이션, 공간 오디오 및 강체 물리 요소를 통해 AR 개발을 그 어느 때보다 빠르고 쉽게 수행할 수 있게 해줍니다.
> 

공식문서에서는 다음과 같이 RealityKit에 대해서 이야기한다.

이녀석은 2019년이 생일인 고오급 프레임워크이다. 

이녀석을 활용하면 macOS의 새로운 Object Capture API를 사용하여 iPhone 또는 iPad로 촬영한 사진을 AR에 최적화된 실감 나는 3D 모델로 몇 분* 안에 만들 수 있다. Object Capture에서는 iPhone 또는 iPad에서 촬영한 일련의 사진들을 사진 측량 기술을 사용하여 3D 모델로 변환한다.

## Xcode에서 ARKit 시작하기! (Feat 정육면체 만들기)

Create New Project → Augmented Reality App → Content Technology에서 사용할 프레임워크를 결정한다.

<img width="1385" alt="스크린샷 2024-02-16 오후 7 06 51" src="https://github.com/jinyongyun/ARKit_SolarSystem_APP/assets/102133961/d770baa1-4834-4aa0-85f0-adf7b076c7ab">


왜 RealityKit이 안뜨나 했더니, 이젠 SwiftUI에서만 지원하는 것 같다.
<img width="727" alt="스크린샷 2024-02-16 오후 7 10 49" src="https://github.com/jinyongyun/ARKit_SolarSystem_APP/assets/102133961/01814d9a-be2e-4c69-b9bb-4a66f2a6fcef">


우리가 만들 태양계 AR 앱을 만들기에 앞서, 도형 몇 개를 만든 다음 

넘어가도록 하자. 행성을 만들기 위해서는 구를 만들 수 있어야 하기 때문이다.

SceneKit를 선택하고 프로젝트를 생성하면 다음과 같이 화면이 나온다.

<img width="1396" alt="스크린샷 2024-02-16 오후 7 17 07" src="https://github.com/jinyongyun/ARKit_SolarSystem_APP/assets/102133961/52d64b1c-d5e4-45ba-aa74-8f795654e346">



저, 저건 뭐여

art…? 몇가지 이상한 것이 추가되어 있을텐데 지금부터 천천히 알아보자.

- Art.scnassets

***객체의 이미지 및 재질의 설정을 위한  asset을 모아 놓은 곳이다.***

기본적으로 폴더에 ship.scn과 texture.png 파일이 생성 된다.


<img width="262" alt="스크린샷 2024-02-16 오후 7 20 27" src="https://github.com/jinyongyun/ARKit_SolarSystem_APP/assets/102133961/5abe1742-7827-4938-b609-464df1a7a62b">

ship 녀석은 객체를 만들 때 사용되고, texture 녀석은 재질 설정을 할 때 사용된다.

<img width="1103" alt="스크린샷 2024-02-16 오후 7 22 34" src="https://github.com/jinyongyun/ARKit_SolarSystem_APP/assets/102133961/c6e5fe79-c3d5-41a4-9a14-25d5bdfd78c3">


ship에 들어가보면 다음과 같은 화면이 나올 것이다. 해당 설정 중 저 오른쪽 정육면체 녀석을 누르면

Node Inspector가 나타난다.

그렇다면 이 Node. 링크드리스트의 노드는 분명 아닌 것 같은데,

이녀석은 도대체 뭘까?

Node는 기본적으로 3D 공간의 위치를 나타낸다. 위치 및 크기를 지정하고 객체를 생성한다.

즉 AR로 화면에 표현되는 물체, 객체들을 우리는 Node라고 말한다. (어머낫 링크드리스트의 노드가 맞잖아!)

여기서 Node는 rootNode와 childNode로 구성된다.(뭐여 트리여?)

rootNode와 childNode는 Node 계층으로 서로 묶여있지만, 이는 visual적으로 묶여있다는 것이 절대 아니다!!

즉 rootNode를 구성하는 색이 검정이라고 해서, childNode도 검정이라는 것은 아니다.

기본적으로 커스텀 Node로 설정하면 아무런 설정이 지정되어있지 않기 때문에 화면에 아무것도 보이지 않을 것이다.

눈에 직접 보이게 하기 위해서는 카메라 또는 geometry(골격)와 같은 다른 구성 element를 노드에 추가해야 한다.

이 작업을 할 수 있는 공간이 바로 Material이다.

그래 바로 설정 창에 구 형태를 누르면 나타나는 곳이다.

<img width="1110" alt="스크린샷 2024-02-16 오후 7 28 28" src="https://github.com/jinyongyun/ARKit_SolarSystem_APP/assets/102133961/55cbedfe-c3a8-44d6-8702-ee7b639e2720">


 위에서도 말했듯이 조명과 카메라 그리고 골격을 설정할 수 있는 공간이다.

Material Inspector로 들어가보면 Diffuse를 설정할 수 있다.

Diffuse는 영어로 퍼지다. 확산하다. 라는 의미이다.

객체에 재질의 질감과 색을 변경할 수 있는 특성으로 객체에 질감과 색을 물감처럼 퍼뜨려주는 것이다.

art에서 대략적으로 중요한 내용을 다뤘으니, 또 무슨 파일이 변경됐는지 파악해보자.

기본 viewController에 들어가보면…

<img width="1385" alt="스크린샷 2024-02-16 오후 7 32 35" src="https://github.com/jinyongyun/ARKit_SolarSystem_APP/assets/102133961/8dcb80d1-b39d-49c8-ac3b-b319ea862b67">


아니 이게 뭐시여…!

뭐가 이렇게 많아졌어

여기서 가장 중요하게 살펴봐야 하는 곳은

```swift
override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
```

밑줄 친 저부분이다.

## Session

ARSession은 motion tracking, 이미지 분석과 같은 모든 AR 경험과 관련된 주요 작업을 관리하는 객체이다.

AR를 만들기 위해 ARKit가 사용자를 대신하여 수행하는 major process를 조정한다. 

이러한 process는 하드웨어에서 데이터 읽기, device의 내장 카메라 제어, 캡처된 카메라 이미지에 대한 이미지 분석 수행 등이 있다.

**AR 경험을 하기 위해서는 ARSession이 꼭 필요하닷!**

if 사용자가 커스텀 renderer를 구현하고싶다면 Session을 직접 인스턴스화할 수 있다.

```swift
let session = ARSession()
session.delegate = self
```

ARSessionDelegate에는 그럼 어떤 함수가 있을까?

> ARSessionDelegate
> 
> 
> ## **[Topics](https://developer.apple.com/documentation/arkit/arsessiondelegate#topics)**
> 
> **[Receiving Camera Frames](https://developer.apple.com/documentation/arkit/arsessiondelegate#2880793)**
> 
> `[func session(ARSession, didUpdate: ARFrame)](https://developer.apple.com/documentation/arkit/arsessiondelegate/2865611-session)`
> 
> Provides a newly captured camera image and accompanying AR information to the delegate. *(새롭게 캡쳐된 카메라 이미지를 제공하고 이에 대한 ARSession 정보를 제공한다!)*
> 
> **[Handling Content Updates](https://developer.apple.com/documentation/arkit/arsessiondelegate#2880566)**
> 
> `[func session(ARSession, didAdd: [ARAnchor])](https://developer.apple.com/documentation/arkit/arsessiondelegate/2865617-session)`
> 
> Tells the delegate that one or more anchors have been added to the session.
> 
> *(session에 추가된 anchor를 delegate에 말해준다. → Anchor가 뭔데)*
> 
> ### ARAnchor //
> 
> [ARAnchor | Apple Developer Documentation](https://developer.apple.com/documentation/arkit/aranchor)
> 
> An object that specifies the position and orientation of an item in the physical environment. → 즉 위치와 방향에 대한 프로퍼티를 갖고 있는 클래스
> 
> 이해가 딱 안되서…스택 오버플로우를 뒤지다 다음과 같은 구문을 발견했다.
> 
> Andy Zazz라는 분이 작성해주신 문구이다.
> 
> <aside>
> 💡 ARAnchor
> 
> `ARAnchor` is an **invisible trackable object** that holds a 3D model at anchor's position. Think of `ARAnchor` as a `parent transform node` of your model that you can translate, rotate and scale like any other node in SceneKit or RealityKit. Every 3D model has a pivot point, right? So, this pivot point must match a location of an `ARAnchor` in AR app.
> 
> If you're not using anchors in ARKit or ARCore app (in RealityKit iOS, however, it's impossible not to use anchors because they are integral part of a scene), your 3D models may drift from where they were placed, and this will dramatically impact app’s realism and user experience. Hence, anchors are crucial elements of any AR scene.
> 
> ---
> 
> ### `ARAnchor`는 앵커 위치에 3D 모델을 고정하는 **보이지 않는 추적 가능한 개체**입니다. SceneKit 또는 RealityKit의 다른 노드처럼 변환, 회전 및 크기 조정이 가능한 모델의 '상위 변환 노드'로 'ARAnchor'를 생각해 보세요. 모든 3D 모델에는 피벗 포인트가 있습니다. 그렇죠? 따라서 이 피봇 포인트는 AR 앱의 'ARAnchor' 위치와 일치해야 합니다.
> ARKit 또는 ARCore 앱에서 앵커를 사용하지 않는 경우(그러나 RealityKit iOS에서는 앵커가 장면의 필수적인 부분이기 때문에 앵커를 사용하지 않는 것은 불가능합니다) 3D 모델이 배치된 위치에서 표류할 수 있으며 이는 극적으로 발생합니다. 앱의 현실감과 사용자 경험에 영향을 미칩니다. 따라서 앵커는 모든 AR 장면에서 중요한 요소입니다.
> 
> </aside>
> 
> `[func session(ARSession, didUpdate: [ARAnchor])](https://developer.apple.com/documentation/arkit/arsessiondelegate/2865624-session)`
> 
> Tells the delegate that the session has adjusted the properties of one or more anchors. *(anchor 업데이트 됐을 때)*
> 
> `[func session(ARSession, didRemove: [ARAnchor])](https://developer.apple.com/documentation/arkit/arsessiondelegate/2865622-session)`
> 
> Tells the delegate that one or more anchors have been removed from the session.
> 
> *(ARAnchor 삭제됐을 때)*
> 

만약 커스텀 renderer를 구현하지 않고,  ARView, ARSCNView, ARSKView와 같은 표준 renderer 중 하나를 사용한다면 renderer는 사용자를 위한 session object를 생성한다.

- ARView
- ARSCNView : for 2D
- ARSKView : for 3D

## Configuration

Session을 실행하기 위해서는 configuration이 필요하다. ARConfiguration의 하위 클래스는 실제 세계와 관련된 device의 위치와 motion을 tracking하는 방법을 결정한다.

즉, ARSession을 구성하는 방법에 대한 정보가 포함된 기본적인 object이다. 선택한 configuration에 따라 이미지를 캡처하는 카메라와 앱에 표시되는 카메라 feed가 결정된다.

**여기서 중요한 점은 선택한 configuration에 따라 ARkit가 인식하고 앱에서 사용할 수 있는 실제 object의 종류가 결정된다는 것이다.**

ARConfiguration 자기 자신을 할당하지 말고 **해당 하위 클래스 중 하나를 인스턴스화**를 해야할 것을 잊지 말자.

Configuration 하위 객체 몇 가지를 살펴보자.

- **ARWorldTrackingConfiguration**
    
    ARKit가 장치의 후면 카메라를 사용하여 찾고 추적할 수 있는 모든 표면, 사람 또는 알려진 이미지 및 개체를 기준으로 장치의 위치 및 방향을 추적한다.
    
    쉽게 말해서 디바이스가 움직여도 가상객체는 현실에 있는 것처럼 착시를 만든다.
    
    [roll, pitch, yaw] 이 세 개의 회전 축과 [x,y,z] 이 세 가지 변환 축으로 장치의 이동을 추적한다.
    
- **ARBodyTrackingConfiguration**
    
    장치의 후면 카메라를 사용하여 사람, 비행기 및 이미지를 추적할 수 있다.
    
- **AROrientationTrackingConfiguration**
    
    후면 카메라를 사용하여 장치의 방향만 추적한다.
    
- **ARImageTrackingConfiguration**
    
    장치의 후면 카메라를 사용하여 이미지 tracking을 통해 제공한 알려진 이미지만 추적한다.
    
- **ARFaceTrackingConfiguration**
    
    움직임과 표정을 포함하여 장치의 셀카 카메라에 있는 얼굴만 추적한다.
    
    자 이제 본격적으로 도형을 만들어보자!
    
    ### 1.원하는 모양 생성
    
    (ARKit의 기본 단위는 m이다. 피트가 절대 아니다)
    
    | SCNText | 3차원 텍스트 | SCNCapsule | 캡슐 모양 | SCNPlane | 평면 모양 | SCNTorus | 튜브 모양 |
    | --- | --- | --- | --- | --- | --- | --- | --- |
    | SCNFloor | 비닥에 반사 | SCNCone | 원뿔 모양 | SCNPyramid | 피라미드 모양 | SCNTube | 구멍 원통 모양 |
    | SCNBox | 정육면체 | SCNCylinder | 원통 모양 | SCNSphere | 구 모양 |  |  |
    
    ```swift
    //**chamferRadius: 모서리 라운드 정도**
    let cube = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.01)
    ```
    
    우리는 정육면체로 다음과 같이 만들어줬다.
    
    ### 2.재질 설정
    
    위에서 말한 diffuse 특성을 이용해 재질 및 색상 그리고 png 파일로 객체 외관을 설정할 수 있다,
    
    ```swift
            // 재료 설정을 위해 material 객체 생성
            let material = SCNMaterial()
            
            //색상
            material.diffuse.contents = UIColor.black
            
            // 큐브에 재질을 만든 재질로 변경 ( 배열로 감싼다 )
            cube.materials = [material]
    ```
    
    ### 3.Node의 위치와 geometry를 설정한다
    
    ```swift
            // position의 타입은 SCNVector3이다.
            // z축만 음수인 이유는 우리가 생각하는 x,y,z의 방향과 다르기 때문!
            // y축이 물체의 위에서 아래를 관통하여 돌아가고
            // z축이 우리가 아는 y축처럼 우리가 물체를 정면에서 봤을 때 들어가는 방향이다.
            node.position = SCNVector3(x: 0, y: 0.05, z: -0.5)
            
            //골격 또는 뼈대라고도 불린다.
            node.geometry = cube
     
    ```
    
    ### 4.addChildNode로 생성한 노드를 추가한다
    
    ```swift
            // addChildNode로 새로운 노드를 추가.
            sceneView.scene.rootNode.addChildNode(node)
            
            // 아직 빛과 그림자 설정을 안해줬다.
            // autoenablesDefaultLighting는 자동으로 조명값을 만들어 준다.
            sceneView.autoenablesDefaultLighting = true
    ```
    
    - 시연 영상
   
    

https://github.com/jinyongyun/ARKit_SolarSystem_APP/assets/102133961/54b7f7fe-a2be-449c-a36e-03eeee718b86


    뒤에 집이 보여서 조금 민망한…
        
    아래는 전체 코드이다.
    
    ```swift
    //
    //  ViewController.swift
    //  ARKitTest
    //
    //  Created by jinyong yun on 2/16/24.
    //
    
    import UIKit
    import SceneKit
    import ARKit
    
    class ViewController: UIViewController, ARSCNViewDelegate {
    
        @IBOutlet var sceneView: ARSCNView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Set the view's delegate
            sceneView.delegate = self
            
            // Show statistics such as fps and timing information
            sceneView.showsStatistics = true
            
            self.makeSphere()
            
            
            
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            // Create a session configuration
            let configuration = ARWorldTrackingConfiguration()
    
            // Run the view's session
            sceneView.session.run(configuration)
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            // Pause the view's session
            sceneView.session.pause()
        }
    
        // MARK: - ARSCNViewDelegate
        
        func makeSphere() {
            
                // 정육면체를 만든다 (chamferRadius: 모서리 라운드 정도)
                let cube = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.01)
                
                // 재료 설정을 위해 material 객체 생성
                let material = SCNMaterial()
                
                //색상
                material.diffuse.contents = UIColor.black
                
                // 큐브에 재질을 만든 재질로 변경 ( 배열로 감싼다 )
                cube.materials = [material]
                
              
                // Node를 만들기!
                
                // SCNNode는 기본적으로 3D 공간의 위치를 나타낸다.
                // 위치를 지정 -> 개체를 생성해야한다.
                // SCNNode안에는 기본적으로 아무것도 보이지 않습니다. (아까 위에서 커스텀 노드는 아무 것도 보이지 않는다고 했죠!)
                // 눈에 보이게 하려면 조명, 카메라 또는 골격과 같은 다른 구성 요소를 노드에 추가해야 한다.
                let node = SCNNode()
                
                // position의 타입은 SCNVector3이다.
                // z축만 음수인 이유는 우리가 생각하는 x,y,z의 방향과 다르기 때문!
                // y축이 물체의 위에서 아래를 관통하여 돌아가고
                // z축이 우리가 아는 y축처럼 우리가 물체를 정면에서 봤을 때 들어가는 방향이다.
                node.position = SCNVector3(x: 0, y: 0.05, z: -0.5)
                
                //골격 또는 뼈대라고도 불린다.
                node.geometry = cube
                
                // addChildNode로 새로운 노드를 추가.
                sceneView.scene.rootNode.addChildNode(node)
                
                // 아직 빛과 그림자 설정을 안해줬다.
                // autoenablesDefaultLighting는 자동으로 조명값을 만들어 준다.
                sceneView.autoenablesDefaultLighting = true
            }
        
    }
    ```
    

# 🪐 태양계 AR 앱 만들기!

이제 본격적으로 태양계 AR앱을 만들어보자! 

[Solar System Scope](https://www.solarsystemscope.com/textures/)

해당 사이트에서 이미지를 가져왔다.


<img width="273" alt="스크린샷 2024-02-20 오전 11 52 00" src="https://github.com/jinyongyun/ARKit_SolarSystem_APP/assets/102133961/5000555c-1f66-47d2-8fc4-3a27cde11961">

좀 지저분해 보이는데…나중에 폴더로 정리해주자.

수금지화목토천해명의 이미지를 위의 사이트에서 다운받아 art의 Add File To “art.scnassets” 를 눌러 추가한다.

그럼 나중에 이미지를 

art.scnassets/\(planetname).jpeg

로 접근할 수 있을 것이다.

우리가 그 다음 해야할 일은 위에서 만들었던 도형 만들기와 다르지 않다.

다만 그 도형에다 material을 씌워주기만 하면 된다.

```swift
override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        self.makeUNIV()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    
    func makePlanet( _ radius: Double, _ planetname: String, _ zposition: Float) -> SCNNode {
        // 구 모양을 원하는 반지름의 크기로 생성한다. 행성간 실제 비율을 cm로 환산하여 적용했다.
        let sphere = SCNSphere(radius: radius)
        
        let material = SCNMaterial()
        
        // 추가한 texture 파일을 UIImage로 불러오기만 하면된다.
        // art.scnassets 폴더 안에 있으므로 (/)를 통해 경로를 추가하여 넣어준다.
        material.diffuse.contents = UIImage(named: "art.scnassets/\(planetname).jpeg")
        
        sphere.materials = [material]
        
        let node = SCNNode()
        
        node.position = SCNVector3(x: 0, y: 0, z: zposition)
        
        node.geometry = sphere
        
        return node
    }
    
    
    func makeUNIV() {
       
        let nodeMercury = makePlanet(0.1, "mercury", 0.01)
        let nodeVenus = makePlanet(0.6, "venus", 10.3)
        let nodeEarth = makePlanet(0.7, "earth", 30.4)
        let nodeMars = makePlanet(0.2, "mars", 50.2)
        let nodeJupiter = makePlanet(10.9, "jupiter", 70.0)
        let nodeSaturn = makePlanet(9.1, "saturn", 90.2)
        let nodeUranus = makePlanet(3.7, "uranus", 110.4)
        let nodeNeptune = makePlanet(3.6, "neptune", 140.0)
        
        // 배경을 추가하기
        // sceneView 자체의 background에 접근하여 배경을 설정해줌
        sceneView.scene.background.contents = UIImage(named: "art.scnassets/space.jpeg")
        
        sceneView.scene.rootNode.addChildNode(nodeMercury)
        sceneView.scene.rootNode.addChildNode(nodeVenus)
        sceneView.scene.rootNode.addChildNode(nodeEarth)
        sceneView.scene.rootNode.addChildNode(nodeMars)
        sceneView.scene.rootNode.addChildNode(nodeJupiter)
        sceneView.scene.rootNode.addChildNode(nodeSaturn)
        sceneView.scene.rootNode.addChildNode(nodeUranus)
        sceneView.scene.rootNode.addChildNode(nodeNeptune)
        
        sceneView.autoenablesDefaultLighting = true
        
        
    }
```

만들어 준 함수는 단지 두 가지, 행성 자체의 node를 구성하는 makePlanet 함수와 

그 노드들을 모아서 태양계를 구성해주는 makeUNIV 함수이다.

원래 두 함수의 내용이 모두 makeUNIV 함수에 들어있었는데, 모듈화를 위해 두 함수를 분리해줬다.

makePlanet 함수는 인자로 [행성 반지름, 이미지 Url에 사용될 행성 이름, z축 위치 값]을 받는다.

해당 함수에서 리턴한 노드를 makeUNIV 함수에서 addChildNode하여 루트 노드에 하위로 추가해준다.

대부분 위에서 다룬 도형 만들기 파트와 유사하니 코드가 어렵지는 않을 것이다.



https://github.com/jinyongyun/ARKit_SolarSystem_APP/assets/102133961/a45c53bc-84f9-4aac-b2f2-3919bc7d2419



***다만 문제는 행성 반지름 비율을 실제 행성에 맞추다 보니, 목성이 너무 커서 뒤에 행성이 보이지 않는다는 문제점이 있다.*** 

그럼 어떻게 해야 할까…? 

한 번 돌려볼까? 

## 서브미션: 실제 공전과 자전을 시켜보자!

먼저 각 행성이 돌기 위해서는 중심축이 있어야 한다. 

당연히 태양계에서의 중심은 태양! 

그래서 nodeSun을 만들어줬다.

```swift
let nodeSun = makePlanet(0.9, "sun", -1)
```

그런 다음 위에서 우리가 만들어줬던 makePlanet 함수에다 action 메서드를 추가해줬다.

씬 액션 클래스의 축을 중심으로 회전하게 하는 rotateBy 메서드를 이용하여 자전을 위한 액션을 만들어줬다. 이녀석을 통해 y축으로 360도 만큼 회전시키는 동작을 8(TimeInterval → typealias한 Double임)동안 해줬다. 

당연히 이 동작이 계속 진행되어야 하므로, repeatForever 메서드를 통해 액션을 늘린 다음, 각 행성 노드가 액션을 수행할 수 있도록 runAction 메서드를 이용해 액션을 수행시켰다.

자전은 rotateBy에 의해 직관적으로 만들 수 있었다.

```swift
func makePlanet( _ radius: Double, _ planetname: String, _ zposition: Float) -> SCNNode {
        // 구 모양을 원하는 반지름의 크기로 생성한다. 행성간 실제 비율을 cm로 환산하여 적용했다.
        let sphere = SCNSphere(radius: radius)
        
        let material = SCNMaterial()
        
        // 추가한 texture 파일을 UIImage로 불러오기만 하면된다.
        // art.scnassets 폴더 안에 있으므로 (/)를 통해 경로를 추가하여 넣어준다.
        material.diffuse.contents = UIImage(named: "art.scnassets/\(planetname).jpeg")
        
        sphere.materials = [material]
        
        let node = SCNNode()
        
        node.position = SCNVector3(x: 0, y: 0, z: zposition)
        
        node.geometry = sphere
        
        **let action = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreeToRadians), z: 0, duration: 8)
        let forever = SCNAction.repeatForever(action)
        node.runAction(forever)**
        
        return node
    }

...

extension Int {
//360을 라디안 표기로 바꿔주는 extension이다. 지금생각하면 그냥 2*.pi 해도 동작했을텐데
    var degreeToRadians: Double { return Double(self) * .pi/180 }
}
```

그렇다면 공전은 어떻게 만들어야 할까

rotateTo 메서드, rotate 메서드를 이것저것 이용해보았으나

모두 자신의 축을 중심으로 회전할 뿐 공전이 제대로 이루어지지 않았다.

한참을 고민하다 한가지 아이디어가 떠올랐다.

**어라…만약 자전만 가능하다면 태양을 중심으로 자전하는 거대한 노드를 만든 다음 그 노드 하위에 행성 노드들을 넣으면 자전하는 거지만 보이기에는 공전처럼 보이지 않을까?**

이 말이 이해가 어려우면 다음 그림을 보자.

필자가 직접 그린 그림이다.

![Untitled (Draft)-9 2](https://github.com/jinyongyun/ARKit_SolarSystem_APP/assets/102133961/4ccc239d-20e3-4569-92bd-e33efa792ae9)

그래서 PlanetParent 노드를 만드는 함수를 작성해줬다.

태양을 중심축으로 자전해야하니 SCNVector3를 0,0,-1로 맞춰줬다. (위에서 nodeSun을 만들어줬던 것을 보면 역시 0,0,-1로 태양 위치를 설정했다.)

그 다음 sceneView.scene.rootNode 즉 씬의 루트 노드에다 해당 노드를 추가했다.

태양과 같은 위치 선정이다. 즉 태양과 동레벨의 노드!

행성들의 자전 액션 메서드와 똑같이 자전 액션을 넣어준다음

노드를 리턴했다.

rotateBy 메서드에 duration에 랜덤값을 준 이유는 모든 행성의 공전 주기가 다르기 때문이다.

전부다 20으로 한 다음 시뮬을 돌려보니 뭔가 어색해서 이렇게 바꿔줬다.

```swift
func makePlanetParent() -> SCNNode {
        let parentNode = SCNNode()
        parentNode.position = SCNVector3(0, 0, -1)
        sceneView.scene.rootNode.addChildNode(parentNode)
        let randomDur = Int.random(in: 20...50)
        let parentRotaion = SCNAction.rotateBy(x: 0, y: 2 * .pi, z: 0, duration: TimeInterval(randomDur))
        let parentRotationRepeat = SCNAction.repeatForever(parentRotaion)
        parentNode.runAction(parentRotationRepeat)
        return parentNode
    }
```

리턴한 노드는 다음과 같이 위에서 만든 행성들을 추가하는데 사용된다.

```swift
func makeUNIV() {
        
        let mercuryParentNode = makePlanetParent()
        let venusParentNode = makePlanetParent()
        let earthParentNode = makePlanetParent()
        let marsParentNode = makePlanetParent()
        let jupiterParentNode = makePlanetParent()
        let saturnParentNode = makePlanetParent()
        let uranusParentNode = makePlanetParent()
        let neptuneParentNode = makePlanetParent()
        
        let nodeSun = makePlanet(0.9, "sun", -1)
        let nodeMercury = makePlanet(0.1, "mercury", 5.1)
        let nodeVenus = makePlanet(0.6, "venus", 10.3)
        let nodeEarth = makePlanet(0.7, "earth", 30.4)
        let nodeMars = makePlanet(0.2, "mars", 50.2)
        let nodeJupiter = makePlanet(10.9, "jupiter", 150.0)
        let nodeSaturn = makePlanet(9.1, "saturn", 170.2)
        let nodeUranus = makePlanet(3.7, "uranus", 190.4)
        let nodeNeptune = makePlanet(3.6, "neptune", 210.0)
        
        sceneView.scene.rootNode.addChildNode(nodeSun)
        mercuryParentNode.addChildNode(nodeMercury)
        venusParentNode.addChildNode(nodeVenus)
        earthParentNode.addChildNode(nodeEarth)
        marsParentNode.addChildNode(nodeMars)
        jupiterParentNode.addChildNode(nodeJupiter)
        saturnParentNode.addChildNode(nodeSaturn)
        uranusParentNode.addChildNode(nodeUranus)
        neptuneParentNode.addChildNode(nodeNeptune)
        
        // 배경을 추가하기
        // sceneView 자체의 background에 접근하여 배경을 설정해줌
        sceneView.scene.background.contents = UIImage(named: "art.scnassets/space.jpeg")
        
        
        sceneView.autoenablesDefaultLighting = true
        
        
    }
```

 SCNNode 배열을 만들어 forEach로 돌리면 코드가 좀 더 깔끔했을테지만

보다 직관적으로 볼 수 있도록 저렇게 구성했다.

## 실제 구동 화면

필자의 폰으로 직접 촬영한 앱의 구동 화면이다.


https://github.com/jinyongyun/ARKit_SolarSystem_APP/assets/102133961/ee2d0509-36fb-42d8-be02-862ffb763fce


