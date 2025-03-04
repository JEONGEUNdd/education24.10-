from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
import time

def test_selenium():
    chrome_options = Options()
    chrome_options.add_argument("--headless")
    service = Service("C:\\Users\\enjoy\\python_202412\\chromedriver.exe")
    driver = webdriver.Chrome(service=service, options=chrome_options)

    try:
        driver.get("https://map.kakao.com/")
        time.sleep(5)  # 페이지 로딩 대기
        print("Selenium 크롬 드라이버 실행 성공")
    except Exception as e:
        print(f"크롬 드라이버 에러: {e}")
    finally:
        driver.quit()

test_selenium()