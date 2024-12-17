#!/usr/bin/env bash
ollama serve &
ollama list

model_name="llama3.1"
ollama pull $model_name
