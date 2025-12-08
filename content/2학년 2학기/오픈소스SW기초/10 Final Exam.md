---
draft: false
tags:
  - 2-2/오픈소스SW기초
date: 2025-12-09
---
## 04 Commit (Local)
### cf. 옵션 정리
- `git commit` 명령어의 주요 옵션
	- `-m`(`--message`): 커밋 메시지를 별도의 편집기 없이 인라인으로 바로 작성한다.
	- `-a`(`--all`): 수정되거나 삭제된 파일들을 자동으로 스테이징 영역에 추가(add)하고 커밋한다.
	- `-am`: `-a`와 `-m` 옵션을 함께 사용한다.
	- `--amend`: 가장 최근의 커밋을 수정한다. (메시지를 수정하거나, 빠진 파일을 추가하여 커밋 내용을 덮어쓴다.)
	- `-v`(`--verbose`): 커밋 메시지 편집기를 열 때 변경 내용을 diff 형식으로 함께 보여준다.

### cf. 운영체제별 줄바꿈 문자
|    운영체제     |                  줄바꿈 문자 조합                  | ASCII 코드 |
| :---------: | :-----------------------------------------: | :------: |
| **Windows** | **CR**(Carriage Return) + **LF**(Line Feed) |  13 10   |
|  **Unix**   |           **CR**(Carriage Return)           |    13    |
|  **macOS**  |              **LF**(Line Feed)              |    10    |

## 05 Server (Remote)
- **Local**
	- **개념**: 내 컴퓨터의 다른 폴더를 원격 저장소처럼 사용하는 방식(NFS; Network File System)
	- **특징**: 가장 빠르고 간단하지만, 모든 자료가 내 컴퓨터에만 있어 ==백업 관점에서는 위험==하다.

- **HTTP/HTTPS**
	- **개념**: 아이디와 비밀번호를 이용해 웹 주소(URL)로 접속하는 가장 일반적인 방식
	- **특징**: 깃허브(GitHub) 같은 대부분의 호스팅 서비스가 기본으로 지원한다. ==HTTP는 암호화되지 않아== 보안을 위해 암호화된 **HTTPS**를 사용한다.

- **SSH**
	- **개념**: 아이디/비밀번호 대신, 미리 등록된 인증키를 사용해 접속하는 보안이 강화된 방식
	- **특징**: 깃(Git)에서 권장하는 방식으로, 한번 설정해두면 비밀번호 입력 없이 안전하게 통신할 수 있어 선호된다. ==익명으로 접속할 수 없다.==

- **Git**
	- **개념**: 깃 전용으로 만들어진 매우 빠른 통신 방식 (깃의 데몬 서비스를 위한 전용 프로토콜)
	- **특징**: 별도의 인증 기능이 없어 ==보안에 취약==하기 때문에, 일반적으로 잘 사용되지 않는다.

## 06 Branch
```sh
# 기본 목록 확인
❯ git branch # 로컬 브랜치 목록 (-l, --list)
  feature
* master

❯ git branch -r # 리모트 브랜치 목록 (--remotes)
  remotes/origin/function
  remotes/origin/master

❯ git branch -a # 모든 브랜치 목록 (--all)
  feature
* master
  remotes/origin/function
  remotes/origin/master
```

```sh
# 상세 정보 확인 (--verbose)
❯ git branch -v # 체크아웃(*) 브랜치명 커밋ID 커밋명
  feature fc152c5 function working
* master  a70d8c5 master working...

❯ git branch -vv # -v에 원격 업스트림 브랜치 정보 포함
  feature fc152c5 [origin/function] function working
* master  a70d8c5 [origin/master] master working...
```

## 08 Merge & Conflict
- **Fast-Forward 병합**
	- 병합하려는 두 브랜치가 일직선상에 있을 때
	- 기준 브랜치의 포인터(HEAD)만 최신 커밋으로 이동한다.
	- 별도의 병합 커밋이 생성되지 않는다.

- **3-way 병합**
	- 병합하려는 두 브랜치가 갈라져서 서로 다른 작업을 했을 때
	- 3개의 커밋(공통 조상(Base), 기준 브랜치, 대상 브랜치)을 비교한다.
	- 새로운 병합 커밋이 생성된다.

- **커밋 메시지의 변경**
```sh
# 가장 최근(마지막) 커밋 메시지 변경
git commit --amend
git commit --amend -m "새로운 커밋 메시지"

# 이전 또는 여러 개의 커밋 메시지 변경
git rebase -i HEAD~3  # 현재 커밋 포함 이전 3개의 커밋
```

## 09 Recovery
- `git reset [옵션] [커밋ID]`: 특정 커밋 시점으로 되돌아간다. (`HEAD` 포인터 이동)
	- `--soft`: 변경된 파일들을 Staging Area에 남겨둔다.
	- `--mixed` (기본값): 변경된 파일들을 Working Directory에 남겨둔다.
	- `--hard`: 변경된 파일들을 모두 삭제한다.

- `git revert [커밋ID]`: 특정 커밋의 변경 사항을 정반대로 수행하는 새로운 커밋을 만든다.

- `git restore`: 커밋하지 않은 변경사항을 취소한다.
	- `--staged`: Staging을 취소한다.