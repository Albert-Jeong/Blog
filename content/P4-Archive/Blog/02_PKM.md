---
draft: false
tags:
  - Blog
date: 2026-03-18
---
## 1. PKM
- **개인 지식 관리**(PKM; Personal Knowledge Management)
	- 개인의 지식 관리. 정보를 수집, 저장, 연결, 활용하여 지식을 생산하는 모든 활동을 의미한다.

## 2. Second Brain
- **Second Brain**(제2의 뇌)
	- 티아고 포르테(Tiago Forte)가 제시한 개념으로,
	- PKM을 현대 디지털 환경에 맞게 구현한 것이다.
	- **연결**: "인간의 뇌는 정보를 처리하는 곳이지, 저장하는 곳이 아니다"라는 철학을 바탕으로, 디지털 도구에 제2의 뇌를 구축하여 PKM을 효율적으로 실천하게 한다.

- *새로운 시각*
	- 기존의 자기계발이 사고방식의 개조를 요구했다면, 세컨드 브레인은 다르다. 사람은 잘 변하지 않는다는 전제하에, 본연의 모습은 유지하되 기억과 재생산의 영역을 시스템에 위임하는 것이기 때문이다. 이는 변화를 강요하는 기존 방법론보다 실천 가능성이 높다. 내 외부의 두 번째 뇌를 운영한다는 관점이 인상 깊어, 관련 기고문을 꼭 다시 찾아보려 한다.

## 3. PARA/CODE
- PARA/CODE 두 방법론은 서로 보완적이며, 함께 사용하면 정보 수집부터 실행까지 전 과정을 체계적으로 관리할 수 있어 개인의 업무 효율성과 창의성을 크게 향상시킬 수 있다.

### 3.1. PARA
> 공간을 담당하는 정리 시스템

- **구조**: 정보를 4가지 폴더로 나눈다.
	- **P**rojects(프로젝트): 마감일이 있는 단기 과제
	- **A**reas(영역): 지속적으로 관리해야 할 책임 영역
	- **R**esources(자원): 관심 있는 주제나 참고 자료
	- **A**rchives(보관소): 완료되거나 더 이상 필요 없는 것

- **연결**
	- **Second Brain을 유지하기 위한 서랍장** 역할을 한다.
	- 무엇을 어디에 둘지 고민하지 않게 만들어 준다.

### 3.2. CODE
> 시간을 담당하는 프로세스

- **흐름**: 정보를 처리하는 4단계 순서이다.
	- **C**apture(포착): 필요한 정보 기록하기
	- **O**rganize(조직): PARA 시스템을 이용해 분류하기
	- **D**istill(추출): 핵심 내용만 요약하여 정제하기
	- **E**xpress(표현): 결과물(글, 프로젝트 등)로 만들어내기

- **연결**
	- **Second Brain을 움직이게 하는 엔진**이다.
	- 단순히 정보만 쌓아두는 것이 아니라, 가치 있는 결과물을 만들어내는 동력을 제공한다.

## 4. Publish for Expressing
### 4.1. Static Site Generator (Quartz)
- 기존에 작성한 Obsidian md 파일을 그대로 publish하고자 하는 needs
- Quartz SSG로 Obsidian md 파일과 호환성이 높은 사이트 생성

### 4.2. Blog Structure
![|500](https://imgur.com/evUrlA0.png)

- **설계 중점**
	- 크게는 edit 환경과 publish으로 구분
	- 사용 빈도가 높은 iCloud, macOS 중심의 환경 구성
	- draft metadata를 활용하여 출판하고 싶은 글만 local repo에서 관리하는 unix shell script 작성
	- publish의 빈도 자체는 높지 않기 때문에 원할 때에만 remote repo로 add-commit-push 진행 (이 역시 unix shell script를 작성하여 활용)
	- Cloudflare를 통한 remote repo의 publish ([Cloudflare에서 참고한 가이드](https://hel-p.tistory.com/56))

## 5. 메모
- https://slashpage.com/cmds-class