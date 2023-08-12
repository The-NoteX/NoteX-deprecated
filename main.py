from fastapi import FastAPI
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
import json
from fastapi.encoders import jsonable_encoder
from fastapi.responses import JSONResponse
# imports required for the model
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.svm import LinearSVC
from sklearn.metrics import accuracy_score
from sklearn.feature_extraction.text import TfidfVectorizer

app = FastAPI()

#Model training code
dataframe = pd.read_csv("spamham.csv")
final_df = dataframe.where((pd.notnull(dataframe)), '')
final_df.loc[final_df["Category"] == "ham", "Category",] = 1
final_df.loc[final_df["Category"] == "spam", "Category",] = 0
final_df_x = final_df["Message"]
final_df_y = final_df["Category"]
x_train, x_test, y_train, y_test = train_test_split(final_df_x, final_df_y, train_size = 0.8, test_size = 0.2, random_state = 42)
vectorizer = TfidfVectorizer(min_df = 1, stop_words = "english", lowercase = True)
x_train_vectorized = vectorizer.fit_transform(x_train)
x_test_vectorized = vectorizer.transform(x_test)
y_train_int = y_train.astype('int')
model = LinearSVC()
model.fit(x_train_vectorized, y_train_int)

hackathons = []

@app.get("/hackathons")
def root():
    try:
        with open("hackathons.json","r") as file:
            hackathons_json = json.load(file)
        return hackathons_json
    except Exception as e:
        return "Emcees couldn't emcee"

@app.get("/model/")
def spamClass(q:str = None):
    inp = pd.Series([q])

    vec_str = vectorizer.transform(inp)
    prediction = model.predict(vec_str)

    prediction_int = int(prediction[0])

    return {"predict":prediction_int}