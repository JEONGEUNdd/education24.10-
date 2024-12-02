import csv
def write_books(data, filename):
    with open(filename, 'w', newline='', encoding='utf-8') as f:
        writer = csv.writer(f)
        writer.writerow(['제목', '저자', '출판 연도'])  # 헤더 작성
        writer.writerows(data)

def read_books(filename):
    with open(filename, 'r', encoding='utf-8') as f:
        reader = csv.reader(f)
        return [row for row in reader]

def write_shopping_list(data, filename):
    with open(filename, 'w', newline='', encoding='utf-8') as f:
        writer = csv.writer(f)
        writer.writerow(['상품명', '수량', '가격'])  # 헤더 작성
        writer.writerows(data)

def read_shopping_list(filename):
    with open(filename, 'r', encoding='utf-8') as f:
        reader = csv.reader(f)
        return [row for row in reader]