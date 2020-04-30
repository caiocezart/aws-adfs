FROM python:3.7-slim AS compile-image

RUN apt-get update
RUN apt-get install -y --no-install-recommends build-essential gcc libxml2-dev libxslt-dev libffi-dev libssl-dev krb5-multidev

RUN python -m venv /opt/venv
# Make sure we use the virtualenv:
ENV PATH="/opt/venv/bin:$PATH"

COPY requirements.txt .
RUN pip install -r requirements.txt

FROM python:3.7-slim-stretch AS build-image
COPY --from=compile-image /opt/venv /opt/venv
# Make sure we use the virtualenv:
ENV PATH="/opt/venv/bin:$PATH"

ENTRYPOINT ["aws-adfs"]