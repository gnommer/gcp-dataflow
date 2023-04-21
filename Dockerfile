FROM gcr.io/dataflow-templates-base/python3-template-launcher-base:latest as template_launcher
FROM python:3.6-slim

COPY --from=template_launcher /opt/google/dataflow/python_template_launcher /opt/google/dataflow/python_template_launcher

ARG WORKDIR=/dataflow/template
RUN mkdir -p ${WORKDIR}
WORKDIR ${WORKDIR}

COPY . ${WORKDIR}

ENV FLEX_TEMPLATE_PYTHON_PY_FILE="${WORKDIR}/src/pipeline.py"

ENTRYPOINT ["/opt/google/dataflow/python_template_launcher"]