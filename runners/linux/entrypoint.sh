#!/bin/bash
set -e

GITHUB_URL=${GITHUB_URL:-https://github.com/leetbyte/sphere}
RUNNER_TOKEN=${RUNNER_TOKEN:-""}
RUNNER_NAME=${RUNNER_NAME:-$(hostname)}
RUNNER_WORKDIR=${RUNNER_WORKDIR:-"_work"}
RUNNER_GROUP=${RUNNER_GROUP:-"default"}
RUNNER_LABELS=${RUNNER_LABELS:-""}

if [ -z "$RUNNER_TOKEN" ]; then
    echo "Error: RUNNER_TOKEN is not set. Please provide a valid runner token."
    exit 1
fi

# Configure the runner
./config.sh \
    --url $GITHUB_URL \
    --token $RUNNER_TOKEN \
    --name $RUNNER_NAME \
    --work $RUNNER_WORKDIR \
    --runnergroup $RUNNER_GROUP \
    --labels $RUNNER_LABELS \
    --unattended

# Remove the token from the environment
unset RUNNER_TOKEN

# Start the runner
exec ./run.sh