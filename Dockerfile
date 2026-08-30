# Use a lightweight Alpine Linux image with Node.js 24 (OmniRoute requirement)
FROM node:24-alpine

# Set the working directory inside the container
WORKDIR /app

# Install the official OmniRoute package globally
# This pulls the latest compiled version of https://github.com/diegosouzapw/OmniRoute
RUN npm install -g omniroute

# Koyeb needs the application to bind to 0.0.0.0 to route external traffic properly
ENV HOST=0.0.0.0
ENV PORT=8000

# Expose port 8000 for Koyeb's internal network routing
EXPOSE 8000

# Start the OmniRoute AI gateway with explicit host and port flags to guarantee binding
CMD ["omniroute", "--port", "8000", "--host", "0.0.0.0"]
