---
tags:
  - 2-1/자료구조
draft: false
---
## 1. 트리(Tree)
### 1.1. Definition
- **트리**(Tree)
	- 계층적 관계를 표현하는 자료구조
	- 그래프의 특수한 형태이다.
	- 노드와 간선으로 구성된다.
	- 루트와 서브트리로 나눌 수 있다.

- **Applications**
	- 결정 트리 (e.g. 8개의 동전 문제)
	- 게임 트리

### 1.2. 용어
- 노드 관계 관련 용어
	- **부모 노드**(Parent), **형제 노드**(Sibling), **자식 노드**(Child)
	- **조상 노드**(Ancestor), **후손 노드**(Descendant)

- 노드 특성 관련 용어
	- **루트**(Root)
	- **단말 노드**(Leaf Node; 자식이 없는 노드)
	- **차수**(Degree; 자식의 수)

- 위치/깊이 관련 용어
	- **레벨**(Level)
	- **깊이**(Depth)
	- **높이**(Height)

## 2. 트리의 구현
### 2.1. 표현
- **배열 표현**(1-based index)
	- parent index(`i/2`), left child index(`2i`), right child index(`2i+1`)

- **연결 리스트 표현**
	- left child link + data + right child link

### 2.2. 순회(Traversal)
| 방식  |     순회      | 표기  |       활용       |
| :-: | :---------: | :-: | :------------: |
| DFS |  Pre-order  | VLR | 트리 복사, Prefix  |
| DFS |  In-order   | LVR |  BST 오름차순 정렬   |
| DFS | Post-order  | LRV | 트리 삭제, Postfix |
| BFS | Level-order |  -  |  최단 경로, 너비 계산  |
- **순회**(Traversal): 트리의 모든 노드를 한 번씩 방문하는 작업

#### (1) Pre-order
![|400](https://imgur.com/tqoB8Ce.png)
```c
void preorder(TNode* n) {
	if (n == NULL) return;
	VisitNode(n);
	preorder(n->left);
	preorder(n->right);
}
```

#### (2) In-order
![|400](https://imgur.com/2s0Wowm.png)
```c
void inorder(TNode* n) {
	if (n == NULL) return;
	inorder(n->left);
	VisitNode(n);
	inorder(n->right);
}
```

#### (3) Post-order
![|400](https://imgur.com/YqCYNMn.png)
```c
void postorder(TNode* n) {
	if (n == NULL) return;
	postorder(n->left);
	postorder(n->right);
	VisitNode(n);
}
```

#### (4) Level-order
```c
void levelorder(TNode* root) {
	if (root == NULL) return;
	init_queue();
	enqueue(root);
	while (!is_empty()) {
		TNode* n = dequeue();
		if (n != NULL) {
			VisitNode(n);
			enqueue(n->left);
			enqueue(n->right);
		}
	}
}
```

## 3. 이진 트리(Binary Tree)
### 3.1. Definition
- **Features**
	- 자식 최대 2개

- **Applications**
	- 문법의 파싱 트리(식, 구문)
	- 호프만 코딩 트리

### 3.2. 종류
- **편향 이진 트리**(Skewed Binary Tree)
	- 왼쪽 또는 오른쪽으로 편향된 트리

- **균형 이진 트리**(Balanced Binary Tree)
	- 모든 노드의 좌우 서브트리 높이 차이가 1 이하인 트리

- ==완전 이진 트리==(Complete Binary Tree)
	- 레벨 1부터 k-1까지는 노드가 모두 차 있고, 레벨 k는 노드가 왼쪽부터 차례로 차 있는 이진 트리
	- 예: Heap

- **포화 이진 트리**(Full Binary Tree)
	- 모든 레벨에 노드가 꽉 차있는 이진 트리

- ==이진 탐색 트리==(BST, Binary Search Tree)
	- 유일키, $L<V<R$ 관계 유지

### 3.3. 성질
|       구분       | Skewed |      Full       |
| :------------: | :----: | :-------------: |
| 노드가 n개일 때 간선 수 | $n-1$  |      $n-1$      |
|  노드가 n개일 때 높이  |  $n$   | $⌈log_2(𝑛+1)⌉$ |
| 높이가 h일 때 노드 수  |  $h$   |     $2^h-1$     |

## 4. Heap
### 4.1. Definition
- **Features**
	- 완전 이진 트리 + 힙 속성
	- 최대·최소를 $O(1)$로 반환
	- 중복 키 가능

- **힙 속성**
	- **최대 힙**: 부모 ≥ 자식
	- **최소 힙**: 부모 ≤ 자식

- **Applications**
	- 우선순위 큐
	- 힙 정렬
	- 그래프 최단 경로(Dijkstra)
	- 실시간 스케줄러

### 4.2. 연산
- 완전 이진 트리의 구조를 지키기 위한 연산
    - **삽입**(up-heap): 마지막 노드에 추가 후 위로 조정
    - **삭제**(down-heap): 루트 제거 후 마지막 노드를 루트로 이동, 아래로 조정

## 5. BST
### 5.1. Definition
- **이진 탐색 트리**(BST, Binary Search Tree)
	- 효율적인 탐색을 위한 이진 트리 기반의 자료구조
	- ==왼쪽 < 부모 < 오른쪽==
	- 중복 키 불가능
	- ==트리 높이 h가 성능을 좌우한다.== ($O(h)$)

### 5.2. 연산
- **탐색**: 탐색값이 키값보다 작으면 왼쪽 크면 오른쪽
- **삽입**: 탐색 연산 후 적절한 위치에 노드 추가
- **삭제**
	- 자식 0개(단말 노드): 삭제할 노드를 직접 삭제
	- 자식 1개: 삭제할 노드의 부모와 자식을 연결
	- 자식 2개: 삭제할 노드를 **후계자 노드**로 대체
		- 후계자 노드: 관례적으로 오른쪽 서브트리 최솟값
		- 실제로는 후계자 노드가 삭제됨

## 6. Balanced BST
- **Applications**
	- 운영체제 스케줄러(CFS: Red‑Black)
	- 데이터베이스 인덱스(B/B+‑Tree)
	- STL `map`/`set`

### 6.1. AVL Tree
- **AVL Tree** (Adelson-Velskii and Landis)
	- 삽입/삭제 시 LL, RR, LR, RL 회전으로 균형을 유지하여 $O(\log{n})$ 연산 보장

- **1번 회전**
    - **LL 회전**: 왼쪽 자식의 왼쪽 서브트리 삽입 시
    - **RR 회전**: 오른쪽 자식의 오른쪽 서브트리 삽입 시

- **2번 회전**
    - **LR 회전**: 왼쪽 자식의 오른쪽 서브트리 삽입 시
    - **RL 회전**: 오른쪽 자식의 왼쪽 서브트리 삽입 시

### 6.2. Red-Black Tree

### 6.3. B/B+ Tree

## 7. 부록
|     자료구조     |    Search    | Insert/Delete |
| :----------: | :----------: | :-----------: |
|     Tree     |    $O(n)$    | $O(n)$(위치 탐색) |
| Binary Tree  |    $O(n)$    | $O(n)$(위치 탐색) |
|     Heap     |    $O(n)$    | $O(\log{n})$  |
|     BST      | $O(\log{n})$ | $O(\log{n})$  |
|  Skewed BST  |    $O(n)$    |    $O(n)$     |
| Balanced BST | $O(\log{n})$ | $O(\log{n})$  |
