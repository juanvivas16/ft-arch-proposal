FROM alpine

ARG TF_VERSION

RUN apk add --no-cache curl aws-cli unzip apache2-utils

RUN curl -fsSL https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip -o terraform.zip \
    && unzip terraform.zip \
    && mv terraform /usr/local/bin/ \
    && rm terraform.zip

RUN curl -fsSL https://github.com/goss-org/goss/releases/latest/download/goss-linux-amd64 -o /usr/local/bin/goss \
    && chmod +x /usr/local/bin/goss

RUN curl -fsSL https://github.com/aquasecurity/tfsec/releases/latest/download/tfsec-linux-amd64 -o /usr/local/bin/tfsec \
    && chmod +x /usr/local/bin/tfsec

RUN mkdir /app

ADD entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ADD simple-load-test.sh /app/test.sh
RUN chmod +x /app/test.sh

WORKDIR /app

ENTRYPOINT ["/app/entrypoint.sh"]
