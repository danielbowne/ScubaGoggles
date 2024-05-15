# Use an official Ubuntu runtime as a parent image
FROM ubuntu:22.04

# Set the working directory to /app
WORKDIR /app

# Install necessary packages (git, curl, python3, pip)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    python3 \
    python3-pip

# Clone the ScubaGoggles repository
RUN git clone https://github.com/danielbowne/ScubaGoggles.git

# Change to the ScubaGoggles directory
WORKDIR /app/ScubaGoggles

# Install any necessary dependencies and the scubagoggles package
RUN pip3 install --no-cache-dir .

# Download the OPA executable
RUN curl -L -o opa_linux_amd64_static https://openpolicyagent.org/downloads/v0.59.0/opa_linux_amd64_static

# Set permissions on the OPA executable
RUN chmod +x opa_linux_amd64_static

# Copy your credentials file to the container
COPY ./credentials.json ./credentials.json

# Set the command to run the scubagoggles command with desired options
CMD ["scubagoggles", "gws", "--omitsudo", "--subjectemail", "daniel.bowne@aquia.io", "--quiet", "--outputpath", "/app/ScubaGoggles/output"]