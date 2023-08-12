from fastapi import FastAPI
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
import json
from fastapi.encoders import jsonable_encoder
from fastapi.responses import JSONResponse

app = FastAPI()

hackathons = []

@app.get("/hackathons")
def root():
    try:
        with open("hackathons.json","r") as file:
            hackathons_json = json.load(file)
        return hackathons_json
    except Exception as e:
        return "Emcees couldn't emcee"