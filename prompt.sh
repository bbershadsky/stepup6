#!/bin/bash

# Define the payload file and output file
payload_file="Vb4Pn-zsFGc.json"
output_file="output.json"

# Generate the prompt
prompt_prefix="Extract the most useful parts of the video based on the subtitles provided. Select segments that convey crucial information or are the most relevant to the topic. Here are the subtitles:"

# Read the payload
subtitles=$(cat "$payload_file")
payload=$(jq -n --arg prompt "$prompt_prefix\n\n$subtitles" '{model: "openhermes", prompt: $prompt, stream: false}')

# Make API request and save the output to the JSON file
response=$(curl -s -X POST http://localhost:11434/api/generate -d "$payload")

# Error handling and verification
if echo "$response" | jq empty; then
    echo "$response" >"$output_file"
    echo "Response saved to $output_file"
else
    echo "Error: Response is not valid JSON"
fi
