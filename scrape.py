from selenium import webdriver
from selenium.webdriver.common.by import By
import json

def scrape_data():
    driver = webdriver.Firefox()
    driver.get("https://mlh.io/seasons/2024/events")
    links = driver.find_elements(By.CLASS_NAME, "event-link")
    for link in links:
        print(link.get_attribute("href"))
scrape_data()