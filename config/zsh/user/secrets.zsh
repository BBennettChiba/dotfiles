# Secure API key retrieval with better error handling
if command -v pass >/dev/null 2>&1; then
    if OPENAI_API_KEY_VALUE="$(pass show openAIToken 2>/dev/null)"; then
        export OPENAI_API_KEY="${OPENAI_API_KEY_VALUE}"
    else
        echo "Warning: Failed to retrieve OpenAI API token from pass" >&2
    fi
    unset OPENAI_API_KEY_VALUE

    if GEMINI_API_KEY_VALUE="$(pass show geminiApiKey 2>/dev/null)"; then
        export GEMINI_API_KEY="${GEMINI_API_KEY_VALUE}"
    else
        echo "Warning: Failed to retrieve Gemini API key from pass" >&2
    fi
    unset GEMINI_API_KEY_VALUE
else
    echo "Warning: 'pass' command not found. Skipping API key setup." >&2
fi
