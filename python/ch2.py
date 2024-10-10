#while문
cnt=0
while cnt<5:
    cnt=cnt+1
    print(cnt)

cnt=1
while cnt<=5:
    print(cnt)
    cnt=cnt+1

i=0
while True:
    i=i+1
    print(i)

i=0
while True:
    i=i+1
    if i<=3:
        print("파이썬 프로그래밍")
    else:
        break


#9단 구구단
gugu=9
i=0
while True:
    i=i+1
    if i<=9:
        print(f"{gugu}*{i}={gugu*i}")
    else:
        break

gugu=int(input("원하는 구구단:"))
i=0
while i<9:
    i=i+1
    print(f"{gugu}*{i}={gugu*i}")


for i in range(2):
    print("i=", i)
    for j in range(3):  # 'i' 대신 'j'로 수정
        print("\tj=", j) 

for i in range(1,10,1):
    for j in range(2,10,1):
        print(f"{j}*{i}={j*i}", end="\t")
    print()


for i in range(5):
    for j in range(5):
        if j<=i:
            print('*', end="")
    print()

for i in range(5):
    for j in range(5):
        if j>=i:
            print('*', end="")
    print()

for i in range(5):
    for j in range(5):
        if j<i:
            print(" ", end="")
        else:
            print("*", end="")

i=0
while i<10:
    i=i+1
    print(i)
    if i==5:
        break

for i in range(11):
    print(f"숫자:{i}")
    if i>3:
        break
    else:
        print(f"\t제곱근:{i*i}")

#홀수출력 while문
i=0
while i<10:
    i=i+1
    if i%2==0:
        continue  #건너뜀
    print(i)

#짝수출력 for문
for i in range(1,11,1):
    if i%2==1:
        continue
    print(i)

str="Python_Pragramming"
for i in str:
    if i=="_":    #문자열 _만났을때 건너뛰기
        continue
    print(i,end="")

flag=True   #소수인지 아닌지(약수가 2개인 숫자)2,3,5,7,11,13...
num=int(input("어떤수:"))
for i in range(2,num,1):
    if num%i==0:
        flag=False
        break
if flag==True:
    print(f"{num}은 소수입니다.")
else:
    print(f"{num}은 소수가 아닙니다.")

#튜플=행, 자료변경X

str=["a","b","c"]
str1=tuple(str)   #리스트에서 튜플로 저장
type(str1)

mixStr=(1,2,3,("a","b","c"))
type(mixStr)

flower=("율국화","채송화","봉숭화","맨드라미","해바라기")  #소괄호 사용해서 튜플임
listFlower=list(flower)
listFlower.append("민들레")    #튜플에서 항목추가 안되서 리스트로 바꾸고 항목추가
listFlower
listFlower[1]="장미"
listFlower
flower=tuple(listFlower)
type(flower)

num=(1,2,3,4,5,6,7,8,9,10)
num[:]
num[0:2]
num[-6:8]  

num=[12,15,8,4,9]
newNum=sorted(num)   #오름차순
newNum
newNum2=sorted(num,reverse=True)   #내림차순
newNum2
