---
draft: false
tags:
  - 2-1/LG-AI-7
date: 2025-07-01
---
## 요약
- Gradient Descent는 결국 네 가지 키워드로 요약된다.
	1. 기울기를 따라 내려간다.
	2. 무작위 초기화
	3. 학습률 조절
	4. 모멘텀 활용
	- 이 단순한 아이디어가 수십억 파라미터의 신경망까지 학습시키는 현대 딥러닝의 토대가 된다.

## 1. 배경: 왜 Gradient Descent가 필요한가
> 가장 좋은 파라미터를 어떻게 찾을까?

- 지도학습의 목표는 데이터셋 $(x^{(i)}, y^{(i)})$에 대해 손실함수 $\mathcal{L}(\theta) = \sum_{i=1}^{n} \ell(g_\theta(x^{(i)}), y^{(i)})$를 최소화하는 파라미터 $\theta$를 찾는 것이다.
	- 고등학교 수학에서는 $f'(x)=0$을 풀어 최솟값을 구하지만, 딥러닝에서는 이 접근이 어렵다.
	- ==함수 클래스가 매우 복잡하고==(파라미터가 수백만~수십억 개), 손실함수가 복잡해서 $\nabla \mathcal{L}(\theta) = 0$을 만족하는 ==해석해(analytic solution)를 구할 수 없는 경우가 많기 때문이다.==
	- 또한 그런 $\theta$를 찾더라도 지역 최솟값(local minimum)일 수 있다.

## 2. Gradient Descent 핵심 아이디어
- **전제**
	- 우리는 현재 위치의 gradient는 알 수 있지만,
	- 함수 전체의 모양(global view)은 알 수 없다.
	- 따라서 할 수 있는 최선은 **현재 위치의 기울기를 따라 내려가는 것**이다.

- **알고리즘**
	1. 임의의 점 $\theta_0$에서 시작
	2. $i$번째 단계에서 ==gradient $\nabla \mathcal{L}(\theta_i)$ 계산==
	3. ==파라미터 업데이트==: $\theta_{i+1} = \theta_i - \alpha \nabla \mathcal{L}(\theta_i)$
	
	- $\nabla \mathcal{L}(\theta_i)$는 가장 가파르게 증가하는 방향(steepest increasing direction)이므로 음수를 곱해 감소 방향으로 이동한다.
	- $\alpha$는 **learning rate**(학습률)이다.

## 3. Learning Rate의 영향
- $f(x) = (x-3)^2$ 예시($x_0 = 0$에서 시작)를 통해 학습률의 영향을 볼 수 있다.
	- **적절한 $\alpha = 0.1$**: 부드럽게 최솟값($x=3$)으로 수렴
	- **작은 $\alpha = 0.01$**: ==수렴이 너무 느려== 최솟값에 도달하지 못함
	- **큰 $\alpha = 0.7$**: 최솟값 주변에서 진동(oscillation)
	- **너무 큰 $\alpha = 1.05$**: ==발산(divergence) — 오히려 최솟값에서 멀어짐==

- **실용적 가이드**
	- 손실이 너무 천천히 감소하면 학습률을 키우고, 발산하면 학습률을 줄인다.
	- 또한 초기값에 따라 다른 지역 최솟값에 빠질 수 있으므로 여러 random initialization을 시도하는 것이 좋다.
	- (예: Mishra's Bird function 같은 복잡한 함수에서 초기값에 따라 결과가 달라짐)

## 4. 실전에서의 변형: SGD와 Mini-batch
- 데이터가 매우 많을 때 전체 데이터에 대한 gradient를 매번 계산하는 것은 비효율적이다.
- Gradient는 선형이므로 일부만 샘플링해서 추정할 수 있다.

|           방법            | 한 업데이트당 사용 데이터 |        특징         |
| :---------------------: | :------------: | :---------------: |
|  **Gradient Descent**   |    전체 $n$개     |     정확하지만 느림      |
|    ==Mini-batch GD==    |  $b$개 샘플 (배치)  | ==절충안, 가장 널리 쓰임== |
| **Stochastic GD (SGD)** |   ==1개 샘플==    |  ==빠르지만 노이즈 많음==  |

- 선형회귀에서는 $\nabla \ell = (\theta^T x^{(i)} - y^{(i)}) x^{(i)}$로 gradient를 명시적으로 쓸 수 있지만, 일반적으로는 자동미분(automatic differentiation) 도구가 gradient를 계산해준다.

## 5. Gradient Descent의 한계와 개선 알고리즘
- 기본 GD는 **plateau(평탄한 영역)에서 멈추거나 local minima에 빠질 수 있다**. 이를 보완하기 위한 발전된 옵티마이저들이 있다.

- **Momentum SGD**
	- ==이전 gradient들의 가중평균(velocity)을 누적해 관성을 부여==한다.
	- $v_t = \beta v_{t-1} + (1-\beta)\nabla \mathcal{L}(\theta_{t-1}), \quad \theta_t = \theta_{t-1} - \alpha v_t$
	- $\beta=0$이면 일반 GD, $\beta$가 클수록 관성이 커진다.
	- 진동을 줄이고 평탄한 영역도 통과할 수 있다.

- **RMSProp**
	- ==최근 gradient 크기의 제곱평균으로 학습률==을 좌표별로 자동 조정한다.
	- $E[g^2]_t = \beta E[g^2]_{t-1} + (1-\beta) g_t^2, \quad \theta_t = \theta_{t-1} - \frac{\alpha}{\sqrt{E[g^2]_t + \epsilon}} g_t$
	- gradient가 큰 차원은 업데이트를 작게, 작은 차원은 크게 가져간다.

- **ADAM**
	- ==Momentum(1차 모멘트)과 RMSProp(2차 모멘트)을 결합==하고 bias correction을 추가한 것으로, 가장 널리 쓰이는 옵티마이저다.
	- $m_t = \beta_1 m_{t-1} + (1-\beta_1)g_t, \quad v_t = \beta_2 v_{t-1} + (1-\beta_2)g_t^2$
	- $\hat{m}_t = \frac{m_t}{1-\beta_1^t}, \quad \hat{v}_t = \frac{v_t}{1-\beta_2^t}, \quad \theta_t = \theta_{t-1} - \frac{\alpha \hat{m}_t}{\sqrt{\hat{v}_t} + \epsilon}$

## 6. Learning Rate Scheduling
> **학습률 스케줄링**
> 학습 초기에는 큰 학습률을,
> 후반에는 작은 학습률을 사용하여 안정적으로 수렴하게 함

- ==학습 진행에 따라 학습률을 동적으로 조절==하는 기법이다.
	- **Step Scheduling**: $s$ epoch마다 $\alpha \leftarrow \alpha \times d$로 감소
	- **Exponential Scheduling**: $\alpha = \alpha_0 \times e^{-\gamma t}$로 지수적으로 감소
	- **Adaptive Scheduling (Annealing)**: validation loss가 일정 횟수($p$, patience) 동안 개선되지 않으면 학습률을 감소