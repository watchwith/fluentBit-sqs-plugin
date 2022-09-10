# Watchwith Fluent Bit SQS compatible Firelen Container

## Build and install in Docker hub
This will pull the most recent AWS maintained fluent-bit container, build and add the sqs module, and push the container to dockerhub to be used by `terraform-application`.
```shell
make docker
```

## Clean up
```shell
make clean
```

## Version
Bump `WATCHWITH_CONTAINER_VERSION` when building a new image.