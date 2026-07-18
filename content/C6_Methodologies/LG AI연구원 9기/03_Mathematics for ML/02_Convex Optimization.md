---
draft: false
tags:
  - 2-1/LGAI7
  - 3-1/LGAI9
date: 2026-07-05
---
## 0. 최적화 문제
- **최적화 문제 (Optimization Problem)**
	- 여러 개의 가능한 선택지 중에서 특정 기준을 가장 잘 만족하는 최적의 해(Solution)를 찾는 문제를 말한다.

### 0.1. 구성 요소
1. **결정 변수 (Decision Variables)**
	- 우리가 제어하거나 값을 결정해야 하는 변수들이다.
	- $\rightarrow$ 가중치(Weights, $W$)와 편향(Bias, $b$)

2. **목적 함수 (Objective Function)** 
	- 최적화하고자 하는 대상이다.
	- 문제에 따라 이 값을 **최대화**(Maximization)하거나 **최소화**(Minimization)하는 것이 목표가 된다.
	- $\rightarrow$ 손실 함수(Loss Function / Cost Function)

3. **제약 조건 (Constraints)**
	- 결정 변수가 반드시 만족해야 하는 제한 사항이나 조건이다.
	- $\rightarrow$ 규제(Regularization) 등

### 0.2. 분류
- 제약 조건의 유무에 따른 분류
	1. **Unconstrained Optimization (무제약 최적화)**
	    - 변수들이 아무런 제한 없이 어떤 실수 값이든 가질 수 있는 문제
	2. **Constrained Optimization (제약 최적화)**
	    - 변수들이 만족해야 하는 제약 조건이 존재하는 문제입니다.

- 수학적 성질에 따른 분류
	1. **Convex Optimization (볼록 최적화)**
	    - 목적 함수가 아래로 볼록(Convex)하고, 제약 조건으로 정의되는 영역도 볼록 집합(Convex Set)인 경우
	2. **Non-convex Optimization (비볼록 최적화)**
	    - 함수의 모양이 구불구불하여 여러 개의 골짜기(Local Minima)가 존재하는 경우

### 0.3. 최적화와 볼록성
1. **전역 최적점 보장**
	- 미분값이 0이 되는 지점(정류점)을 찾으면,
	- 그곳이 곧 전체에서 가장 작은 최적점(전역 최적점)이 된다.

2. **강쌍대성(Strong Duality) 성립**
	- 원래 문제(Primal)와 쌍대 문제(Dual)의 최적값이 일치하므로,
	- 계산하기 더 편한 형태로 우회하여 문제를 해결할 수 있다.
    
3. **KKT 조건이 필요충분조건이 됨**
	- 최적해의 필수 조건인 KKT 조건이 볼록 문제에서는 충분조건 역할까지 하므로,
	- 이 조건만 충족하면 확실한 최적해로 판정할 수 있다.

### 0.4. 최적화와 머신러닝
- 대표적인 머신러닝 최적화 **알고리즘** (옵티마이저, Optimizer)
	- 경사하강법 (Gradient Descent, GD)
	- 확률적 경사하강법 (Stochastic Gradient Descent, SGD)
	- 아담 (Adam, Adaptive Moment Estimation)

- 머신러닝 최적화만의 고유한 **난제**
	1. 국소 최솟값(Local Minima)과 안장점(Saddle Point)
	2. 일반화 성능(Generalization)과 과적합(Overfitting)

## 1. 경사하강법 기반 최적화
> Optimization Using Gradient Descent

### 1.1. 비제약 최적화의 목표
- $f \in C^1$인 함수에 대해 $\min f(x)$를 푸는 것이다.
- 기본 알고리즘은 $x_{k+1} = x_k + \gamma_k d_k$ 형태로 업데이트를 반복한다.

- **Formulation**
	- $\mathbb{R}^n$차원 벡터를 스칼라($\mathbb{R}$)로 mapping하는 함수 $f$를 최소화한다.
	- 이를 풀기 위한 **gradient-type algorithm**은 다음과 같이 재귀적으로 표현되는 iterative algorithm이다.
		- $$x_{k+1} = x_k + \gamma_k d_k$$
		- 현재 값 $x_k$를 방향 $d_k$에 stepsize $\gamma_k$를 곱한 만큼 업데이트한다.
		- $\gamma_k$: **stepsize**라고 부르는 스칼라 값
		- $d_k$: 방향성을 나타내는 **direction**
	- (Lemma) 찾으려는 방향 $d$가 gradient와의 내적이 음수($\nabla f(x) \cdot d < 0$)이면,
		- stepsize $\gamma_k$를 적절히 정할 경우 현재 값보다 함숫값이 더 낮아지는 stepsize가 항상 존재한다.

### 1.2. 핵심 보조정리
- **하강 방향(descent direction)** 에 관한 것이다.
	- $\nabla f(x) \cdot d < 0$을 만족하는 방향 $d$는 하강 방향이어서,
	- 적절히 작은 스텝을 밟으면 함숫값이 줄어든다.

- 여기서 가장 자연스러운 선택이 **최급강하법(steepest gradient descent)**
	- 방향을 $d_k = -\nabla f(x_k)^T$로 잡는다. **(반대 방향으로 업데이트)**
	- 스텝 크기(step size) $\gamma_k$만 적절히 고르면 국소 최적점(local optima)으로 수렴할 수 있다.

- **step size와 수렴 속도**
	- Too small: slow update
	- Too big: overshoot, zig-zag, often fail to converge

- 2차 함수 예시에서는
	- 조건수가 큰 (고유값이 2와 20으로 차이가 큰) 이차함수에서
	- 일정한 스텝 크기로 경사하강을 돌리면
	- 특유의 **지그재그(zigzag) 패턴**이 나타나며 수렴이 느려짐을 보여준다.

### 1.3. 경사하강법의 분류
- ML의 optimization
	- Objective Function이 어떤 data로부터 정해진다.
	- 어떤 $L(θ)$ (θ는 모델의 파라미터, L은 그 모델의 어떤 Loss 함수)
	- Loss를 최소화하는 문제가 ML의 문제

#### (1) 매 반복에서 사용하는 데이터 양에 따른 분류
1. **배치 경사하강** (Batch Gradient Descent)
	- 전체 $n$개를 쓴다.
	- (정확하게 모든 data point를 고려해서 계산)

2. **미니배치 경사하강** (Mini-batch Gradient Descent)
	- $k<n$개를 쓴다.
	- (계산의 효율성을 위해서 subset에서 계산)

3. **확률적 경사하강** (SGD; Stochastic Gradient Descent)
	- 불편 추정(unbiased estimation)을 만족하도록 부분집합을 무작위로 고른다.
	- (subset을 구할 때 full batch에 근사)
	
	- 미니배치 그래디언트의 기댓값이 전체 그래디언트와 같아지도록 부분집합 $\mathcal{K}$를 선택해,
	- 실제 그래디언트에 대한 잡음 섞인 근사가 되도록 하는 것이다.
	
	- 어떤 모델의 최소화 할 Loss 함수: data point에 대한 loss의 summation 형태로 표현

#### (2) 업데이트의 적응적 방식에 따른 분류
> standard한 Gradient Descent (Gradient 방향만 고민해서 update)
> adaptive하게 방향 자체도 새롭게 정하는 방법 (momentum 등)

- Momentum, NAG, Adagrad, RMSprop, Adam 등이 여기 속한다.

- 추가 항으로 그 전에 업데이트 했던 방향을 고려하여 update
- 경험적이게도 성능 향상을 가속화시켜주지만 이론적으로도 수렴 속도가 빨라진다.
- Gradient Descent는 x에 대한 조건이 없는 Unconstrained optimization

---

- **모멘텀(Momentum)** 은
	- 스텝 크기 문제(너무 작으면 느리고 너무 크면 진동·발산)를 완화하는 방법이다.
	- 업데이트에 과거 변화량 $\alpha \Delta x_k$를 더해주는데($\Delta x_k = x_k - x_{k-1}$),
	- 이 기억 항이 진동을 줄이고 변화를 매끄럽게 만든다.
	- 결국 다음 업데이트는 현재 그래디언트와 이전 업데이트의 선형 결합이 된다.

## 2. 제약 최적화와 라그랑주 승수법
> Constrained Optimization and Lagrange Multipliers

### 2.1. 표준형 제약 최적화 문제
- **표준형 제약 최적화 문제** (Constrained Optimization)
	- 목적함수 $f(x)$를 최소화하되,
	- 부등식 제약 $g_i(x) \le 0$과 등식 제약 $h_j(x) = 0$을 만족시키는 문제이다.
	- 최적값은 $p^*$, 최적해는 $x^*$로 표기한다.

### 2.2. 핵심 아이디어
- **쌍대성(duality)** 으로, 원래 문제를 다른 최적화 문제를 통해 풀거나 경계를 얻는 발상이다.
- 목적함수에 제약들을 가중합으로 더해 **라그랑지안**을 만든다:
$$\mathcal{L}(x, \lambda, \nu) = f(x) + \sum_{i=1}^{m}\lambda_i g_i(x) + \sum_{j=1}^{p}\nu_j h_j(x)$$
- 여기서 $\lambda \succeq 0$, $\nu$는 **쌍대 변수(라그랑주 승수)** 이다.
- 이로부터 **라그랑주 쌍대 함수** $\mathcal{D}(\lambda, \nu) = \inf_x \mathcal{L}(x, \lambda, \nu)$를 정의한다.

### 2.3. 하한 정리
- 쌍대 함수는 항상 최적값의 하한이다.
- 즉 모든 $\lambda \succeq 0, \nu$에 대해 $\mathcal{D}(\lambda, \nu) \le p^*$
- 증명은 임의의 실행가능점 $\tilde{x}$에서 $g_i(\tilde{x}) \le 0, \lambda_i \ge 0, h_j(\tilde{x}) = 0$이므로 $\mathcal{L}(\tilde{x}, \lambda, \nu) \le f(\tilde{x})$가 성립하고, 따라서 $\mathcal{D} \le \mathcal{L} \le f(\tilde{x})$이기 때문이다.

### 2.4. 라그랑주 쌍대 문제
- 그렇다면 가장 좋은(가장 큰) 하한은 무엇이냐는 질문에서 **라그랑주 쌍대 문제**가 나온다.
	- $\lambda \succeq 0$ 하에서 $\mathcal{D}(\lambda, \nu)$를 최대화
- 중요한 점은 이 쌍대 문제는 원래 문제가 볼록이 아니더라도 **항상 볼록 최적화 문제**라는 것이다.
- 쌍대 함수가 $(\lambda, \nu)$에 대한 아핀 함수족의 하한(infimum)이라 항상 오목하기 때문이다.
- 쌍대 문제의 최적값은 $d^*$로 표기한다.

### 2.5. 약쌍대성
- **약쌍대성(weak duality)** 은
	- $d^* \le p^*$로, 원래 문제가 볼록이 아니어도 항상 성립한다.
	- $p^* - d^*$를 최적 쌍대 간극이라 하며, 쌍대 문제를 통해 효율적으로 하한을 생성할 수 있다는 점이 실용적 의미이다.

## 3. 볼록 집합과 볼록 함수
> Convex Sets and Functions

### 3.1. Convex Set
- **볼록 집합**은
	- 집합 내 임의의 두 점을 잇는 선분이 다시 그 집합 안에 들어가는 집합이다.
	- 즉 $x_1, x_2 \in \mathcal{C}$와 $\theta \in [0,1]$에 대해 $\theta x_1 + (1-\theta)x_2 \in \mathcal{C}$

### 3.2. Convex Function
- **볼록 함수**는
	- 정의역이 볼록 집합이고 다음을 만족하는 함수이다.
	- $f(\theta x + (1-\theta)y) \le \theta f(x) + (1-\theta)f(y)$

- 모든 $x \ne y$, $0 < \theta < 1$에서 부등호가 엄격하면 **강볼록(strictly convex)**,
- $-f$가 볼록이면 $f$는 **오목**이다.
- 아핀 함수는 볼록이면서 동시에 오목히다.
- 이와 관련된 것이 **옌센 부등식**으로, 확률변수 $X$에 대해 $f(\mathbb{E}[X]) \le \mathbb{E}[f(X)]$이다.

### 3.3. 볼록성을 판정
- 볼록성을 판정하는 두 가지 조건이 있다.

- **1차 조건**은
	- 미분 가능한 함수에서 $f(y) - f(x) \ge \nabla f(x)^T(y-x)$가 모든 점에서 성립하는 것과 볼록성이 동치라는 것이다.
	- 기하적으로 함수가 어느 점에서의 1차 테일러 근사보다 항상 위에 있다는 뜻이고,
	- 따라서 국소 정보(1차 근사)가 전역 정보(전역 하한)를 제공한다.
	- 특히 $\nabla f(x) = 0$이면 모든 $y$에 대해 $f(y) \ge f(x)$가 되어 $x$가 **전역 최소점**이 된다.
	- 볼록 함수에서 정류점이 곧 전역 최적점이라는 핵심 성질이다.

- **2차 조건**은
	- 두 번 미분 가능한 함수에서 모든 점의 헤시안이 양의 준정부호,
	- 즉 $\nabla^2 f(x) \succeq 0$인 것과 볼록성이 동치라는 것이다.
	- 이는 그래프가 위로 볼록한 양의 곡률을 가짐을 의미합니다.

### 3.4. 볼록·오목 함수의 예시
- 볼록·오목 함수의 예시
	- $e^{ax}$(모든 $a$에서 볼록),
	- $x^a$($a \ge 1$ 또는 $a \le 0$이면 볼록, $0 \le a \le 1$이면 오목),
	- $|x|^p$($p \ge 1$에서 볼록),
	- $\log x$(오목),
	- $x\log x$(강볼록),
	- 모든 노름,
	- $\max\{x_1,\dots,x_n\}$,
	- log-sum-exp $\log\sum_i e^{x_i}$(볼록),
	- 기하평균 $(\prod_i x_i)^{1/n}$(오목) 등

### 3.5. 볼록성을 보존하는 연산
- **볼록성을 보존하는 연산**도 중요하다.
	- 음이 아닌 가중치의 합($\sum w_i f_i$, $w_i \ge 0$),
	- 아핀 변환과의 합성($f(Ax+b)$),
	- 점별 최대값($\max\{f_1, f_2\}$),
	- 합성 함수 $h(g(x))$의 경우 적절한 단조성·볼록성 조건이 맞으면 볼록성이 유지된다.
	
	- 예를 들어 $h$가 볼록·비감소이고 $g$가 볼록이면 합성도 볼록이다.

- **점별 상한(supremum)** 연산
	- $f(x,y)$가 각 $y$에 대해 $x$에서 볼록이면 $g(x) = \sup_y f(x,y)$도 볼록이고, 오목이면 infimum이 오목이 된다.
	- 이 성질로부터 집합 내 가장 먼 점까지의 거리 $\sup_{y \in C}|x-y|$가 볼록이라는 것, 그리고 라그랑주 쌍대 함수 $\mathcal{D}(\lambda,\nu) = \inf_x \mathcal{L}$가 오목이라는 것(앞에서 언급된 사실의 근거)이 따라 나온다.

## 4. 볼록 최적화
> Convex Optimization

### 4.1. 표준 볼록 최적화 문제
- **표준 볼록 최적화 문제**는 다음과 같다.
	- $\min f(x) \quad \text{s.t.} \quad g_i(x) \le 0, \quad a_i^T x = b_i$
	- 여기서 $f, g_1, \dots, g_m$이 모두 볼록 함수이다.

- 핵심 구성 요건은 세 가지로,
	1. **볼록 목적함수**를 최소화(또는 오목 함수를 최대화),
	2. 부등식 제약은 볼록 함수에 대한 상한 형태(이래야 **제약 집합이 볼록**),
	3. 등식 제약은 반드시 아핀(아핀만이 볼록 집합을 만듦)이어야 한다.

- 풀 수 있는 문제와 다루기 어려운 문제를 가르는 분수령은 '선형성'이 아니라 '볼록성'이다.

### 4.2. 강쌍대성
- **강쌍대성(strong duality)** 은
	- 쌍대 간극이 0, 즉 $d^* = p^*$인 경우이다.
	- 강쌍대성이 성립하면 쌍대 문제를 푸는 것이 원래 문제를 푸는 것과 동등해진다.
	- 다만 항상 성립하지는 않는다.
	- 그런데 **볼록성과 제약 조건 자격(constraint qualification)** 이 갖춰지면 강쌍대성이 보장된다.
	- 이것이 볼록 최적화가 '쉬운' 또 하나의 이유이다.

- **KKT 조건(Karush-Kuhn-Tucker)** 은
	- 최적성을 특징짓는 조건들의 모음이다.
	- 최적해 $x^*$가 라그랑지안을 최소화하므로 정상성(stationarity) 조건이 성립한다.
	- $\nabla f(x^*) + \sum_{i=1}^{m}\lambda_i^* \nabla g_i(x^*) + \sum_{j=1}^{p}\nu_j^* \nabla h_j(x^*) = 0$

- 전체 KKT 조건은
	- 실행가능성($g_i(x^*) \le 0, h_j(x^*) = 0$),
	- 쌍대 실행가능성($\lambda_i^* \succeq 0$),
	- 상보적 여유(complementary slackness, $\lambda_i^* g_i(x^*) = 0$),
	- 그리고 위의 정상성 조건으로 이루어진다.

- 강쌍대성이 성립하는 임의의 문제에서
	- KKT는 원시-쌍대 최적성의 **필요조건**이고,
	- 볼록 최적화(슬레이터 조건 충족 시)에서는 KKT가 **충분조건**도 된다.

### 4.3. 대표적 볼록 최적화 사례
1. **선형 계획법(LP)**
	- $\min c^T x$ s.t. $Ax \preceq b$ 형태로,
	- 라그랑지안 $\mathcal{L}(x,\lambda) = (c + A^T\lambda)^T x - \lambda^T b$에서 $x$에 대한 미분이 0이 되는 조건 $c + A^T\lambda = 0$을 통해 쌍대 함수 $\mathcal{D}(\lambda) = -\lambda^T b$를 얻고,
	- 쌍대 문제는 $\max -b^T\lambda$ s.t. $c + A^T\lambda = 0, \lambda \succeq 0$가 된다.

2. **2차 계획법(QP)**
	- $\min \frac{1}{2}x^T Q x + c^T x$ s.t. $Ax \preceq b$ 형태로($Q$는 대칭 양의 정부호),
	- 쌍대 문제는 $\lambda$에 대한 2차식 최대화 문제로 유도된다.