#!/bin/bash

echo -n "AWS for Fluent Bit Container Image Version "
cat /AWS_FOR_FLUENT_BIT_VERSION
echo
echo -n "Watchwith for Fluent Bit Container Image Version "
cat /WATCHWITH_CONTAINER_VERSION
echo
exec /fluent-bit/bin/fluent-bit -e /fluent-bit/firehose.so -e /fluent-bit/cloudwatch.so -e /fluent-bit/kinesis.so -e /fluent-bit/out_sqs.so -c /fluent-bit/etc/fluent-bit.conf
