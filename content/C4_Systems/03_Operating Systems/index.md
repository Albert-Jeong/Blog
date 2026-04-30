---
draft: false
tags:
  - 3-1/운영체제
date: 2026-06-11
---
# Operating Systems

> 선수: 컴퓨터구조([[51_메모리 계층구조]] 등), Unix 사용 경험([[08_프로세스와 사용자 명령 익히기]])

## 1. 배경
- [[00_OS Background]] — OS의 개념, 역사, C 프로그램 실행 절차
- [[01_Computer System Overview]] — 인터럽트, 메모리 계층, I/O
- [[02_OS Overview]] — 목적과 기능, Modern OS

## 2. 프로세스와 스레드
- [[03_Process Description & Control]] — 프로세스 상태, PCB
- [[04_Thread]] — 프로세스 vs 스레드
	- Java 구현: [[13_Thread & Multitasking]], Windows 구현: [[19_Using Threads in Windows]]

## 3. 병행성
- [[05_병행성 (상호배제와 동기화)]] — 임계영역, 세마포어, 모니터
- [[06_병행성 (교착상태와 기아)]] — 교착상태 4조건과 전략
	- Windows 동기화: [[20_Windows에서의 쓰레드 동기화]], DB 트랜잭션: [[08_동시성 제어와 회복]]

## 4. 메모리
- [[07_메모리 관리]] — 분할, 페이징, 세그멘테이션, 로딩과 링킹
- [[08_가상 메모리]] — 페이지 교체, VM 관리 정책

## 5. 스케줄링
- [[09_Uniprocessor Scheduling]] — 스케줄링 알고리즘과 성능 비교