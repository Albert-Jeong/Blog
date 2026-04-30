---
draft: false
tags:
  - 2-1/LG-AI-7
date: 2025-07-01
---
> 노트 내용 [[07_Classification]]으로 옮기는 중

## 1. Soft Guess (부드러운 예측)
- 분류 문제에서 예측 방식은 두 가지로 나뉜다.
	1. **Hard guess**: $g_\theta(x^{(i)}) = 1$ 또는 $-1$로 단정적으로 분류
	2. **Soft guess**: ==각 클래스에 속할 확률을 출력==
		- $g_\theta(x^{(i)}) = \begin{bmatrix} Pr(y^{(i)}=-1) \ Pr(y^{(i)}=1) \end{bmatrix}$
		- 예: 일기예보처럼 "비 올 확률 70%"와 같이 확신의 정도를 함께 표현하는 것

## 2. Logistic Regression: Model Class
- **Logistic function (sigmoid)**
	- $\sigma(x) = \dfrac{1}{1+e^{-x}}$
	- 부드럽고(smooth) ==출력값이 0~1 사이라 확률을 모델링하기 적합==하다.

- **Model class**
	- $\mathcal{G} = \left\{ g_{a,b}(x) = \begin{bmatrix} \dfrac{e^{-(a^Tx+b)}}{1+e^{-(a^Tx+b)}} \\ \dfrac{1}{1+e^{-(a^Tx+b)}} \end{bmatrix} \right\}$

- 선형식 $a^Tx+b$의 절댓값이
	- **작으면** 결정 경계 근처라 두 클래스 확률이 비슷해지고,
	- **크면** 어느 한 쪽 확률이 1에 가까워진다.

- 로지스틱 회귀에서 선형 예측값 $z = w^T x + b$가 바로 logit이며,
	- 이를 다시 확률로 변환할 때 **Sigmoid**를 사용한다.

### 2.1. 예시
- 이진 분류 모델의 최종 출력:
$$\hat{y} = \sigma(w^T x + b) = \frac{1}{1 + e^{-(w^T x + b)}}$$
- $\hat{y} \geq 0.5$ → 클래스 1로 분류
- $\hat{y} < 0.5$ → 클래스 0으로 분류

## 3. Cross Entropy Loss
- 손실 함수
	- $\ell(g_{a,b}(x^{(i)}), y^{(i)}) = \log \dfrac{1}{\hat{y}(y^{(i)})}$
	- 여기서 $\hat{y}(y^{(i)})$는 실제 라벨에 모델이 부여한 확률이다.

- 이는 **KL divergence(쿨백-라이블러 발산)**에서 유도되며, 두 분포 간 차이를 측정한다.
	- $D(p|q) = \sum_x p(x) \log \frac{p(x)}{q(x)}$

## 4. Logistic Regression 전체 구성
- **Dataset**: $(x^{(1)}, y^{(1)}), ..., (x^{(n)}, y^{(n)})$, 라벨은 binary
- **Function class**: 위의 sigmoid 기반 모델
- **Loss function**: $y \in {-1, +1}$일 때 통합된 형태로 표현 가능
$$\mathcal{L}(\theta) = -\frac{1}{n}\sum_{i=1}^n \left[\frac{1+y^{(i)}}{2}\log(g_\theta(x^{(i)})) + \frac{1-y^{(i)}}{2}\log(1-g_\theta(x^{(i)}))\right]$$

정리하면 매우 깔끔한 형태로 떨어진다.
$$\boxed{\mathcal{L}(\theta) = \frac{1}{n}\sum_{i=1}^n \log(1+e^{-y^{(i)}\theta^T x^{(i)}})}$$
이는 미분 가능하므로 **Gradient Descent**를 적용할 수 있다.

- **Logistic Loss vs. Hinge Loss**
	- Logistic loss $h(z) = \log(1+e^{-z})$는 부드럽게 감소하고,
	- Hinge loss $\max(0, 1-x)$는 꺾인 형태이다. (SVM에서 사용)

## 5. Multiclass Classification & Softmax
- **Logistic ⊆ Softmax**
	- ($h_0=0$, $h_1=a^Tx+b$로 두면 logistic regression과 동일)

- **Softmax Regression 구성**
	- Function class: $h = Ax + B$, $\hat{y} = \sigma(h)$, $A \in \mathbb{R}^{d\times k}$, $B \in \mathbb{R}^k$
	- Loss function: 동일하게 cross entropy $\ell = \log \dfrac{1}{\hat{y}(y^{(i)})}$

## 6. 평가 지표: Precision, Recall, ROC
- 모델이 $[0.7, 0.3]$을 출력했을 때 임계값(threshold)을 어디로 정할지가 문제이다.
	- 0.5가 기본이지만, **COVID 검사**처럼 false negative를 줄이는 게 중요한 상황에서는 false positive를 감수하더라도 임계값을 낮추는 게 유리하다.

- **주요 지표**
	- **정밀도**(Precision): $\text{Precision} = \dfrac{tp}{tp+fp}$
	- **재현율**(Recall): $\text{Recall} = \dfrac{tp}{tp+fn}$
	- Precision과 Recall은 **trade-off** 관계
	- **F1-score**: Precision과 Recall의 조화평균
	
	- **ROC Curve**: TPR(=Recall) vs. FPR을 임계값에 따라 그린 곡선

- 완벽한 분류기: 좌상단 (TPR=1, FPR=0)
- 무작위 추측(random guess): 대각선
- 곡선이 좌상단에 가까울수록 좋은 모델

- 극단 케이스로 항상 positive라고 하면 TPR=FPR=1, 항상 negative면 TPR=FPR=0이 됩니다.