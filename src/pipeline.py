import apache_beam as beam
from apache_beam import Pipeline

with Pipeline() as p:
    (
        p 
        | "Initalize" >> beam.Create([{"test": 1}, {"test": 2}])
        | "Print" >> beam.Map(print)
    )
