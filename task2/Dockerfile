ARG TF_VERSION

FROM hashicorp/terraform:$TF_VERSION

RUN apk add --no-cache curl aws-cli

RUN mkdir /app

ADD entrypoint.sh /app/entrypoint.sh

WORKDIR /app

# ENTRYPOINT ["./entrypoint.sh"]
