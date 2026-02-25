---
draft: false
tags:
  - MLOps
date:
title: MLOps
---
## 1. 개요
- MLOps의 기본 개념부터 클라우드별 운영(AWS/Azure/GCP), 모니터링, 상호운용성, 실사례까지 학습한다.
- 모델 개발 이후의 배포, 운영, 자동화, 관측 가능성(Observability)까지 end-to-end 관점으로 정리한다.

## 2. 학습 목표
- ML 시스템의 개발-배포-운영 라이프사이클을 설명할 수 있다.
- CI/CD, 컨테이너, 클라우드 환경에서의 MLOps 적용 포인트를 이해할 수 있다.
- 운영 중 모델의 성능/드리프트/로그를 모니터링하고 개선 루프를 설계할 수 있다.

## 3. 목차
| Index | 주제                          | 노트                                           |
| :---: | :-------------------------- | :------------------------------------------- |
|  01   | Introduction to MLOps       | [[01 Introduction to MLOps]]                 |
|  02   | MLOps Basic Concepts        | [[02 MLOps Basic Concepts]]                  |
|  03   | Containers and Edge         | [[03 MLOps for Containers and Edge Devices]] |
|  04   | CD for ML Applications      | [[04 Applying CD to ML Applications]]        |
|  05   | AutoML and KaizenML         | [[05 AutoML & KaizenML]]                     |
|  06   | Monitoring and Logging      | [[06 Monitoring & Logging]]                  |
|  07   | MLOps on AWS                | [[07 MLOps on AWS]]                          |
|  08   | MLOps on Azure              | [[08 MLOps on Azure]]                        |
|  09   | MLOps on GCP and K8s        | [[09 MLOps on GCP & K8s]]                    |
|  10   | ML Interoperability         | [[10 ML 상호운용성]]                              |
|  11   | CLI Tools and Microservices | [[11 MLOps 명령줄 도구와 Microservices 구축]]        |
|  12   | Case Studies                | [[12 MLOps 실사례 연구]]                          |

## 4. 실습 체크리스트
- [ ] 학습/서빙 파이프라인을 분리하여 최소 1개 프로젝트 구조화
- [ ] 모델 배포 자동화(CI/CD) 파이프라인 1회 이상 구성
- [ ] 모니터링 지표(성능, 지연, 에러율, 드리프트) 대시보드 설계
- [ ] 클라우드 1개 이상에서 추론 API 배포 및 운영 점검