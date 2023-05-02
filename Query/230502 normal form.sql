# 함수 종속성
# X -> Y
# 주민번호 -> 이름
# 주민번호 -> { 이름, 나이, 성별, ..... }
# 주민번호를 알면 이름을 알 수 있다
# X 는 결정자

# spj 테이블에서는
# ( sno, pno, jno ) -> qty

##### 정규화
### 1NF (1st Normal Form)
#	도메인을 원자값으로 지정
#	같은 내용의 필드들을 제거 
#	("Customer ID", "Tel. No. 1", "Tel. No. 2", "Tel. No. 3" 와 같은 필드들이 한 테이블에 있다면 
#	"Customer ID", "Tel. No." 를 하나의 테이블로 뺀다. 1:N) 

### 2NF (2nd Normal Form)
#	기본키가 2개 이상으로 구성된 테이블에서 중복된 필드를 제거
#	-------------------------
#	종업원	기술			근무지
#	jones	Typing		A
#	jones	Writing		A
#	jones	Reading		A
#
#	{X1, X2} -> Y 에서
#	X1 과 X2 의 조합이 Y를 결정하는 것이 아니라
#	X1 과 X2 둘 중 하나가 Y 를 결정하는 경우
#	X1, X2 테이블과 X1, Y 테이블로 나눠야 함.
#	----------------
#	종업원	기술		
#	jones	Typing	
#	jones	Writing	
#	jones	Reading	
#
#	----------------
#	종업원	근무지		
#	jones	A	
#	rich	B	
#	matt	C	

### 3NF (3rd Normal Form)
#	한 필드에서 계산할 수 있는 정보를 가진 필드를 삭제하는 과정
#	이행적 함수의 종속을 제거 하는 과정
#	주민번호, 생년월일, 성별, 나이,.. 와 같은 필드들의 있는 테이블이 있는 경우
#	주민번호를 가지고 생년월일, 성별, 나이를 찾을 수 있다.
#	생년월일, 성별, 나이 필드 제거. 

### BCNF (Boyce-Codd Normal Form)

### 4NF (4th Normal Form)

### 5NF (5th Normal Form)

#
use mydb;
# 전화번호부 설계
# Reverse engineering ERD로 설계 후 Forwad engineering 실행
