FROM gcr.io/dataflow-templates-base/python3-template-launcher-base:latest as template_launcher
FROM python:3.6

COPY --from=template_launcher /opt/google/dataflow/python_template_launcher /opt/google/dataflow/python_template_launcher

ARG WORKDIR=/dataflow/template
RUN mkdir -p ${WORKDIR}
WORKDIR ${WORKDIR}

COPY . ${WORKDIR}
RUN pip3 install -r ${WORKDIR}/requirements.txt

ENV FLEX_TEMPLATE_PYTHON_PY_FILE="${WORKDIR}/src/pipeline.py"

ENTRYPOINT ["/opt/google/dataflow/python_template_launcher"]