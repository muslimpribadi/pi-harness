# 🚀 pi-harness for AMD Strix Halo

A containerized environment for running the pi coding agent with playwright headless chrome, specifically optimized for AMD Strix Halo hardware.

<div align="center">

[![][github-action-shield]][github-action-link]
[![][github-ghcr-shield]][github-ghcr-link]
[![][github-upstream-shield]][github-upstream-link]
[![][github-license-shield]][github-license-link]
<br>
[![][github-ghcr-downloads-shield]][github-ghcr-link]

[github-action-shield]: https://github.com/muslimpribadi/pi-harness/actions/workflows/build-and-push.yml/badge.svg
[github-ghcr-shield]: https://img.shields.io/badge/GHCR-Ready-blue?logo=docker
[github-upstream-shield]: https://img.shields.io/badge/Upstream-Pi-purple?logo=github
[github-license-shield]: https://img.shields.io/badge/License-MIT-green.svg
[github-ghcr-downloads-shield]: https://ghcr-badge.elias.eu.org/shield/muslimpribadi/pi-harness
[github-upstream-link]: https://github.com/earendil-works/pi
[github-license-link]: https://github.com/muslimpribadi/pi-harness/blob/main/LICENSE
[github-action-link]: https://github.com/muslimpribadi/pi-harness/actions
[github-ghcr-link]: https://github.com/muslimpribadi/pi-harness/pkgs/container/pi-harness

</div>

## 📖 Overview

`pi-harness` is a fully prepared image designed to replicate a rootless Fedora 43 server environment containing necessary AMD ROCm libraries.

* It includes GPU tooling, browser automation (Playwright), and essential system utilities.
* The setup enables the documentation writer agent to browse and verify the materials it authors, ensuring output accuracy before task completion.

## ✨ Key Features

* **Core Agent:** `@earendil-works/pi-coding-agent` (pi.dev).
* **Browser Automation:** Playwright + Headless Chromium.
* **GPU Monitoring:** ROCm tools (`rocm-smi`, `rocminfo`).
* **System Tools:** `jq`, `ripgrep`, `fd-find`, `sysstat`, `iproute2`, `procps-ng`.
* **Runtime:** Python 3, Node.js / npm on Fedora 43 (x86_64).
* **Automated CI/CD:** Syncs with the upstream `pi` project and automatically publishes to GHCR upon new releases.

## ⚡ Quick Start

Note: You can use `docker` or `podman` interchangeably for the commands below.

**1. Pull the container**

Directory: `/mnt/pi-harness/`

```bash
podman pull ghcr.io/muslimpribadi/pi-harness:latest

```

**2. Run the environment**

Directory: `/mnt/pi-harness/`

```bash
podman run -it --rm \
  -v /mnt/pi-harness/workspace:/workspace \
  -v /mnt/pi-harness/pi:/root/.pi \
  --name pi-agent \
  ghcr.io/muslimpribadi/pi-harness:latest

```

> [!NOTE]
> <details>
>   <summary>Optional 1 - GPU Passthrough Requirements</summary>
>   Use this if you want the agent to access GPU from the container
>
>   ```bash
>    --device /dev/kfd \
>    --device /dev/dri \
>    --security-opt label=disable \
>   ```
>
> </details>
>
> <details>
>   <summary>Optional 2 - Architecture-Specific Variables</summary>
>   Use this for strix halo `gfx1151` specific ROCm environment overrides
>
>   ```bash
>   -e HSA_OVERRIDE_GFX_VERSION=11.5.1 \
>   -e ROCR_VISIBLE_DEVICES=all \
>   ```
>
> </details>
> 
> <details>
>   <summary>Complete command:</summary>
>   ```bash
>   podman run -it --rm \
>   --device /dev/kfd \
>   --device /dev/dri \
>   --security-opt label=disable \
>   -e HSA_OVERRIDE_GFX_VERSION=11.5.1 \
>   -e ROCR_VISIBLE_DEVICES=all \
>   -v /mnt/pi-harness/workspace:/workspace:Z \
>   -v /mnt/pi-harness/pi:/root/.pi:Z \
>   --name pi-agent \
>   ghcr.io/muslimpribadi/pi-harness:latest
> ```
>
> </details>

**3. Launch the agent**

Execute the following from inside the running container to start the agent:

```bash
pi

# View available options
pi --help

```

## 🛠️ Build Locally

To build the image locally from source, execute the following:

Directory: `/mnt/pi-harness/src/`

```bash
podman build -t pi-harness .

```

## ⚙️ Configuration

### Volume Mounts

The following mount points are recommended to persist your workspaces and agent configurations safely outside the container:

| Host Path | Container Path | Purpose |
| --- | --- | --- |
| `/mnt/pi-harness/workspace` | `/workspace` | Your working directory for projects and generated docs |
| `/mnt/pi-harness/pi` | `/root/.pi` | Pi agent's global configuration and state |

## 🙌 Acknowledgements

* **Author:** [M.Pribadi](https://github.com/muslimpribadi) and [LUNA bot](https://github.com/luna-bot-agent).
* This project was assisted by **Qwen3.6 35B A3B** in its development and documentation.

```bibtex
@misc{qwen36_35b_a3b,
    title = {{Qwen3.6-35B-A3B}: Agentic Coding Power, Now Open to All},
    url = {https://qwen.ai/blog?id=qwen3.6-35b-a3b},
    author = {{Qwen Team}},
    month = {April},
    year = {2026}
}

```

## 📜 License

MIT License — see [LICENSE](https://www.google.com/search?q=LICENSE) for details.
