FROM ruby:3.3.0

ENV LC_ALL=C.UTF-8

RUN \
  curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
  curl -sS http://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
      mariadb-client \
      nodejs \
      yarn \
      unzip \
      vim \
      cron \
      imagemagick && \
  rm -rf /var/lib/apt/lists/*

ENV TERRAFORM_VERSION=0.11.8
RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends \
      unzip && \
  rm -rf /var/lib/apt/lists/* && \
  curl -fsL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip > terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
  unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin && \
  rm -f terraform_${TERRAFORM_VERSION}_linux_amd64.zip

ENV TERRAFORM_DOC_VERSION=0.3.0
RUN \
  curl -fsL https://github.com/segmentio/terraform-docs/releases/download/v0.3.0/terraform-docs_linux_amd64 > /usr/local/bin/terraform-docs && \
  chmod a+x /usr/local/bin/terraform-docs

ENV ASUME_ROLE_VERSION=0.3.2
RUN \
  curl -fsL https://github.com/remind101/assume-role/releases/download/0.3.2/assume-role-Linux > /usr/local/bin/assume-role && \
  chmod a+x /usr/local/bin/assume-role

# Also support arm64 and other platforms (M1 chip)
# RUN WK_VERSION=0.12.6-1 \
#     && ARCH=$(dpkg --print-architecture) \
#     && CODENAME=$(. /etc/os-release; echo $VERSION_CODENAME) \
#     && curl -LSfso wkhtmltopdf.deb https://github.com/wkhtmltopdf/packaging/releases/download/$WK_VERSION/wkhtmltox_$WK_VERSION.${CODENAME}_$ARCH.deb \
#     && apt-get -q update \
#     && apt-get install -qy ./wkhtmltopdf.deb \
#     && rm -r wkhtmltopdf.deb /var/lib/apt/lists/* \
#     && update-alternatives --install /usr/bin/wkhtmltopdf wkhtmltopdf /usr/local/bin/wkhtmltopdf 10

RUN apt-get update
RUN apt-get install -y ghostscript