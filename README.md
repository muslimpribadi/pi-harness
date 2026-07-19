# pi-harness

> A containerized environment for running the [pi coding agent](https://pi.dev) with playwright headless chrome ready on AMD Strix Halo hardware.

---

## Table of Contents

- [About](#about)
- [Pull the Image](#pull-the-image)
- [Why This Exists](#why-this-exists)
- [What's Inside](#whats-inside)
- [Quick Start](#quick-start)
- [Running pi Coding Agent](#running-pi-coding-agent)
- [Volume Mounts](#volume-mounts)
- [Acknowledgements](#acknowledgements)

---

## About

`pi-harness` is a Docker/Podman container that prepares everything needed to run the [pi.dev](https://pi.dev). It's built on **Fedora 43** and includes GPU tooling (AMD ROCm), browser automation (Playwright), and system utilities — all pre-configured and ready to go.

---

## Pull the Image

Skip building locally — just pull the pre-built image:

```bash
# Podman
podman pull ghcr.io/muslimpribadi/pi-harness:latest

# Or Docker
docker pull ghcr.io/muslimpribadi/pi-harness:latest
```

---

## Why This Exists

I use the [pi coding agent](https://github.com/earendil-works/pi) as a harness for my **documentation writer agent**. The documentation I'm generating covers the server hardware itself — an **AMD Strix Halo** machine — so the container needs to closely replicate that host environment. That's why this image is based on Fedora 43 with ROCm libraries included.

I also added **Playwright with Headless Chromium** so the agent can browse and verify the documentation it writes, ensuring accuracy before it's considered complete.

The container is designed for **Podman** (the native container runtime on Fedora), but runs perfectly fine in Docker too.

---

## What's Inside

| Category | Packages |
|----------|----------|
| **Core Agent** | `@earendil-works/pi-coding-agent` (pi.dev) |
| **Browser Automation** | Playwright + Headless Chromium |
| **GPU Monitoring** | ROCm tools (`rocm-smi`, `rocminfo`) |
| **System Tools** | `jq`, `ripgrep`, `fd-find`, `sysstat`, `iproute2`, `procps-ng` |
| **Runtime** | Python 3, Node.js / npm |
| **Base OS** | Fedora 43 (x86_64) |

---

## Quick Start

### Build the Image

```bash
# Podman (recommended on Fedora)
podman build -t pi-harness .

# Or Docker
docker build -t pi-harness .
```

### Run the Container

```bash
# Podman
podman run -it --rm \
  -v /mnt/pi-harness/workspace:/workspace \
  -v /mnt/pi-harness/pi:/root/.pi \
  --name pi-agent \
  pi-harness:latest

# Or Docker
docker run -it --rm \
  -v /mnt/pi-harness/workspace:/workspace \
  -v /mnt/pi-harness/pi:/root/.pi \
  --name pi-agent \
  pi-harness:latest
```

---

## Running pi coding agent

Once inside the container, launch pi:

```bash
# Start your pi coding agent
pi

# View available options
pi --help
```

---

## Volume Mounts

These mounts are recommended to persist your work and configuration:

| Host Path | Container Path | Purpose |
|-----------|----------------|---------|
| `/mnt/pi-harness/workspace` | `/workspace` | Your working directory for projects and generated docs |
| `/mnt/pi-harness/pi` | `/root/.pi` | Pi agent's global configuration and state |

---

## Author

- [M.Pribadi](https://github.com/muslimpribadi)
- [LUNA bot](https://github.com/luna-bot-agent)

## Release & Updates

This container is synced with the [pi](https://github.com/earendil-works/pi) project. Every time pi releases a new version, the image is rebuilt and pushed to `ghcr.io`. Pulling `:latest` always gives you the newest pi agent harness.

---

## Acknowledgements

This project was assisted by **Qwen3.6 35B A3B** in its development and documentation.

```bibtex
@misc{qwen36_35b_a3b,
    title = {{Qwen3.6-35B-A3B}: Agentic Coding Power, Now Open to All},
    url = {https://qwen.ai/blog?id=qwen3.6-35b-a3b},
    author = {{Qwen Team}},
    month = {April},
    year = {2026}
}
```

---

## License

MIT License — see [LICENSE](LICENSE) for details.
