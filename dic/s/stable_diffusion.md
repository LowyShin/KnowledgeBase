# Stable Diffusion

2022년 공개된 딥러닝(deep learning, 심층학습)의 text-to-image학습모델 중 하나. 

텍스트를 입력하여 이미지를 생성하는데 많이 사용되는 경우가 많음. 

뮌헨 대학의 CompVis그룹이 개발한 잠재확산모델(latent diffusion model)로서 심층생성 뉴럴 네트워크(deep generative neural network)의 일종.

이 모델은 EleutherAI와 LAION의 지원을 받아 Stability AI, CompVis LMU, Runway가 공동으로 공개했다. 

2022년 10월 Stability AI는 Lightspeed Venture Partners와 Coatue Management가 주도한 라운드에서 1억100만달러를 조달했다. 

## 기술

![Stable_Diffusion_architecture](https://upload.wikimedia.org/wikipedia/commons/f/f6/Stable_Diffusion_architecture.png)
- https://ja.wikipedia.org/wiki/Stable_Diffusion

기본 개념은 화상을 픽셀공간에서 저차원잠재공간으로 압축하여 화상에서의 기본 의미를 찾는다. 
압축된 잠재표현에 순방향 확산 처리(forward diffusion process)에서 가우시안 노이즈가 연속적으로 부여된다.  
ResNet으로 구성된 U-Net블록은 잠재표현을 얻기 위해 순방향 확산 과정의 출력을 다시 노이즈 제거를 진행한다. 
이걸 역방향 확산 처리(reverse diffusion process)라고 한다.
마지막으로 VAE디코더가 잠재 표현을 픽셀 공간에 역변환하여 최종 화상을 생성한다. 

노이즈 제거 과정은 문자열, 화상, 그 밖의 요소에 의해 유연하게 조건을 지정할 수 있다. 
인코드 된 조건 부여를 위한 데이터는 cross-attention구축에 의해 denosing U-Net에 부여된다. 

## 활용

- [stable diffusion을 이용한 AI 그림 생성 모듈을 쉽게 만든 WEBUI의 설치 방법](https://arca.live/b/aiart/68917133)
  - [AI가 실사와 애니풍을 정도를 조정해서 그려주는 사례](https://www.clien.net/service/board/park/17932600)
  - [PVC모델 적용 사례](https://prompts.co.kr/bbs/board.php?bo_table=gallery&wr_id=125)
- [AI Tool Reveals How Celebrities’ Faces Have Been Photoshopped](https://petapixel.com/2023/02/28/ai-tool-reveals-how-celebrities-faces-have-been-photoshopped/)
  - AI가 사진에서 어느 부분을 리터칭을 했는지 판별해 주는 툴

## 이슈

Stable Diffusion에서 생성된 화상의 원본중에 Pinterest가 9.5%, 기타 WordPress, Blogspot, Flickr, DevianArt, Wikipedia commons 등의 
웹사이트에서 약 1200만매의 화상을 가져와 샘플링 했기 때문에 이에 대한 저작권 이슈 등이 존재 한다. 


## 참고

- Wikipedia(ja) : https://ja.wikipedia.org/wiki/Stable_Diffusion
