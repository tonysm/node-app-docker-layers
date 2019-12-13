This app is a demonstration of the Docker Image layering. If you checkout the first commit and run `make build` you should get the first version of the Docker image built. Then, change to the second commit and run `make build` again, you should see an output pretty much like this:

```bash
make build
docker build -t tonysm/node-app-docker:2.0.0 .
Sending build context to Docker daemon  2.065MB
Step 1/8 : FROM node:13.3.0
 ---> 2af77b226ea7
Step 2/8 : WORKDIR /app
 ---> Using cache
 ---> 07c5be8e9cde
Step 3/8 : RUN apt-get update && apt-get install -y git
 ---> Using cache
 ---> 9285fc2a80c2
Step 4/8 : COPY package.json package-lock.json /app/
 ---> Using cache
 ---> b5fb084d0c2a
Step 5/8 : RUN npm ci
 ---> Using cache
 ---> 19482a7d821a
Step 6/8 : COPY . /app
 ---> e1e469c7e35c
Step 7/8 : EXPOSE 3000
 ---> Running in 3f19795b571f
Removing intermediate container 3f19795b571f
 ---> ad14d5378b2d
Step 8/8 : CMD ["npm", "run", "serve"]
 ---> Running in dfa2ff542a49
Removing intermediate container dfa2ff542a49
 ---> 280c53c0f03d
Successfully built 280c53c0f03d
Successfully tagged tonysm/node-app-docker:2.0.0
```

Notice the _Using cache_ messages. That means that it didn't have to rebuild everything from scratch, only the steps from 6/8 and below are rebuilt.

Your Dockerfile steps should follow something like:

- OS-level dependencies installation;
- App-level dependencies installtion;
- Copy source code to container.

Usually, more often than not you are releasing only source code changes. If you added a new app dependency, you probably added source code that uses it, so rebuilding from the NPM steps here would be ok. If you added any OS-level dependency, chances are that's because you needed it for some kind of package at the app-level dependency, and you also had to change source code, so rebuilding from the top makes sense.
