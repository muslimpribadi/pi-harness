FROM registry.fedoraproject.org/fedora:43

# Install system audit, networking, and native ROCm monitoring tools
RUN dnf update -y && dnf install -y \
    bash ca-certificates fd-find ripgrep procps-ng \
    sysstat iproute util-linux systemd jq git curl \
    python3 python3-pip nodejs npm \
    at-spi2-atk alsa-lib cups-libs fontconfig freetype \
    libX11 libXcomposite libXdamage libXext libXfixes \
    libXrandr libxcb libpng mesa-libgbm nspr nss zlib-ng-compat \   
    rocm-smi rocminfo && dnf clean all

# Define the default workspace
WORKDIR /workspace

# Install pi.dev agent strictly isolating the ignore-scripts workaround
RUN npm install -g --ignore-scripts @earendil-works/pi-coding-agent@latest

# Install Playwright normally allowing its native scripts to run
RUN npm install -g playwright@latest

# Download headless Chromium and install all required OS dependencies via DNF
RUN npx playwright install chromium

# Keep container alive to act as a terminal agent
CMD ["sleep", "infinity"]
