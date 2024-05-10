# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory to /app
WORKDIR /app

# Install necessary packages (git, curl)
RUN apt-get update && apt-get install -y \
    git \
    curl

# Clone the ScubaGoggles repository
RUN git clone https://github.com/danielbowne/ScubaGoggles.git

# Change to the ScubaGoggles directory
WORKDIR /app/ScubaGoggles

# Install any necessary dependencies
# Assuming there is a requirements.txt in the ScubaGoggles repository
RUN pip install --no-cache-dir -r requirements.txt

# Replace '0.59.0' with your desired version
RUN python download_opa.py -v 0.59.0 -os linux

# Copy your credentials files to the container
# Ensure that credentials.json and any other sensitive files are not included in version control
COPY ./credentials.json ./credentials.json

# Setup command to run ScubaGoggles tool
CMD ["python", "scubagoggles", "gws --omitsudo --subjectemail daniel.bowne@aquia.io"]%