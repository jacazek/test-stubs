# Getting started

This project generates a docker image what can be used to expedite writing and testing of contracts and stubs.

Container instances started from the image generated by this project will monitor
a specified directory for contract file additions, deletions, and modifications. When a file is delete,
added, or modified, the container will generate new stubs from the contract files and publish
those stubs using the wiremock service listening on the specified port.

## Building the image
To build the docker image run `docker build --tag stub-tester .` from within the root directory of this project.
You can substitute any `tag` value you desire to name the image that is generated.
In this example we call the image `stub-tester`.

## Running the container
To test contracts locally, run a container instance for the `stub-tester` image specifying a port and contract directory.

For example, if you have:
1. Contracts locally in directory `/home/user/DEV/project/contracts`.
2. Desire to run stubs on port `40001`

Then you would run command
```
docker run --rm \
  --name teststubs \
  -p 40001:8080 \
  -v /home/user/DEV/project/contracts:/home/contracts \
  stub-tester
```

The command will start a container named `teststubs` running a wiremock service listening on port 40001 
and watching contracts in the local directory `/home/user/DEV/project/contracts` that, when stopped, will
remove the container instance.

## Stopping the container
Run the command `docker container stop teststubs`.