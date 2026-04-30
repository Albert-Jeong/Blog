---
draft: false
tags:
  - 2-1/PyTorch
date: 2025-06-25
---
## 흐름
- 손실함수 개선(MSE→CEE)
	- → 신경망 깊이(Deep)
	- → 활성함수 개선(Sigmoid→ReLU)
	- → 일반화 기법(Dropout)
	- → 구조 개선(FCN→CNN)

## 1. CEE
|  구분   |       Entropy        |    Cross Entropy     |                 Cross Entropy Error                  |
| :---: | :------------------: | :------------------: | :--------------------------------------------------: |
|  목적   |    단일 분포의 불확실성 측정    |     두 분포 간 차이 측정     |                   모델 학습을 위한 손실 함수                    |
|  입력   |      분포 $P$ 하나       | 실제 분포 $P$, 예측 분포 $Q$ |              정답 레이블 $y$, 예측값 $\hat{y}$               |
|  수식   | $-\sum p_i \log p_i$ | $-\sum p_i \log q_i$ | $-\frac{1}{N}\sum_n \sum_k y_{nk} \log \hat{y}_{nk}$ |

### 1.1. Entropy (엔트로피)
- **정의**: 정보를 표현하는 데 필요한 최소 평균 자원량(bit 수)

- **핵심 개념**
	- 발생확률이 큰 사건은 짧게 코딩, 발생확률이 작은 사건은 길게 코딩하는 것이 효율적
	- 코딩 길이 = -log₂(발생확률)
	- 공식: **H(p) = -Σ pᵢ log₂(pᵢ)**

- **특징**
	- 확률분포가 균일할 때 → 엔트로피 최대 (worst case)
	- 확률분포가 불균일할 때 → 엔트로피 최소 (best case)
	- 엔트로피보다 더 짧게 코딩하는 것은 불가능

### 1.2. Cross-Entropy (교차 엔트로피)
- **관계식**: Cross Entropy = Entropy + KL Divergence (α)

- 예측이 실제보다 비효율적이므로 Cross Entropy ≥ Entropy
- 두 분포가 같아질수록 Cross Entropy는 Entropy에 가까워짐

### 1.3. Cross-Entropy Error (CEE)
> 정답 클래스에 높은 확률을 줄수록 loss 감소
> 정답 클래스에 낮은 확률을 주거나, 오답 클래스에 높은 확률을 줄수록 loss 증가

- **용도**: 분류(classification) 문제의 손실함수, MSE의 대안
- **공식**: -Σ Yᵢ' · log(Yᵢ) (Y'=정답, Y=예측)
- 예측분포와 정답분포가 동일하면 CEE는 0에 수렴
- one-hot vector(정답)도 확률분포로 취급 가능

## 2. MNIST 학습 모델 발전 단계
|      모델       |  활성함수   |       기법       |  정확도   |
| :-----------: | :-----: | :------------: | :----: |
| 1-layer + MSE |    -    |       -        | 91.2%  |
| 1-layer + CEE |    -    |       -        | 92.1%  |
| 5-layer + CEE | Sigmoid |      Adam      | 97.36% |
| 5-layer + CEE |  ReLU   |      Adam      | 98.13% |
| 5-layer + CEE |  ReLU   | Adam + Dropout | 98.20% |

### 2.1. 1-Layer + CEE (TH125)
> 분류 문제에 적합한 **Cross-Entropy** 손실함수 도입
> 출력층에 **Softmax**를 사용하여 확률분포로 변환

- MSE 대비 약간 개선 → **정확도 92.1%**

- PyTorch의 `CrossEntropyLoss()`는 내부적으로 Softmax 포함
	- → 학습 시 모델에 `nn.Softmax()`를 넣지 말 것 (학습 효율 저하)
	- → 추론 시에는 Softmax 사용 가능

### 2.2. 5-Layer Deep NN + Sigmoid + Adam (TH300)
- 구조: 784 → 200 → 100 → 60 → 30 → 10
- **정확도 97.36%** 로 크게 개선
- 문제점: **학습 시작이 매우 느림 (slow start)**

#### (1) Adam
- **Adam**(adaptive moment estimation)

#### (2) Vanishing Gradient 문제
> **Sigmoid** 사용 시 층이 깊어질수록 학습이 안 되는 **기울기 소실(Vanishing Gradient)** 현상 발생 (초반 학습 느림)

> **경사 소실(Vanishing Gradient) 문제**
> 역전파할 때 기울기(gradient)가 너무 작아져서 가중치가 거의 업데이트되지 않는 현상

- Sigmoid 양 끝단에서 gradient가 0에 수렴
- 깊은 신경망의 input layer 쪽으로 갈수록 gradient 소실
    - 예: (0.3)¹⁰ = 0.000006
- Sigmoid의 최대 gradient = 0.3
- **해결책**: ReLU 또는 PReLU 사용 (양의 구간에서 gradient = 1 유지)

### 2.3. 5-Layer + ReLU + Adam (TH310)
- *Sigmoid 대신* ReLU 적용으로 slow start 문제 해결
- **정확도 약 98.13%**
- 새로운 문제: **과적합(Overfitting) 발생**
	- *훈련 데이터에는 너무 잘 맞지만 새로운 테스트 데이터에는 성능이 떨어지는 현상*

#### (1) Dropout 적용 (TH320)
- **드롭아웃**(Dropout)
	- 학습 시 뉴런의 일부를 랜덤하게 비활성화 → 더 작은 sub-network로 학습
	- ==과적합(Overfitting) 문제 개선== (정확도 약 98.20%)

- 일반적으로 p = 20% ~ 50%
- **학습 시(`model.train()`)만 활성화**, 추론 시(`model.eval()`)는 자동으로 비활성화

- 모델 구조 예시 (Dropout 적용)
```
Flatten → Linear(784,200) → ReLU → Dropout
        → Linear(200,100) → ReLU → Dropout
        → Linear(100,60)  → ReLU → Dropout
        → Linear(60,30)   → ReLU → Dropout
        → Linear(30,10)
```

## 3. FCN의 한계 → CNN 필요성
- **FCN(Fully Connected Network)의 문제점**
	- 2D 이미지를 1D로 펼쳐야 함 (28×28 → 784)
	- **데이터의 형상(공간) 정보가 무시됨**
	- 이미지의 본질적 패턴을 학습하기 어려워 인식률 저하

- **해결책**: **CNN(Convolutional Neural Network)**
	- 2D/3D 이미지를 그대로 입력받아 형상 정보 활용
	- FCN보다 정확한 이미지 인식 가능

> [[05_CNN|합성곱 신경망(CNN; Convolutional Neural Network)]]