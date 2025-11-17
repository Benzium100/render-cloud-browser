# Base image with Playwright + Chromium
FROM mcr.microsoft.com/playwright:v1.44.0-jammy

# Install minimal dependencies
RUN apt-get update && apt-get install -y \
    xvfb curl sudo

# Create a non-root user
RUN useradd -m renderuser && echo "renderuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER renderuser
WORKDIR /home/renderuser

# Install Chromium browser
RUN playwright install --with-deps chromium

# Expose port (optional if needed for web)
EXPOSE 8080

# Start Chromium in headless mode with virtual display
CMD ["xvfb-run", "--server-args=-screen 0 1920x1080x24", "chromium", "--no-sandbox"]
