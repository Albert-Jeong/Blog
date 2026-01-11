---
draft: false
tags:
  - 2-1/AI
date: 2025-07-01
---
## 1. 지도학습 개요 (Supervised Learning Overview)
- **정의**
	- 지도학습은 ==데이터($x$)와 정답 라벨($y$)이 주어졌을 때==,
	- 이를 가장 잘 설명하는 함수(모델)를 찾아내는 과정이다.

- **구성 요소**
	- **데이터(Data, $x$)**: 입력 벡터 (예: 이미지, 텍스트, 숫자 등)
	- **라벨(Label, $y$)**: 예측해야 할 정답 (예: 고양이/강아지, 주식 가격)
	- **함수 클래스(Model Class, $\mathcal{G}$)**: 데이터와 라벨의 관계를 나타내는 가설들의 집합 (예: 선형 모델 $y=ax+b$)
	- **손실 함수(Loss Function, $\ell$)**: 예측값($g(x)$)과 실제값($y$)의 차이를 측정하는 함수 (예: MSE, Cross-Entropy)

- **목표**
	- 손실 함수의 총합을 최소화하는 파라미터 $\theta$를 찾는 것

- **주요 예시**
	- 이미지 분류(Image Classification), 텍스트 분류, 다음 단어 예측, 번역, 가격 예측 등

## 2. 선형 회귀 (Linear Regression)
- **개념**
	- 입력 $x$와 출력 $y$ 사이에 선형 관계($y = ax + b$)가 있다고 가정하고 모델링하는 기법이다.

- **손실 함수**
	- **평균 제곱 오차**(MSE, Mean Squared Error)를 사용한다.
		- 오차의 제곱을 최소화하는 방식이며, 미분 가능하여 분석적 해를 구하기 용이하다.

- **최적화**
	- **정규 방정식(Normal Equation)**: 행렬 연산을 통해 한 번에 최적의 해($a = (X^T X)^{-1} X^T Y$)를 구할 수 있다.

- **과적합(Overfitting)과 과소적합(Underfitting)**
	- **과소적합 (High Bias)**: 모델이 너무 단순하여 데이터를 제대로 표현하지 못함
	- **과적합 (High Variance)**: 모델이 너무 복잡하여 학습 데이터에는 완벽하지만, 새로운 데이터(검증 셋)에 대한 예측력이 떨어짐

- **해결 방안**
	- 데이터 추가 확보 (Data Augmentation)
	- 검증 데이터셋(Validation Set) 활용
	- **규제(Regularization)**: 손실 함수에 가중치($a$)의 크기에 대한 페널티(L2 term 등)를 추가하여 모델의 복잡도를 낮춤
	- 교차 검증(Cross Validation)

## 3. 경사 하강법 (Gradient Descent)
> 가장 좋은 직선(파라미터)을 어떻게 찾을까?

- **필요성**
	- 딥러닝과 같이 모델이 복잡해지면 분석적(수식적)으로 한 번에 해를 구하기 어렵기 때문에 최적화 알고리즘이 필요하다.

- **기본 원리**
	- 손실 함수 $\mathcal{L}(\theta)$의 기울기(Gradient)를 구하고,
	- 기울기가 감소하는 방향으로 파라미터를 조금씩 업데이트한다. ($\theta_{i+1} = \theta_i - \alpha \nabla \mathcal{L}(\theta_i)$)

### 3.1. 학습률
- **학습률(Learning Rate, $\alpha$)**
	- ==너무 작으면 학습 속도가 느리고, 너무 크면 발산할 수 있다.==

- **주요 알고리즘 변형**
	- **SGD (Stochastic Gradient Descent)**
		- 데이터 1개마다 업데이트
		- 빠르지만 불안정함
	- **Mini-batch SGD**
		- 데이터를 작은 묶음(Batch)으로 나누어 업데이트 (가장 일반적)
	- **Momentum**
		- 이전의 이동 방향(관성)을 반영하여 지역 최소점(Local Minima) 탈출 및 학습 속도 향상
	- **RMSProp**
		- 기울기의 크기에 따라 학습률을 조절
	- **ADAM**
		- Momentum과 RMSProp의 장점을 결합한 알고리즘

- **학습률 스케줄링**
	- 학습 초기에는 큰 학습률을,
	- 후반에는 작은 학습률을 사용하여 안정적으로 수렴하게 함

## 4. 분류 (Classification)
- **회귀와의 차이**
	- 라벨 $y$가 연속적인 값이 아니라 이산적(Discrete, 예: -1 또는 1)인 값을 가진다.

- **퍼셉트론(Perceptron)**
	- 가장 단순한 선형 분류기
	- 오차가 있을 때만 가중치를 업데이트한다. (선형 분리 불가능하면 수렴 안 함)

- **SVM (Support Vector Machine)**
	- **마진(Margin)**: 결정 경계와 가장 가까운 데이터 포인트 사이의 거리
	- **목표**: ==마진을 최대화하는 결정 경계를 찾음으로써 모델의 일반화 성능을 높임==
	- **Soft-margin SVM**: 일부 오차(이상치)를 허용하여 해를 구할 수 있게 함
	- **Hinge Loss**: 0-1 Loss(미분 불가능) 대신 사용하는 SVM의 손실 함수
	- **커널(Kernel) 트릭**: 데이터를 고차원으로 매핑하여 선형 분리가 불가능한 데이터를 분류

## 5. 로지스틱 회귀 (Logistic Regression)
> 결과를 0과 1 사이의 확률(%)로 알려준다.

- **Soft Guess**
	- 결과를 0 또는 1로 딱 자르는 것이 아니라, 확률(0~1 사이의 값)로 예측한다.

- **시그모이드 함수 (Sigmoid/Logistic Function)**
	- 입력값을 0과 1 사이의 값으로 변환해주는 함수 ($\sigma(z) = \frac{1}{1+e^{-z}}$)

- **손실 함수: 크로스 엔트로피(Cross Entropy Loss)**
	- 두 확률 분포(예측 분포와 실제 분포) 간의 차이를 측정한다. (KL Divergence 개념 활용)
	- MSE보다 분류 문제에 더 적합하다.

- **다중 클래스 분류 (Multiclass Classification)**
	- **Softmax 함수**: 여러 클래스에 대한 예측값의 합이 1이 되도록 변환하여 확률처럼 해석 가능하게 함

- **평가 지표**
	- 단순 정확도(Accuracy) 외에 정밀도(Precision), 재현율(Recall), F1-Score, ROC 곡선 등을 사용하여 모델 성능을 다각도로 평가한다.

## 6. 지도학습 심화 및 그 외 (More on Supervised Learning and Beyond)
- **단순한 모델의 유용성**
	- 문제가 단순하면 딥러닝보다 전통적인 머신러닝이 더 효율적일 수 있다.

- **전통적 머신러닝 알고리즘**
	- **나이브 베이즈(Naive Bayes)**: 조건부 독립을 가정한 확률 기반 분류기 (스팸 필터 등)
	- **의사결정 나무(Decision Tree)**: 스무고개처럼 질문을 통해 데이터를 분류하거나 값을 예측 (Entropy 또는 Variance 활용)

- ==앙상블(Ensemble) 기법==
	- ==배깅(Bagging)==
		- 여러 모델을 병렬로 학습시켜 결과를 합침 (예: Random Forest)
		- 분산(Variance)을 줄여 과적합 방지
	- ==부스팅(Boosting)==
		- 모델을 순차적으로 학습시키며, 이전 모델이 틀린 데이터에 가중치를 둠 (예: AdaBoost)
		- 편향(Bias)을 줄임

- **지도학습 응용**
	- 초해상도(Super Resolution), BERT(언어 모델), 이상치 탐지(Anomaly Detection)

- **지도학습 그 너머**
	- **준지도 학습(Semi-Supervised Learning)**: 라벨이 있는 적은 데이터와 라벨이 없는 많은 데이터를 함께 활용
	- **생성형 모델(Generative Models)**: 데이터의 분포 $p(x)$를 학습하여 새로운 데이터를 생성
		- **GAN (Generative Adversarial Networks)**: 생성자(Generator)와 판별자(Discriminator)가 경쟁하며 학습
		- **Diffusion Models**: 노이즈를 점진적으로 제거하며 이미지를 복원/생성하는 최신 모델