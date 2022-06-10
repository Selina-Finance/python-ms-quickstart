#!/usr/bin/python

import os
from flask import Flask, jsonify

app = Flask(__name__)

@app.get('/health')
def health():
    return jsonify(status="working")

@app.get("/")
def read_root():
    return jsonify(hello="world")

@app.get("/env")
def read_env():
    return jsonify(
      POSTGRES_DB=os.environ.get("POSTGRES_DB"),
      POSTGRES_USER=os.environ.get("POSTGRES_USER"),
      ENVIRONMENT=os.environ.get("ENVIRONMENT")
    )

