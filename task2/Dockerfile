FROM ubuntu

ARG TF_VERSION

RUN apt update -y && apt full-upgrade -y && apt install curl unzip apache2-utils -y
RUN apt clean &&rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip -o terraform.zip \
    && unzip terraform.zip \
    && mv terraform /usr/local/bin/ \
    && rm terraform.zip

RUN curl -fsSL https://github.com/goss-org/goss/releases/latest/download/goss-linux-amd64 -o /usr/local/bin/goss \
    && chmod +x /usr/local/bin/goss

RUN curl -fsSL https://github.com/aquasecurity/tfsec/releases/latest/download/tfsec-linux-amd64 -o /usr/local/bin/tfsec \
    && chmod +x /usr/local/bin/tfsec

RUN mkdir /app
WORKDIR /app

ADD entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ADD test.sh /app/test.sh
RUN chmod +x /app/test.sh

ENTRYPOINT ["/app/entrypoint.sh"]
