ARG FLUENT_BIT_REPO
FROM golang:1.14 as gobuilder

WORKDIR /root

ENV GOOS=linux\
    GOARCH=amd64

COPY / /root/

RUN go build \
    -buildmode=c-shared \
    -o /out_sqs.so \
    .

ARG FLUENT_BIT_REPO
FROM public.ecr.aws/aws-observability/${FLUENT_BIT_REPO}

COPY --from=gobuilder /out_sqs.so /fluent-bit/
COPY --chmod=0755 entrypoint.sh /
COPY WATCHWITH_CONTAINER_VERSION /

EXPOSE 24224

ENTRYPOINT ["/entrypoint.sh"]