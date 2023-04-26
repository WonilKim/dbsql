use warehouse;

call firstProc();

call getSC();

call getSC2(15);

call getStatus('London', @total);
select @total;

call getStatus2('London', @total);
select @total;

call getStatus3('London', @total);
select @total;

call getStatus4('London', @total);
select @total;

call getQtySum(1300);

call exception_handle('s'); # 존재하는 테이블 명을 입력받아도 에러 발생.
# select * from 's' 와 같이 from 문자열이 되기 때문에 에러 발생.

call exception_handle2('s'); # 에러 메시지와 select 1 이 2개의 탭으로 나뉘어 출력됨.

call simple_prepare();

call dynamicSQL('spj');

call dynamicSQL2('spj', 300);

call dynamicSQL3('spj', 300, 500);

call dynamicSQL3_1('spj', 500, 700);
