FROM solarjsoc/selenium:vnc-base-1.0.0-20220518

USER root

RUN apt-get update -qqy \
  && apt-get -qqy install \
    git \
    golang \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Installing playwright browsers with dependencies
RUN go get github.com/playwright-community/playwright-go
RUN go run github.com/playwright-community/playwright-go/cmd/playwright install --with-deps