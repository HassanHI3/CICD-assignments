from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "App is running 🚀"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)


# def add(a, b):
#     return a + b


# def subtract(a, b):
#     return a - b

