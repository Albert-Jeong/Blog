---
draft: false
tags:
  - 2-1/AI
date: 2025-07-01
---
- 서울대학교 강필성 교수님

## 1. 순환신경망(RNN) 기반의 시계열 회귀
### 1.1. 데이터의 종류
- **Non-Sequential Data**
	- 시간 정보가 없는 정적인 데이터
	- (예: 고객 정보 기반 대출 여부 예측)

- **Sequential (Time-Series) Data**
	- 시간 순서가 중요한 데이터
	- $(N, T, D)$ 형태의 3차원 텐서로 표현됨 ($N$: 관측치, $T$: 시점, $D$: 변수)
	- (예: 반도체 센서 값을 통한 불량 예측)

### 1.2. RNN (Recurrent Neural Network)
- **기본 구조**
	- 이전 시점의 Hidden State($h_{t-1}$)와 현 시점의 입력($x_t$)을 받아 현 시점의 정보를 갱신하는 순환 구조

- **문제점**
	- ==시퀀스가 길어질수록 그래디언트 소실(Vanishing) 또는 폭주(Exploding) 문제가 발생하여 장기 의존성(Long-term dependency) 학습이 어려움==

### 1.3. RNN의 발전 모델 (LSTM & GRU)
- **LSTM (Long Short-Term Memory)**
	- Cell State를 도입하고 3개의 Gate(Forget, Input, Output)를 통해 정보의 저장, 삭제, 출력을 조절하여 ==장기 의존성 문제를 해결==

- **GRU (Gated Recurrent Unit)**
	- LSTM을 단순화한 구조
	- Reset Gate와 Update Gate만 사용하며 Cell State 없이 Hidden State만 존재
	- LSTM과 성능은 비슷하면서 연산 효율이 높음

### 1.4. RNN Variations & Attention
- **Bidirectional RNN**
	- 과거뿐만 아니라 미래 시점의 정보도 함께 고려(순방향+역방향)

- **Attention Mechanism**
	- 시퀀스의 모든 시점 정보를 고정된 크기의 벡터로 압축할 때 발생하는 정보 손실을 막기 위해 제안됨
	- **핵심**: ==출력 시점에 입력 시퀀스의 어느 부분(Time step)이 중요한지 가중치(Score)를 계산하여 반영==
	- **종류**: Bahdanau Attention (Concat 방식), Luong Attention (Dot Product 등 다양한 방식)

## 2. 합성곱 신경망(CNN) 기반의 시계열 회귀
### 2.1. CNN의 기본 개념
- 이미지 처리에 특화된 신경망으로 **Convolution(합성곱)**, **Pooling(풀링)** 연산으로 구성

- **특징**
	- **Sparse Connection**: 전체가 아닌 일부 픽셀만 연결
	- **Shared Weight**: 동일한 필터를 전체 영역에 반복 적용 (위치 불변성 특징 추출)
	- **Hyperparameters**: Filter 크기 및 개수, Stride(이동 간격), Padding(테두리 채움)

### 2.2. 시계열 데이터에의 적용 (1-D Convolution)
- **2-D Conv vs 1-D Conv**
	- 이미지는 가로/세로 픽셀 간의 공간적 연관성(Spatial Correlation)이 중요하여 2-D Conv를 사용
	- ==시계열 데이터는 변수(Feature) 간의 순서가 공간적 의미를 갖지 않으므로, **시간 축으로만 움직이는 1-D Convolution**이 적합함==
	- 필터의 세로 크기는 변수의 개수($D$)와 동일하게 설정하여 한 번에 모든 변수를 고려함

- **Task 유형**
	- 분류(Classification), 회귀(Regression), 예측(Forecasting), 이상 탐지(Anomaly Detection) 등 다양한 태스크에 적용 가능

### 2.3. Dilated Convolution
- **목적**: 긴 시계열 데이터를 효율적으로 처리하기 위함.
- **방법**: 필터가 데이터를 촘촘히 보지 않고 일정 간격을 띄워서(Dilated) 봄으로써, 적은 레이어로도 넓은 수용 영역(Receptive Field)을 확보하여 장기 패턴을 학습.

## 3. 트랜스포머(Transformer) 기반의 시계열 회귀
### 3.1. Transformer 개요
- 기존 RNN의 ==순차적 처리 방식에서 벗어나 **Attention(주의 집중)** 메커니즘만을 사용==하여 병렬 처리가 가능하고 장기 의존성을 잘 학습하는 모델 (원래 NLP 분야에서 등장).

- **핵심 요소**
	- **Self-Attention**: Query(Q), Key(K), Value(V) 벡터를 이용해 문장(시퀀스) 내 단어들 간의 관계를 파악
	- **Multi-Head Attention**: 여러 개의 Attention을 병렬로 수행하여 다양한 관점의 정보를 포착
	- **Positional Encoding**: 순서 정보가 없는 구조적 한계를 극복하기 위해 위치 정보를 입력값에 더해줌
	- **Encoder-Decoder**: 입력 정보를 처리하는 인코더와 출력을 생성하는 디코더 구조 (시계열 모델에서는 주로 인코더만 사용)

### 3.2. Time-Series Transformer (TST)
- **기본 논문**
	- Zerveas et al. (KDD 2021)의 연구를 기반으로 함

- **구조적 특징**
	- Transformer의 **Encoder 구조만 사용**
	- 시계열 데이터의 특성(Outlier 존재 등)을 고려하여 NLP에서 쓰던 Layer Normalization 대신 **Batch Normalization**을 사용했을 때 성능이 더 우수함

### 3.3. 학습 방법 (2 Phases)
1. **Pre-training (비지도 학습)**
	- 입력 시계열 데이터의 일부를 **Masking**하고, 그 가려진 부분을 예측하는 방식으로 학습
	- 데이터의 내재된 표현(Representation)을 학습하는 과정
	- 마스킹은 랜덤이 아닌 기하 분포를 따르는 세그먼트 단위 마스킹(Markov Chain 기반)이 효과적

2. **Fine-tuning (지도 학습)**
	- Pre-training된 모델에 Output Layer(Linear Layer)를 추가하여 실제 풀고자 하는 문제(회귀, 분류 등)에 맞게 미세 조정

### 3.4. 성능 및 결론
- TST(Pre-trained) 모델은 레이블이 적은 상황(Semi-supervised)에서도 지도 학습(Supervised)만 수행한 모델보다 훨씬 우수한 성능을 보임
- 시계열 데이터의 결측치 보간(Imputation), 분류, 회귀 등 다양한 태스크에 범용적으로 적용 가능함