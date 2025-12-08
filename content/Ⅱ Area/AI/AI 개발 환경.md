---
tags:
  - AI
draft: false
---
## 1. 하드웨어 환경
- **클라우드/원격 환경**
	- **Google Colab**: 무료 GPU 지원
	- **Kaggle Notebook**: GPU 사용 가능, 대회 중심
	- **AWS, GCP, Azure**: 상용 서비스, 고사양 GPU 사용 가능
	- **Paperspace, Lambda Labs**: 딥러닝 전문 GPU 클라우드

## 2. 소프트웨어 환경
### 2.1. 가상 환경
- ==Miniconda==: 패키지 관리 및 환경 관리를 위한 오픈 소스 툴

- **가상 환경의 중요성**
	- 의존성 충돌 방지
	- 재현 가능성 및 이식성
	- 개발 및 디버깅 편의성
	- 자동화 및 배포 용이성

#### (1) 가상 환경 관리
```sh
# 가상 환경 생성
conda create -n torch271 python=3.12

# 가상 환경 활성화
conda activate torch271

# 가상 환경 비활성화
conda deactivate

# 가상 환경 목록 보기
conda env list

# 가상 환경 삭제
conda remove -n torch271 --all

# 환경 내보내기
conda env export > environment.yml

# 환경 불러오기
conda env create -f environment.yml
```

#### (2) 패키지 관리
```sh
# 패키지 설치
conda install pandas

# 패키지 삭제
conda remove numpy

# 패키지 목록 확인
conda list

# 패키지 업데이트
conda update pandas
```

### 2.2. 개발 언어 및 라이브러리
- **왜 Python인가?**
	- 처리 속도는 느리지만 prototyping은 빠르다.
	- python은 front를 담당하고 C++/CUDA가 핵심 계산인 back을 수행한다.
	- 딥러닝은 행렬 계산이 많기 때문에 numpy 지원이 유리하다.

- **PyTorch**
	- Meta에서 개발한 오픈소스 딥러닝 프레임워크
	- 딥러닝 모델의 개발 및 연구에 사용
	- **GPU 가속 지원**: NVIDIA CUDA 지원을 통해 빠른 연산을 수행
	- **풍부한 생태계**: 다양한 오픈소스 라이브러리(TorchVision, TorchText, TorchAudio)

## 3. 개발 도구
- **통합 개발 환경**(IDE)
	- Jupyter Notebook
	- Visual Studio Code

- Sublime Text

## 4. 버전 관리 및 협업
### 4.1. 버전 관리
- git & github

### 4.2. 협업
- Notion