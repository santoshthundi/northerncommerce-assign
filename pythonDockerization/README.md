Please copy all the files in one folder

1. Config.yaml
2. main.py
3. Dockerfile

- Run the command to create image, please ensure docker is installed and service is running

docker build -t viapythonimage . (. represents the current directory)

- Run following command to create container using the image

 docker run -t -i -d -p 5000:5000 viapythonimage

- Access the application url on http://<instanceip>:5000/health
In my case it is http://18.217.102.184:5000/health

Issues faced and resolutions:

1. Application was running inside the container but not from outside
  Inside the container http://localhost:5000 was responding but not from outside

  REsolution: Application was only allowing connection from 127.0.0.1 (localhost), I modified the main.py to run on 0.0.0.0, this allowed connections
from outside container


2. Config.yaml was not reachable
  
REsoultion: I modified the main.py for the absolute path of file, as per the location I am copying to from Dockerfile


3. InstanceIP was not reachable on port 5000

Resolution: It was blocked by AWS security group and had to allow port 5000 from myIP

4. Python code was not running due to missing prereq packages

Resolution: Added the relevant code in Dockerfile where in it install the packages before python code execution.
