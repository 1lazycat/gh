FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV RUNNER_VERSION=2.322.0

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    tar \
    jq \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3-dev \
    python3-pip \
    git \
    sudo \
    libicu-dev \
    && rm -rf /var/lib/apt/lists/*

# Create a user to run the GitHub runner
RUN useradd -m github && \
    usermod -aG sudo github && \
    echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set up the runner directory
WORKDIR /home/github/actions-runner

# Download the GitHub runner
RUN curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    echo "b13b784808359f31bc79b08a191f5f83757852957dd8fe3dbfcc38202ccf5768  actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz" | shasum -a 256 -c && \
    tar xzf actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    rm actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz && \
    chown -R github:github /home/github

# Install .NET Core dependencies
RUN sudo ./bin/installdependencies.sh

# Switch to the github user
USER github

# Create an entrypoint script to configure and start the runner
COPY entrypoint.sh .
RUN sudo chmod +x ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]