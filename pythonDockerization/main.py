import flask
import requests
import yaml

app = flask.Flask(__name__)
app.config["DEBUG"] = True

with open("config.yaml", "r") as ymlfile:
    cfg = yaml.load(ymlfile)

print(cfg["url"]["host"])

@app.route('/health', methods=['GET'])
def health():
    return "Healthy"


@app.route('/data', methods=['GET'])
def getData():
    response = requests.get(cfg["url"]["prefix"] + "://" + cfg["url"]["host"] + ":" + cfg["url"]["port"] + "/" + cfg["url"]["path"])
    print(response.content)
    return response.content

app.run(host='0.0.0.0')


