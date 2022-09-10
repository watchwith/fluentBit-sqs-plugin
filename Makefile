all:
	go build -buildmode=c-shared -o out_sqs.so .
	
fast:
	go build out_sqs.go

DOCKER_REPO := $(shell aws ssm get-parameters --names /aws/service/aws-for-fluent-bit/stable --region us-east-1 | jq -r '.Parameters[].Value' | sed 's/.*\///' | cut -d: -f1 )
DOCKER_VERSION := $(shell aws ssm get-parameters --names /aws/service/aws-for-fluent-bit/stable --region us-east-1 | jq -r '.Parameters[].Value' | sed 's/.*\///' | cut -d: -f2 )
WW_VERSION := $(shell cat WATCHWITH_CONTAINER_VERSION)

docker:
	DOCKER_BUILDKIT=1 docker build --build-arg FLUENT_BIT_REPO=$(DOCKER_REPO):$(DOCKER_VERSION) -t watchwith/$(DOCKER_REPO)-sqs:$(WW_VERSION) . && \
	docker push watchwith/$(DOCKER_REPO)-sqs:$(WW_VERSION) && \
	docker tag watchwith/$(DOCKER_REPO)-sqs:$(WW_VERSION) watchwith/$(DOCKER_REPO)-sqs:latest && \
	docker push watchwith/$(DOCKER_REPO)-sqs:latest

clean:
	rm -rf *.so *.h *~
	docker rmi -f watchwith/$(DOCKER_REPO)-sqs:$(WW_VERSION)
	docker rmi -f watchwith/$(DOCKER_REPO)-sqs:latest
