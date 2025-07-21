---
tags:
  - 2-1/자료구조
draft: false
---
## 1. 트리(Tree)
- **트리**: 계층적인 관계를 표현하는 자료구조
	- ==그래프의 특별한 형태==
	- ==루트와 서브트리로 구성==
	- **방향 트리**: 방향이 있고 순서화된 트리 (`<선행자>`와 `후속자`를 사용)

 - **트리의 활용**
	- 문법의 파싱
	- 결정 트리
		- 8개의 동전 문제: 무게가 다른 불량품 동전 찾기
	- 게임 트리

|        구분 1         |          구분 2          | 구분 3 |   구분 4    |
| :-----------------: | :--------------------: | :--: | :-------: |
| 높이(↕)<br>깊이, 최대 레벨) |         루트 노드          |  조상  |   부모 노드   |
|          -          |         중간 노드          |  -   |   형제 노드   |
|      차수, 숲(↔️)      | 단말/<br>잎 노드(leaf node) |  자손  | 자식 노드(차수) |

## 2. 이진 트리(Binary Tree)
|     자료구조     |      탐색      |    삽입/삭제     |
| :----------: | :----------: | :----------: |
|  Heap Tree   |    $O(N)$    | $O(\log{N})$ |
|  Skewed BST  |    $O(N)$    |    $O(N)$    |
| Balanced BST | $O(\log{N})$ | $O(\log{N})$ |
- **Binary Tree**: 루트와 왼쪽/오른쪽 서브트리 또는 공집합으로 구성되는 트리

### 2.1. 종류
- **Skewed**
	- 왼쪽 또는 오른쪽으로 편향된 트리

- **Balanced**
	- 모든 노드의 좌우 서브트리 높이 차이가 1 이하인 트리

- **Complete**
	- 레벨 1부터 k-1까지는 노드가 모두 차 있고, 레벨 k는 노드가 왼쪽부터 차례로 차 있는 이진 트리
	- 예: Heap Tree (중복키 허용, 부모와 자식의 키값을 비교)

- **Full**
	- 모든 레벨에 노드가 꽉 차있는 이진 트리
	- 전체 노드 개수: $\sum\limits_{i=0}^{k-1}2^i=2^k-1$

- **Search**
	- 유일키, $L<V<R$ 관계 유지
	- 균형 유지 AVL

### 2.2. 성질
|       구분       | Skewed |      Full       |
| :------------: | :----: | :-------------: |
| 노드가 n개일 때 간선 수 | $n-1$  |      $n-1$      |
|  노드가 n개일 때 높이  |  $n$   | $⌈log_2(𝑛+1)⌉$ |
| 높이가 h일 때 노드 수  |  $h$   |     $2^h-1$     |

### 2.3. 표현 방법
|   연산   | 배열 표현  |  연결 리스트 표현   |
| :----: | :----: | :----------: |
| 인덱스 접근 | $O(1)$ |    $O(N)$    |
|   탐색   | $O(N)$ | $O(\log{N})$ |
| 삽입/삭제  | $O(N)$ | $O(\log{N})$ |
| 메모리 효율 |  비효율적  |     효율적      |

- **배열 표현**
	- parent index: `i/2`
	- left child index: `2i`
	- right child index: `2i+1`

- **연결 리스트 표현**: left child link + data + right child link

### 2.4. 순회(Traversal)
| 방식  |     순회      | 표기  |       활용       |
| :-: | :---------: | :-: | :------------: |
| DFS |  Pre-order  | VLR | 트리 복사, Prefix  |
| DFS |  In-order   | LVR |  BST 오름차순 정렬   |
| DFS | Post-order  | LRV | 트리 삭제, Postfix |
| BFS | Level-order |  -  |  최단 경로, 너비 계산  |
- **순회**(traversal): 트리의 모든 노드를 한 번씩 방문하는 작업

#### (1) Pre-order
![[VLR.png|300]]
```c
void preorder(TNode* n) {
	if (n == NULL) return;
	VisitNode(n);
	preorder(n->left);
	preorder(n->right);
}
```

#### (2) In-order
![[LVR.png|300]]
```c
void inorder(TNode* n) {
	if (n == NULL) return;
	inorder(n->left);
	VisitNode(n);
	inorder(n->right);
}
```

#### (3) Post-order
![[LRV.png|300]]
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

## 3. 힙(Heap)
- **힙 트리**
	- ==완전 이진 트리의 일종==
	- 키값이 가장 큰(작은) 노드를 빨리 찾을 수 있도록 설계
	- **최대 힙**: 부모의 키값 ≥ 자식의 키값
	- **최소 힙**: 부모의 키값 ≤ 자식의 키값
	- 같은 키값 가능

- **연산**($O𝑙𝑜𝑔2n$)
	- 완전 이진 트리의 구조를 지키기 위한 연산
    - **삽입(up-heap)**: 마지막 노드에 추가 후 위로 조정
    - **삭제(down-heap)**: 루트 제거 후 마지막 노드를 루트로 이동, 아래로 조정

## 4. BST(Binary Search Tree)
- **이진 탐색 트리**(BST, Binary Search Tree)
	- 효율적인 탐색을 위한 이진 트리 기반의 자료구조
	- 모든 노드는 유일한 키를 갖는다.
	- 왼쪽 서브트리의 키값 < 루트의 키값 < 오른쪽 서브트리의 키값

### 4.1. 연산
- **탐색**: 탐색값이 키값보다 작으면 왼쪽 크면 오른쪽
- **삽입**: 탐색 연산 후 적절한 위치에 노드 추가
- **삭제**
	- 자식 0개(단말 노드): 삭제할 노드를 직접 삭제
	- 자식 1개: 삭제할 노드의 부모와 자식을 연결
	- 자식 2개: 삭제할 노드를 **후계자 노드**로 대체
		- 후계자 노드: 오른쪽 서브트리 최솟값 또는 왼쪽 서브트리 최댓값
		- 실제로는 후계자 노드가 삭제됨

- **연산의 시간 복잡도**: 트리의 높이 h에 비례 O(h)

### 4.2. Skewed BST
- 생성과 삽입이 단순해짐 (사실상 Linked LIst처럼 동작)
- 탐색과 삭제가 선형 시간($O(n)$) 걸림 (BST의 핵심인 $O(\log{n})$ 탐색 불가능)

### 4.3. Balanced BST
- 연산의 대부분이 발생하는 탐색/삽입/삭제에서 일관된 성능을 보장하기 때문에 Skewed 대신 Balanced를 사용한다.

- 종류
	- AVL Tree
	- Red-Black Tree
	- B Tree / B+ Tree