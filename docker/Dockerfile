# Use a base image
FROM ubuntu:22.04

# Install the required dependencies
RUN apt-get update && apt-get install -y \
    curl iproute2 sshfs unzip less groff

# Install kubectl from the specified URL
RUN curl -LO "https://dl.k8s.io/release/v1.23.6/bin/linux/amd64/kubectl" \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl \
    && kubectl version --client

# Install AWS CLI from the specified URL
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install

# Clean up after installations
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/awscliv2.zip

# Set the default command to start a shell
CMD ["/bin/bash"]