import apache_beam as beam
from apache_beam import Pipeline
from apache_beam.options.pipeline_options import PipelineOptions

if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument("--test", default='testing param', help='this is a testing param')
    args, kwargs = parser.parse_known_args()
    pipeline_options = PipelineOptions(streaming=False, save_main_session=True)
    with Pipeline(options=pipeline_options) as p:
        (
            p 
            | "Initalize" >> beam.Create([{"test": 1}, {"test": 2}, {"test": args}])
            | "Print" >> beam.Map(print)
        )
