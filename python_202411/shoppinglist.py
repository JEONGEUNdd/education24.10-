import os

def display_cart(items):
    print(f"\n▩  ({', '.join(items)})\n")

def clear_screen():
    os.system('cls' if os.name == 'nt' else 'clear')

def shopping_list():

    items = []
    main_func = True

    while True:

        if main_func:
            clear_screen()
            print("1: 항목 추가")
            print("2: 항목 삭제")
            print("3: 목록 보기")
            print("4: 프로그램 종료")
            display_cart(items)

            choice = input("원하는 작업을 선택하세요: ")
            if choice:
                main_func = False

        clear_screen()
        if choice == '1':
            print("<항목 추가>")
            display_cart(items)
            item = input("-> 추가 항목 (종료: 0)? ")
            if item == '0':
                main_func = True
                continue
            items.append(item)

        elif choice == '2':
            print("<항목 삭제>")
            display_cart(items)
            if items:
                item = input("-> 삭제 항목 (종료: 0)? ")
                if item == '0':
                    main_func = True
                    continue
                if item in items:
                    items.remove(item)
                else:
                    print("\n장바구니에 없는 항목입니다.")
                    input("\n아무키나 누르세요...")
            else:
                print("장바구니가 비어 있습니다.")
                input("\n아무키나 누르세요...")
                main_func = True
                continue

        elif choice == '3':
            print("<목록 보기>\n")

            if items:
                for i, item in enumerate(items, 1):
                    print(f"{i}. {item}")
                input("\n아무키나 누르세요...")
            else:
                print("장바구니가 비어 있습니다.")
                input("\n아무키나 누르세요...")

            main_func = True
            continue

        elif choice == '4':
            print("프로그램을 종료합니다.")
            break

shopping_list()