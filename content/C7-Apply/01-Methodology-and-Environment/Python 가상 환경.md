---
draft: false
tags:
date: 2025-06-24
---
- **Miniconda**
	- 파이썬 패키지 관리 및 가상환경 구축을 돕는 도구인 Conda를 설치하기 위한 최소한의 설치 파일

- **환경 관리**(Environment Management)
```sh
conda create -n 환경이름 python=3.12 # 환경 생성
conda activate 환경이름 # 환경 활성화
conda deactivate # 환경 비활성화

conda env list # 환경 목록 확인
환경이름 --all # 환경 삭제

conda env export > environment.yml # 환경 내보내기
conda env create -f environment.yml # 환경 불러오기
```

- **패키지 관리**(Package Management)
```sh
conda install 패키지이름 # 패키지 설치
conda list # 패키지 목록 확인
conda remove 패키지이름 # 패키지 삭제
```