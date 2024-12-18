#!/bin/bash

# Start Ollama in the background.
ollama serve &


# Pause for Ollama to start.
sleep 5

echo "🔴 Retrieve LLAMA3 model..."
ollama pull llama3.1
echo "🟢 Done!"



