
print("Hello World!!!")
kor=int(input('국어점수:'))
math=int(input('수학점수:'))
sum=kor+math
print("합계:", sum)

print("안녕하세요")
name='파이썬'
print('반갑습니다. 제 이름은',name,'입니다.')
print("python "+"language")
print("python","language")
print("python"*5)

5/2  #실수형
5//2 #정수형

print("python")
print("python", end="")
print("a","b","c")  #공백있음
print("a","b","c", sep="")  #공백없이

print("python","program","cool")
print("python","program","cool", sep=(","))

print("%d" %10)
print("국어 : %d, 수학 : %d, 영어 : %d" %(90,100,95))
print("원의 넓이=%5.3f" %(5*5*3.14))

print("이름:{}, 나이:{}".format("홍길동",20))  #format 중괄호 표시로 데이터 값 순서 지정 
print("이름: %s, 나이: %d" %("홍길동",20))
print("{0}군은 {1}과에 재학 중이며 {0}의 지도교수는 {2}이다".format("홍길동","컴퓨터공학","최형식"))

name="홍길동"
age=20
print(f"이름은 {name}이고, 나이는 {age}세이다.")  #문자열 포맷팅

num1=num2=num3=10
sum=num1+num2+num3
print(f"{num1}+{num2}+{num3}의 합계는 {sum}이다")

kor=int(input('국어='))
eng=int(input('영어='))
math=int(input('수학='))
total=kor+eng+math
print(f"총점:  {total}")
avg=total/3
print(f"평균: {avg:.2f}")

name="홍길동"
age=20
city="Paju"
print("안녕하세요 " +name+ " 입니다.")
print("제 나이는 " +str(age)+ "세이며", end="")
print("\t\t사는 곳은 " +city+ "이며" + " 고향은 \"" +city+ "\"입니다.")   #\"를 사용하여 문자열 안에 큰따옴표
                                                                       #\t\t  두개의 탭만큼 들여쓰기                                       
print("제 나이는 " + str(age) + "세이며,  \n사는 곳은 " + city + "이며 고향은 \"" + city + "\"입니다.")

num1,num2,num3=100,200,300
print("{0:d} {1:5d} {2:05d}" .format(num1,num2,num3))

num1=45000000
num2=100000.41375
print("num1 변수: {0:0.2f}".format(num1))
print("num2 변수: {0:0,.2f}".format(num2))   #천 단위 구분 기호(,)를 사용하고 소수점 2자리

name="홍길동"
kibon=2000000
bonus=500000
salary=kibon+bonus
print("{0}씨의 월급은 기본급 {1:,} 보너스 {2:,}, 총급여액 {3:,}이다".format(name,kibon,bonus,salary))

p=300000
print("홍길동 군 가족 제주도 여행 \n서울-제주 왕복 비행기 가격은 1인당 {0:,}원이고, \n성인 4명 비행기 가격은 {1:,}원이다" .format(p,p*4))

name=input("이름을 입력하세요:")
year,month,day=input("당신이 태어난 해의 년도, 월, 일을 차례로 입력하세요:").split()
print(f"{name}씨! 당신의 생년월일은 {year}년 {month}월 {day}일입니다.")

a=int(input("첫 번째 정수?"))
b=int(input("두 번째 정수?"))
c=int(input("세 번째 정수?"))
sum=a+b+c
print(f"{a}과 {b}과 {c}의 합은 {sum:,}이다")

grade_list=[90,85,70,85,90]
grade_list.append(100)    #값 추가
grade_list[-4] 
grade_list[-0]

num=[10,20,30,40,50]
num.remove(50)    #값 삭제
print(num)

num=[100,200,300,400,500]
del num[0]   #인덱스 삭제
num

del num[-1]   #맨 뒤 항목 인덱스 삭제
print(num)
del num   #리스트 완전 삭제
num

num=[10,20,30,40,50]
num.pop()   #인덱스 안주면 맨 뒤 삭제, 삭제하는 값 알려줌
num1

alpha=['a','b','c','d','e']
alpha.clear()    #모든 항목값 한번에 삭제. 리스트 구조는 남아있음
alpha

용돈=10000
price=3550
거스름돈=10000-3550
거스름돈
print(f" 용돈 {용돈}원")
print(f" 거스름돈 {거스름돈}원")
print(f" 500원짜리 거스름돈: {거스름돈//500} 개")
print(f" 100원짜리 거스름돈: {(거스름돈%500)//100} 개")
print(f" 50원짜리 거스름돈: {((거스름돈%500)%100)//50} 개")

######################################
# if문

num=int(input("숫자 입력:"))
if num<10:
    print("10보다 작은 숫자입니다.")
    print("if문 테스트")
print("프로그램 종료")


num=int(input("숫자 입력: "))
if num<10:
    print("10보다 작은 숫자입니다.")
else:
    print("10보다 크거나 같은 숫자입니다.")


num=int(input("숫자 입력"))
if num%2==0:
    print("입력한 수 %d는 짝수입니다." %num)
else:
    print("입력한 수 %d는 홀수입니다." %num)


n=int(input("어떤 수?"))
if n<50:
    print("입력한 수 %d는 50보다 작습니다." %n)
elif n<100:
    print("입력한 수 %d는 50보다 크고 100보다 작습니다." %n)
else:
    print("입력한 수 %d는 100보다 큽니다." %n)


score=int(input("정수 입력:"))
if score>=90:
    print("A")
elif score>=80:
    print("B")
elif score>=70:
    print("C")
elif score>=60:
    print("D")
else:
    print("F")


num=int(input("숫자 정수:"))
if num>0:
    print("양수")
elif num==0:
    print("제로(0)")
else:
    print("음수")


num=[1,2,3,4,5]
if 3 in num:
    print("항목 3이 존재")
else:
    print("항목 3이 존재하지 않음")


code=1203
if code in [1203,1250,1275,1290]:
    if code==1203:
        subj="파이썬 프로그래밍"
    elif code==1250:
        subj="java"
    elif code==1275:
        subj="web"
    elif code==1290:
        subj="database"
else:
    subj="해당 강좌 없음"
print(f"과목명: {subj}")


####################################
# for문
for i in range(5):
    print(i+1, end="")

for i in range(1,5,1):
    print(i)

sum=0
for i in range(1,11,1):
    sum=sum+i
print("1에서 10까지 자연수의 합=%d" %sum)

sum=0
num=int(input("어떤수?"))
for i in range(1,num+1,1):
    sum=sum+i
print("1에서 num까지 자연수의 합= %d" %sum)


for i in range(1,6,1):
    num=int(input("어떤 수:"))
    if num%2==1:
        print("%d는 홀수입니다." %num)
    else: 
        print("%d는 짝수입니다." %num)


count_odd=0
count_even=0
for i in range(1,6,1):
    num=int(input("어떤 수:"))
    if num%2==1:
        print("%d는 홀수입니다." %num)
        count_odd=count_odd+1  
    else:
        print("%d는 짝수입니다." %num)
        count_even=count_even+1
print("홀수개수: %d" %count_odd)
print("짝수개수: %d" %count_even)


count=0
grade=[90,80,78,85,95]
for i in grade:
    if i>=90:
        print("{}번 학생 {}점: 장학금 대상".format(count,i))
    count=count+1

cnt=0
while cnt<5:
    cnt=cnt+1
    print(cnt)






