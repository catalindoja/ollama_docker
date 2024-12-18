#!/bin/bash

# Start Ollama in the background.
ollama serve &

CUDA_VISIBLE_DEVICES=1 jupyter lab --no-browser --allow-root --ip=0.0.0.0 --port=8888
