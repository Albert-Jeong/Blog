---
draft: false
tags:
  - 2-1/자료구조
date: 2025-04-22
---
## 메모
|     자료구조     |    Search    | Insert/Delete |
| :----------: | :----------: | :-----------: |
|     Tree     |    $O(n)$    | $O(n)$(위치 탐색) |
| Binary Tree  |    $O(n)$    | $O(n)$(위치 탐색) |
|     Heap     |    $O(n)$    | $O(\log{n})$  |
|     BST      | $O(\log{n})$ | $O(\log{n})$  |
|  Skewed BST  |    $O(n)$    |    $O(n)$     |
| Balanced BST | $O(\log{n})$ | $O(\log{n})$  |

|    구조    |           특징           |        시간 복잡도         |
| :------: | :--------------------: | :-------------------: |
|  이진 트리   |  자식 최대 2개, 다양한 순회 방법   |           -           |
| 이진 탐색 트리 | 왼쪽 < 루트 < 오른쪽, 정렬된 탐색  | O(h): O(log n) ~ O(n) |
|   힙 트리   | 완전 이진 트리, 최대/최소값 빠른 접근 |    삽입/삭제 O(log n)     |

## 1. 트리(Tree)
### 1.1. Definition
- **트리**(Tree)
	- 계층적인 관계를 표현하는 비선형 자료구조
	- 그래프의 특수한 형태이다.
	- 노드와 간선으로 구성된다.
	- 루트와 서브트리로 나눌 수 있다.

- **Applications**
	- 가계도, 컴퓨터의 폴더 구조, 탐색 트리, 힙 트리 등
	- 결정 트리 (e.g. 8개의 동전 문제)
	- 게임 트리

### 1.2. 용어
- 노드 특성 관련 용어
	- **루트 노드**(Root): 트리의 최상위 노드
	- **비단말 노드**(Internal Node): 자식이 있는 노드
	- **단말 노드**(Leaf): 자식이 없는 노드 (차수 0)
		- **노드의 차수**(Degree): 어떤 노드의 자식 수 
		- (트리의 차수는 노드들의 차수 중 최댓값)

- 노드 관계 관련 용어
	- **부모 노드**(Parent): 어떤 노드의 바로 위 노드
	- **형제 노드**(Sibling): 같은 부모를 가지는 노드
	- **자식 노드**(Child): 어떤 노드의 바로 아래 노드들
	
	- **조상 노드**(Ancestor): 어떤 노드 위의 모든 노드
	- **자손 노드**(Descendant): 어떤 노드 아래의 모든 노드

- 위치/깊이 관련 용어
	- **레벨**(Level): 루트(레벨 1)부터 시작
	- **깊이**(Depth): 루트(깊이 0)부터 시작
	- **높이**(Height): 리프(높이 0)부터 시작

### 1.3. 표현
1. **N-링크 표현**
	- 노드가 최대 n개의 자식을 가질 수 있도록 n개의 링크 필드 사용
	- (링크 수 예측이 어려움)

2. **왼쪽 자식-오른쪽 형제 표현**
	- 각 노드가 두 개의 포인터만 가짐
	- **왼쪽 포인터**: 첫 번째 자식 노드
	- **오른쪽 포인터**: 다음 형제 노드

3. **기타 표현 방법**
	- **중첩된 집합**: 노드를 포함 관계로 나타냄
	- **중첩된 괄호**: `(A (B (E)(F)(G(K))) (C(H)) (D(I)(J)))`
	- **들여쓰기(indentation)**: 계층 구조를 들여쓰기로 표현

## 2. 이진 트리 (Binary Tree)
### 2.1. Definition
- **Features**
	- 모든 노드의 **자식 수를 최대 2개**로 제한한 트리
	- 왼쪽 자식과 오른쪽 자식은 반드시 구별

- **Applications**
	- 수식 트리
	- 문법의 파싱 트리(식, 구문)
	- 호프만 코딩 트리

### 2.2. 종류
- **편향 이진 트리**(Skewed Binary Tree)
	- 왼쪽 또는 오른쪽으로 편향된 트리

- **균형 이진 트리**(Balanced Binary Tree)
	- 모든 노드의 좌우 서브트리 높이 차이가 1 이하인 트리

- ==완전 이진 트리==(Complete Binary Tree)
	- 레벨 1부터 k-1까지는 노드가 모두 차 있고,
	- 레벨 k는 노드가 왼쪽부터 차례로 차 있는 이진 트리
	- *예: 힙 트리*

- **포화 이진 트리**(Full Binary Tree)
	- 모든 레벨에 노드가 꽉 차있는 이진 트리

- ==이진 탐색 트리==(BST, Binary Search Tree)
	- 유일키, $L<V<R$ 관계 유지

### 2.3. 성질
|       구분       | Skewed |      Full       |
| :------------: | :----: | :-------------: |
| 노드가 n개일 때 간선 수 | $n-1$  |      $n-1$      |
|  노드가 n개일 때 높이  |  $n$   | $⌈log_2(𝑛+1)⌉$ |
| 높이가 h일 때 노드 수  |  $h$   |     $2^h-1$     |

### 2.4. 표현
- **배열 표현** (1-based index)
	- 완전 이진 트리를 기준으로 인덱스 번호를 배열 인덱스로 사용
		- parent index(`i/2`)
		- left child index(`2i`)
		- right child index(`2i+1`)
	- 단점: 경사 이진 트리의 경우 빈 칸이 많이 발생 → 메모리 낭비

- **연결 리스트 표현**
	- 노드 구조: left child link + data + right child link
```c
typedef struct TNode {
    TElement data;
    struct TNode* left;
    struct TNode* right;
} TNode;
```

### 2.5. 이진 트리의 순회(Traversal)
- **순회**(Traversal)
	- 트리의 모든 노드를 한 번씩 방문하는 작업

| 방식  |     순회      | 표기  | 특징                       | 주요 용도               |
| :-: | :---------: | :-: | ------------------------ | ------------------- |
| DFS |  Pre-order  | VLR | 루트 노드를 먼저 방문             | 트리 구조 복사, 재귀적 문제 해결 |
| DFS |  In-order   | LVR | 이진 탐색 트리에서 정렬된 순서로 방문    | 이진 탐색 트리에서 값 정렬     |
| DFS | Post-order  | LRV | 자식 노드를 먼저 방문한 후 부모 노드 처리 | 트리 삭제, 메모리 해제       |
| BFS | Level-order |  -  | 너비 우선 탐색, 큐를 사용하여 구현     | 최단 경로 탐색, 넓이 기반 탐색  |

#### (1) 전위 순회 (Preorder; VLR)
![|400](https://imgur.com/tqoB8Ce.png)
```
preorder(n)
    if n ≠ NULL :
        VisitNode(n)         // 루트 노드 처리
        preorder(n.left)     // 왼쪽 서브 트리 처리
        preorder(n.right)    // 오른쪽 서브 트리 처리
```

```c
void preorder(TNode* n) {
	if (n == NULL) return; // Early Return
	VisitNode(n);
	preorder(n->left);
	preorder(n->right);
}
```

#### (2) 중위 순회 (Inorder; LVR)
![|400](https://imgur.com/2s0Wowm.png)
```
inorder(n)
    if n ≠ NULL :
        inorder(n.left)      // 왼쪽 서브 트리 처리
        VisitNode(n)         // 루트 노드 처리
        inorder(n.right)     // 오른쪽 서브 트리 처리
```

```c
void inorder(TNode* n) {
	if (n == NULL) return; // Early Return
	inorder(n->left);
	VisitNode(n);
	inorder(n->right);
}
```

#### (3) 후위 순회 (Postorder; LRV)
![|400](https://imgur.com/YqCYNMn.png)
```
postorder(n)
    if n ≠ NULL :
        postorder(n.left)    // 왼쪽 서브 트리 처리
        postorder(n.right)   // 오른쪽 서브 트리 처리
        VisitNode(n)         // 루트 노드 처리
```

```c
void postorder(TNode* n) {
	if (n == NULL) return; // Early Return
	postorder(n->left);
	postorder(n->right);
	VisitNode(n);
}
```

#### (4) 레벨 순회 (Level Order)
- 큐(Queue)를 사용하여 구현
```
levelorder(root)
    if root ≠ NULL :
        init_queue()
        enqueue(root)
        while not is_empty(queue) :
            n ← dequeue()
            if n ≠ NULL :
                VisitNode(n)
                enqueue(n.left)
                enqueue(n.right)
```

```c
void levelorder(TNode* root) {
	if (root == NULL) return; // Early Return
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

### 2.6. 이진 트리 관련 문제
#### (1) 노드 개수 구하기
- `1 + 왼쪽 서브트리 노드 수 + 오른쪽 서브트리 노드 수` (후위 순회 응용)
```
count_node(n)
    if n = NULL : return 0
    n_left ← count_node(n.left)     // 왼쪽 서브 트리 처리
    n_right ← count_node(n.right)   // 오른쪽 서브 트리 처리
    return 1 + n_left + n_right      // 루트 노드 처리
```

```c
int count_node(TNode* n) {
    if (n == NULL) return 0;
    else return 1 + count_node(n->left) + count_node(n->right);
}
```

#### (2) 트리의 높이 구하기
- `1 + max(왼쪽 서브트리 높이, 오른쪽 서브트리 높이)` (후위 순회 응용)
```
calc_height(n)
    if n = NULL : return 0
    else : return 1 + max(calc_height(n.left), calc_height(n.right))
```

```c
int calc_height(TNode* n) {
    if (n == NULL) return 0;
    else return 1 + MAX(calc_height(n->left), calc_height(n->right));
}
```

#### (3) 트리를 좌우로 대칭시키기
- 좌우 자식 노드의 포인터를 교환한 후, 서브 트리에 대해 재귀 호출 (전위 순회 응용)
```
reverse(n)
    if n ≠ NULL :
        n.left ↔ n.right         // 루트 처리: 좌우 서브 트리 교환
        reverse(n.left)           // 왼쪽 서브 트리 처리
        reverse(n.right)          // 오른쪽 서브 트리 처리
```

```c
void reverse(TNode* p) {
    if (p != NULL) {
        TNode* tmp = p->left;
        p->left = p->right;
        p->right = tmp;
        reverse(p->left);
        reverse(p->right);
    }
}
```

#### (4) 노드의 레벨 구하기 (전위 순회)
- 타겟(key)을 찾을 때까지 내려가며 level 값을 1씩 증가시킴
```
calc_level(n, key, level)
    if n = NULL : return 0
    if n = key : return level       // 레벨이 결정됨 (> 0)
    lev ← calc_level(n.left, key, level+1)   // 왼쪽 서브 트리 처리
    if lev > 0 : return lev
    else: return calc_level(n.right, key, level+1)  // 오른쪽 서브 트리 처리
```

```c
int calc_level(TNode* n, TNode* key, int level) {
    if (n == NULL) return 0;           // 찾는 노드 key가 없음
    if (n == key) return level;        // 노드 key 찾음. level 반환
    int l = calc_level(n->left, key, level + 1);
    if (l > 0) return l;
    return calc_level(n->right, key, level + 1);
}
```

## 3. Heap Tree
### 3.1. Definition
- **Features**
	- 완전 이진 트리 + 힙 속성
	- ==최대·최소를 $O(1)$로 반환==
	- 중복 키 가능

- **힙 속성**
	- **최대 힙**(Max Heap): 부모 ≥ 자식
	- **최소 힙**(Min Heap): 부모 ≤ 자식

- 힙의 배열 표현
	- 완전 이진 트리의 성질을 이용해 배열로 표현 (인덱스 1부터 시작)
	- k의 부모: `k / 2`
	- k의 왼쪽 자식: `k * 2`
	- k의 오른쪽 자식: `k * 2 + 1`

- **Applications**
	- 우선순위 큐
	- 힙 정렬
	- 그래프 최단 경로(Dijkstra)
	- 실시간 스케줄러

### 3.2. 연산
- 완전 이진 트리의 구조를 지키기 위한 연산
    - **삽입**(up-heap): 마지막 노드에 추가 후 위로 조정
    - **삭제**(down-heap): 루트 제거 후 마지막 노드를 루트로 이동, 아래로 조정

#### (1) 힙의 삽입 연산 (Up-heap)
- 마지막 노드 위치에 삽입 → 부모와 비교하며 위로 이동
```
heap_push(n)
    heap_size ← heap_size + 1
    i ← heap_size
    A[i] ← node
    while i ≠ 1 :
        if KEY(i) > KEY(PARENT(i)) :
            A[i] ↔ A[PARENT(i)]
            i ← PARENT(i)
        else : break
```
- 시간 복잡도: $O(\lg{n})$

#### (2) 힙의 삭제 연산 (Down-heap)
- 루트 노드를 삭제 → 마지막 노드를 루트로 이동 → 아래로 내려가며 정렬
```
heap_pop()
    root ← A[1]              // 삭제할 루트 노드 저장
    A[1] ← A[heap_size]     // 말단 노드를 루트에 복사
    heap_size ← heap_size - 1
    i ← 1                   // 루트의 위치
    while LEFT(i) ≤ heap_size :  // 자식 노드가 남아 있을 때까지
        if LEFT(i) < heap_size and KEY(LEFT(i)) > KEY(RIGHT(i)) :
            child ← LEFT(i)     // 왼쪽이 크면 왼쪽 자식 위치
        else : child ← RIGHT(i) // 오른쪽이 크면 오른쪽 자식 위치

        if KEY(i) > KEY(child) : break  // 자식보다 크면 제자리 찾았음
        else :
            A[i] ↔ A[child]    // 자식과 교환
            i ← child          // 자식 위치로 내려옴
    return root                 // 저장해 둔 루트를 반환
```
- 시간 복잡도: $O(\lg{n})$

## 4. 이진 탐색 트리 (BST)
### 4.1. Definition
- **이진 탐색 트리** (BST; Binary Search Tree)
	- **효율적인 탐색**을 위한 이진 트리 기반의 자료구조
	- ==왼쪽 < 부모 < 오른쪽==, 중복 키 불가능

- 성질
	- 서브 트리도 이진 탐색 트리이다.
	- ==트리 높이 h가 성능을 좌우한다.== ($O(h)$)

### 4.2. 연산
#### (1) 탐색 연산
- 탐색값이 키값보다 작으면 왼쪽, 크면 오른쪽으로 이동
```
search(root, key)
    if root = NULL : return NULL
    if KEY(root) = key : return root        // 루트의 키가 key와 같으면 탐색 성공
    else if KEY(root) < key :
        return search(root.left, key)       // 왼쪽 서브 트리 탐색
    else :
        return search(root.right, key)      // 오른쪽 서브 트리 탐색
```

#### (2) 삽입 연산
- 탐색 연산 후 적절한 위치에 노드 추가
```
insert(root, n)
    if KEY(n) < KEY(root) :       // root보다 키가 작으면 → 왼쪽
        if root.left = NULL :
            root.left ← n        // n이 왼쪽 자식
        else insert(root.left, n) // 있으면 왼쪽 서브 트리에 삽입
    else if KEY(n) > KEY(root) :  // root보다 키가 크면 → 오른쪽
        if root.right = NULL :
            root.right ← n       // n이 오른쪽 자식
        else : insert(root.right, n)  // 있으면 오른쪽 서브 트리에 삽입
    else :                        // 중복된 키가 있음.
        delete_node(n)            // 노드 n 삭제
```

#### (3) 삭제 연산
- Case 1: **자식 0개** 단말 노드의 삭제
	- 해당 노드를 삭제하고 부모 노드의 링크를 NULL로 변경
- Case 2: **자식 1개** 노드의 삭제
	- 해당 노드를 삭제하고 부모 노드의 링크를 자식 노드로 변경
- Case 3: **자식 2개** 노드의 삭제
	- **후계자 노드**를 이용
	    - 왼쪽 서브 트리에서 가장 큰 노드, 또는
	    - 오른쪽 서브 트리에서 가장 작은 노드
	- 후계자의 데이터를 삭제할 노드에 복사하고, 실제로는 후계자 노드를 삭제

```
delete(root, key)
    n ← 삭제할 노드
    parent ← n의 부모 노드
    if n = NULL : return root

    // case1: n이 단말 노드인 경우
    if n.left=NULL and n.right=NULL :
        if parent=NULL : root ← NULL
        else if parent.left = n : parent.left ← NULL
        else : parent.right ← NULL

    // case2: n이 하나의 자식만 갖는 경우
    else if n.left=NULL or n.right = NULL :
        child ← n의 유일한 자식
        if parent = NULL : root ← child
        else if parent.left = n : parent.left ← child
        else : parent.right ← child

    // case3: n이 양쪽 자식을 모두 갖는 경우
    else :
        succ ← n.right          // 오른쪽
        while succ.left ≠ NULL :
            succ ← succ.left
        n.data ← succ.data      // 노드의 데이터 복사
        n.right ← delete(n.right, KEY(succ))

    return root
```

### 4.3. 성능
- 연산들의 시간 복잡도: **O(h)** (트리의 높이 h에 비례)
	- 포화 이진 트리: h = ⌈log₂(n+1)⌉ → **O(log n)**
	- 완전 경사 트리: h = n → **O(n)**
		- 균형화가 필요 → **AVL 트리**

## 5. Balanced BST
- **Applications**
	- 운영체제 스케줄러(CFS: Red‑Black)
	- 데이터베이스 인덱스(B/B+‑Tree)
	- STL `map`/`set`

### 5.1. AVL Tree
- **AVL Tree** (Adelson-Velskii and Landis)
	- 삽입/삭제 시 LL, RR, LR, RL 회전으로 균형을 유지하여 $O(\log{n})$ 연산 보장

- **1번 회전**
    - **LL 회전**: 왼쪽 자식의 왼쪽 서브트리 삽입 시
    - **RR 회전**: 오른쪽 자식의 오른쪽 서브트리 삽입 시

- **2번 회전**
    - **LR 회전**: 왼쪽 자식의 오른쪽 서브트리 삽입 시
    - **RL 회전**: 오른쪽 자식의 왼쪽 서브트리 삽입 시

### 5.2. Red-Black Tree
- **Red-Black Tree**
	- 자가 균형 이진 탐색 트리(Self-Balancing BST)
	- 각 노드에 색(Red/Black)을 부여해 트리의 균형을 유지한다.

- **5가지 핵심 규칙**
	1. 모든 노드는 Red 또는 Black
	2. 루트는 항상 Black
	3. 모든 리프(NIL) 노드는 Black
	4. Red 노드의 자식은 반드시 Black (Red-Red 연속 불가)
	5. 임의 노드에서 리프까지 모든 경로의 Black 노드 수는 동일 (Black-height 일치)

- **성능**
	- 삽입/삭제/탐색 모두 O(log n)
	- 회전(Rotation)과 재색칠(Recoloring)으로 균형 유지

- **사용 사례**
	- Java의 `TreeMap`, `TreeSet`
	- C++ STL의 `map`, `set`
	- Linux 커널 스케줄러 등

### 5.3. B/B+ Tree
- **B-Tree**
	- 모든 노드가 여러 개의 키와 자식 포인터를 가질 수 있는 균형 다중 경로 트리(Balanced Multi-way Tree)
	- 차수(order) m인 B-Tree는 각 노드가 최대 m-1개의 키와 m개의 자식을 가진다.

- **특징**
	- 내부 노드에도 실제 데이터가 있어 탐색이 중간에 끝날 수 있음
	- 하지만 범위 탐색 시 트리를 전체 순회해야 해서 비효율적이다.

- **B+Tree**
	- B-Tree의 변형으로, 데이터베이스 인덱스에서 압도적으로 많이 쓰인다.
	- **B-Tree와의 핵심 차이**
		- 내부 노드는 탐색을 위한 키(인덱스)만 가지고, 실제 데이터는 오직 리프 노드에만 저장된다.
		- 리프 노드들은 연결 리스트로 이어져 있어 범위 탐색(range query)이 매우 빠르다.

- **사용 사례**
	- MySQL InnoDB, PostgreSQL 등 대부분의 RDBMS 인덱스 구조