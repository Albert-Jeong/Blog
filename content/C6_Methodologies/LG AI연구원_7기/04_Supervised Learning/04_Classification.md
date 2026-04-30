---
draft: false
tags:
  - 2-1/LG-AI-7
date: 2025-07-01
---
## 요약
|          방법           |                      특징                       |
| :-------------------: | :-------------------------------------------: |
|    **Perceptron**     | 0-1 loss 사용, 미분 불가, 단순하지만 infeasible 시 멈추지 않음 |
| **SVM (Hard-margin)** |  0-1 loss, 미분 불가, 경계 근처 점만 고려, 선형 분리 가능해야 함   |
|  **Soft-margin SVM**  |  경계 근처 점 + 위반 점 고려, convex optimization으로 해결  |

- 발전 흐름
	- 단순한 분류
	- → 최선의 분류(margin)
	- → 현실적인 분류(slack)

## 1. Classification vs. Regression
> 두 문제의 핵심 차이는 출력값의 형태에 있다.

- **Regression**
	- 출력이 연속적(continuous, real)인 값
	- 실수 범위의 값을 예측한다. (주가 예측)

- **Classification**
	- ==출력 $y$가 이산적(discrete, finite)인 값을 갖는 문제==
	- 정해진 카테고리 중 하나를 선택한다. (이미지 분류(airplane, cat, dog 등)나 언어 번역)

## 2. Binary Classification (이진 분류)
- 가장 기본적인 분류 문제 설정
	- **데이터셋**: $(x^{(1)}, y^{(1)}), (x^{(2)}, y^{(2)}), \ldots, (x^{(n)}, y^{(n)})$, 여기서 $y^{(i)} \in {-1, 1}$
	- **함수 클래스 (Linear Classifier)**: $\mathcal{G} = {g_{a,b}(x) = \text{sign}(a^\top x + b)}$
	- **0-1 Loss**: $\ell(g_{a,b}(x^{(i)}), y^{(i)}) = \mathbf{1}(g_{a,b}(x^{(i)}) \neq y^{(i)})$ — 분류가 틀리면 1, 맞으면 0
	- **가정**: 데이터가 **선형 분리 가능(linearly separable)** — 즉 Loss=0인 완벽한 분류기가 존재

## 3. Perceptron Algorithm
- Perceptron Algorithm (Rosenblatt, 1957)
	- 가장 고전적인 학습 알고리즘
	
	- 각 샘플을 순회하며 ==잘못 분류된 경우에만 가중치를 업데이트==한다:
		- $z_i = \mathbf{a} \cdot \mathbf{x}_i + b$를 계산하고 $\hat{y}_i = \text{sign}(z_i)$로 예측
		- 틀렸다면: $\mathbf{a} := \mathbf{a} + \eta(y_i - \hat{y}_i)\mathbf{x}_i$, $b := b + \eta(y_i - \hat{y}_i)$
	
	- **장점**: 해가 존재하면 반드시 수렴하며, 매우 단순하다.
	- **단점**: ==해가 없으면 영원히 멈추지 않고==, 사용자는 그 사실을 알 수 없다.

## 4. Linear Programming 접근
- Perceptron의 단점을 보완하기 위해 LP로 정식화한다:
	- $\text{minimize } 0 \quad \text{subject to } y_i(\mathbf{a} \cdot \mathbf{x}_i + b) > 0 \quad \forall i$

- 목적함수가 0(null objective)이라 단순히 제약 조건 만족 여부만 확인하며, **infeasible(해가 없는 경우)을 알려준다**는 장점이 있다.

## 5. Margin과 SVM
### 5.1. Margin의 개념
- 선형 분리 가능한 데이터에는 분류 경계가 무수히 많이 존재한다.
	- 이 중 **가장 좋은 경계**를 어떻게 고를까?
	- → **Maximum margin** 아이디어: ==결정 경계에서 가장 가까운 점까지의 거리(margin)==를 최대화하면 더 robust한 분류기를 얻는다.

- 점 $\mathbf{x}_0$에서 초평면 $\mathbf{a}^T\mathbf{x} + b = 0$까지의 거리
	- $d = \frac{|\mathbf{a}^T\mathbf{x}_0 + b|}{|\mathbf{a}|}$

### 5.2. Support Vector Machine (SVM)
> 마진을 최대화하는 결정 경계를 찾음으로써 모델의 일반화 성능을 높임?

- 제약 조건을 고정하고 분모(가중치 norm)를 최소화하는 형태로 변환:
	- $\text{minimize } \frac{1}{2}|\mathbf{a}|^2 \quad \text{subject to } y^{(i)}(\mathbf{a} \cdot \mathbf{x}^{(i)} + b) \geq 1 \quad \forall i$

- 이는 **convex 문제(QCQP)**로, 표준 solver로 풀 수 있고 infeasible 여부도 판별 가능하다.

### 5.3. Soft-margin SVM
- 실제 데이터는 선형 분리 불가능한 경우가 많다.
	- 이때 기존 SVM은 infeasible로 끝나버린다.

- 해결책은 **slack variable** $\xi_i$를 도입해 ==오차를 허용==하는 것:
	- $\text{minimize } \frac{1}{2}|\mathbf{a}|^2 + C\sum_{i=1}^{n}\xi_i$$
	- $\text{subject to } y_i(\mathbf{a}^T\mathbf{x}_i + b) \geq 1 - \xi_i, \quad \xi_i \geq 0$

#### (1) 하이퍼파라미터 C의 역할
- **큰 C**: 위반(outlier)에 강한 페널티 → 모든 점을 정확히 분류하려 함
- **작은 C**: 일반적인 샘플의 패턴에 집중 → 일부 outlier는 무시

### 5.4. Hinge Loss
> 0-1 Loss(미분 불가능) 대신 사용하는 SVM의 손실 함수?

- Soft-margin SVM은 **Hinge Loss**로 다시 표현할 수 있다:
	- $\mathcal{L}(y_i, f(\mathbf{x}_i)) = \max(0, 1 - y_i(\mathbf{a}^T\mathbf{x}_i + b))$

- 마진 안쪽이거나 잘못 분류된 경우에만 손실이 생기며, 목적함수는 다음과 같이 깔끔해진다:
	- $\frac{1}{2}|\mathbf{a}|^2 + C\sum_{i=1}^{n}\mathcal{L}(y_i, f(\mathbf{x}_i))$

## 6. Kernel
- ==선형 분류기로 해결 불가능한 데이터(예: 원형 경계)에는 **추가 특성**을 만들어 적용한다.==
	- 예를 들어 quadratic kernel:
		- $\tilde{x} = (x_1, x_2, x_1^2, x_2^2, x_1x_2)$

- 이런 변환을 통해 $x_1^2 - 2x_1x_2 + 2x_2^2 = 1$ 같은 비선형(타원) 경계도 표현할 수 있다.
	- Linear Regression에서 다항 특성을 쓰던 것과 같은 아이디어다.