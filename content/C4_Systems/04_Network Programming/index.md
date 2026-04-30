---
draft: false
tags:
  - 3-1/네트워크프로그래밍
date: 2026-06-11
---
# Network Programming

> 배경 지식: [[10_Network]] (전산학기초), [[NC_Network]] (네트워크 계층·IP 원리)

## 1. 소켓 기초
- [[01_네트워크 프로그래밍과 소켓의 이해]] — 소켓의 개념
- [[02_소켓의 타입과 프로토콜의 설정]] — TCP/UDP 소켓 생성
- [[03_주소체계와 데이터 정렬]] — IP/PORT, 바이트 순서

## 2. TCP/UDP 서버·클라이언트
- [[04_TCP-based Server & Client 1]] — 기본 구현
- [[05_TCP-based Server & Client 2]] — 에코 클라이언트, TCP 이론
- [[06_UDP-based Server & Client]] — UDP 특성과 connect
- [[07_Half-close the socket]] — 우아한 연결 종료

## 3. 소켓 운용
- [[08_Domain Name & IP Address]] — DNS
- [[09_Socket Options]] — SO_REUSEADDR, Nagle 알고리즘

## 4. 멀티플렉싱과 비동기 IO
- [[12_IO 멀티플렉싱]] — select
- [[14_Multicast & Broadcast]]
- [[21_비동기 Notification IO 모델]] → [[22_Overlapped IO 모델]] → [[23_IOCP (Input Output Completion Port)]] — 비동기 IO 발전 순서

## 5. 멀티스레드 서버 (Windows)
- [[19_Using Threads in Windows]] — 커널 오브젝트, 스레드 생성
- [[20_Windows에서의 쓰레드 동기화]] — 유저/커널모드 동기화
	- OS 이론: [[04_Thread]], [[05_병행성 (상호배제와 동기화)]]