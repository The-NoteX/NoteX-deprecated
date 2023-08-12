from selenium import webdriver
from selenium.webdriver.common.by import By
import json
import time

def scrape_data():
    driver = webdriver.Firefox()
    driver.get("https://mlh.io/seasons/2024/events")
    links = driver.find_elements(By.CLASS_NAME, "event-link") # Fetching links of hackathon websites
    images = driver.find_elements(By.CSS_SELECTOR, ".image-wrap img") # Fetching images of hackathons
    names = driver.find_elements(By.CLASS_NAME, "event-name") # Fetching names of hackathons
    dates = driver.find_elements(By.CLASS_NAME, "event-date") # Fetching dates
    locs = driver.find_elements(By.CLASS_NAME, "event-location") # Fetching location
    modes = driver.find_elements(By.CLASS_NAME,"event-hybrid-notes") # Fetching modes
    hackathons = []
    for i in range(len(links)):
        hackathon = {
            "name": names[i].text,
            "link": links[i].get_attribute("href"),
            "image": images[i].get_attribute("src"),
            "date": dates[i].text,
            "location": locs[i].text,
            "mode":modes[i].text
        }
        hackathons.append(hackathon)
    with open("hackathons.json","w") as f:
        json.dump(hackathons,f,indent=4); 
    driver.quit()

# scrape_data()
while(1):
    scrape_data()
    time.sleep(86400)