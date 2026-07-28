# Archive

개인 학습 기록과 기술 노트를 모아 둔 디지털 가든입니다. [Quartz 4](https://quartz.jzhao.xyz/)로 Markdown 문서를 정적 사이트로 빌드하며, [albert-jeong.pages.dev](https://albert-jeong.pages.dev)에 게시합니다.

![Archive의 노트 그래프 뷰](assets/graph_view.png)

## 콘텐츠 구성

노트는 ACM Computing Classification System을 참고한 **Computing** 분류와 활용 상태에 따른 **PARA** 분류로 정리합니다.

### Computing

| 경로 | 주제 |
| --- | --- |
| [`content/C0_Liberal Arts`](content/C0_Liberal%20Arts) | 기초 교양, 컴퓨터과학 개론, 심리학, 철학 |
| [`content/C1_Mathematics`](content/C1_Mathematics) | 미적분학, 선형대수학, 확률과 통계, 최적화 |
| [`content/C2_Computation`](content/C2_Computation) | 이산수학, 자료구조, 알고리즘 |
| [`content/C3_Hardware`](content/C3_Hardware) | 하드웨어 기초, 논리회로, 컴퓨터구조, 임베디드 시스템 |
| [`content/C4_Systems`](content/C4_Systems) | 유닉스, 데이터베이스, 운영체제, 시스템 프로그래밍 |
| [`content/C5_Networks`](content/C5_Networks) | 인프라, 네트워크 프로그래밍, 컴퓨터 네트워크, 클라우드 |
| [`content/C6_Software`](content/C6_Software) | 프로그래밍 언어, 프론트엔드, 소프트웨어 공학, 웹 서비스 |
| [`content/C7_Methodologies`](content/C7_Methodologies) | 인공지능, 머신러닝, PyTorch, MLOps |
| [`content/C8_Applied`](content/C8_Applied) | 부트캠프, 커뮤니티, 현장 프로젝트, Applied AI, 보안 |

### PARA

| 경로 | 역할 |
| --- | --- |
| [`content/P1_Project`](content/P1_Project) | 목표와 완료 시점이 있는 현재 프로젝트 |
| [`content/P2_Area`](content/P2_Area) | 대학, 포트폴리오, 진로 등 지속적으로 관리할 영역 |
| [`content/P3_Resource`](content/P3_Resource) | 향후 참고하거나 재사용할 자료 |
| [`content/P4_Archive`](content/P4_Archive) | 완료되었거나 현재 사용하지 않는 자료 |

전체 공개 노트와 주요 문서 바로가기는 [`content/index.md`](content/index.md)에서 확인할 수 있습니다.

## 로컬 실행

Node.js 22 이상과 npm 10.9.2 이상이 필요합니다. 저장소의 `.node-version`은 Node.js 22.16.0을 지정합니다.

```bash
npm ci
npx quartz build --serve
```

명령을 실행한 뒤 터미널에 표시되는 로컬 주소로 접속합니다. 정적 사이트만 빌드하려면 다음 명령을 사용합니다.

```bash
npx quartz build
```

## 노트 게시

`content/` 아래의 Markdown 파일이 사이트 콘텐츠가 됩니다. Obsidian vault에서 공개 노트를 가져오려면 [`copy.sh`](copy.sh)의 `SRC` 경로를 환경에 맞게 확인한 뒤 실행합니다.

```bash
./copy.sh
```

스크립트는 frontmatter에 `draft: false`가 지정된 Markdown 문서만 원본 폴더 구조를 유지해 복사합니다. 실행할 때 기존 `content/` 내용은 `.gitkeep`을 제외하고 삭제되므로, 커밋하지 않은 변경 사항이 없는지 먼저 확인하세요.

## 주요 설정

- 사이트 설정과 플러그인: [`quartz.config.ts`](quartz.config.ts)
- 페이지 레이아웃: [`quartz.layout.ts`](quartz.layout.ts)
- 스타일 재정의: [`quartz/styles/custom.scss`](quartz/styles/custom.scss)
- 공개 콘텐츠: [`content/`](content)

현재 한국어 로케일, SPA 탐색, 전체 텍스트 검색, 그래프 뷰, 백링크, 다크 모드, 리더 모드, RSS·사이트맵을 사용합니다.

타입과 코드 스타일은 `npm run check`, 테스트는 `npm test`로 확인할 수 있습니다.

## 라이선스

Quartz 소스 코드는 [`LICENSE.txt`](LICENSE.txt)의 MIT License를 따릅니다. `content/`의 문서는 별도 허가 없이 재배포할 수 없습니다.
