FROM gcr.io/dataflow-templates-base/python3-template-launcher-base:latest as template_launcher
FROM python:3.8-slim

COPY --from=template_launcher /opt/google/dataflow/python_template_launcher /opt/google/dataflow/python_template_launcher

ARG WORKDIR=/dataflow/template
RUN mkdir -p ${WORKDIR}
WORKDIR ${WORKDIR}

COPY . ${WORKDIR}
RUN apt-get update \
    && apt-get install -y libffi-dev \
    && rm -rf /var/lib/apt/lists/* \
    && pip install --no-cache-dir upgrade pip \
    && pip3 download --no-cache-dir -r ${WORKDIR}/requirements.txt \
    && pip3 install --no-cache-dir -r ${WORKDIR}/requirements.txt

ENV FLEX_TEMPLATE_PYTHON_PY_FILE="${WORKDIR}/src/pipeline.py"

ENTRYPOINT ["/opt/google/dataflow/python_template_launcher"]