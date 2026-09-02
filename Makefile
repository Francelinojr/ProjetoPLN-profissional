PYTHON ?= python3

.PHONY: run clean

run:
	$(PYTHON) src/pipeline_pln.py

clean:
	rm -rf cache results/generated __pycache__ src/__pycache__
