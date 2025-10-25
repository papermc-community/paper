# Paper

Paper is a Minecraft game server based on Spigot, designed to greatly improve performance and offer more advanced features and API

---

🔗 You can find **Velocity** versions and builds [here](https://papermc.io/downloads/paper).

## 🧱 Build information
All images in this repository based on **Eclipse Temurin JRE (Alpine 3.22) and are built as lightweight, production-ready multi architecture images.

## Java Runtime Overview
| Minecraft Version | Java Version | Runtime Image                        | Architecture        | Notes                                                                     |
|-------------------|--------------|--------------------------------------|---------------------|---------------------------------------------------------------------------|
| <= 1.16.x         | JRE 12       | `eclipse-temurin:12-jre-alpine-3.22` | `amd64` only        | Legacy builds; require `-Dhttps.protocols=TLSv1.2` for TLS compatibility. |
| 1.17.x - 1.19.x   | JRE 17       | `eclipse-temurin:17-jre-alpine-3.22` | `amd64` only        | x                                                                         |
| 1.20.x            | JRE 21       | `eclipse-temurin:21-jre-alpine-3.22` | `amd64` and `arm64` | x                                                                         |
| > 1.21.x          | JRE 25       | `eclipse-temurin:25-jre-alpine-3.22` | `amd64` and `arm64` | x                                                                         |

💡 **Note:**
Older Paper builds (<= 1.16.x) may fail to download the vanilla server jar due to outdated TLS defaults in Java 12. To fix this, run with:
```bash
-e JAVA_TOOL_OPTIONS="-Dhttps.protocols=TLSv1.2"
```

## 🚀 Quick start

### 1. Run container:

```bash
docker run -dit \
  --name <container-name> \
  -p 25565:25565 \
  ghcr.io/papermc-community/paper:1.21.10-86
```

### 2. Attach to the console

⚠️ **Note:** Attaching to the console only works if the container was started in **interactive mode**, for example using the `-it` or `-dit` (with detached) flag.

You can attach to the running **Velocity** console with:
```bash
docker attach <container-name>
```
(and safely detach with: `CTRL + P, CTRL Q`)

### 3. See console logs

You can see the **Velocity** console logs with:
```bash
docker logs -f <container-name>
```
(detach with: `CTRL + C`)

### 4. Mount external folders
You can mount external folders or files into the container using the `-v` flag. The default working directory inside the container is `/app`.

For example, to mount your local `plugins` folder into the container:
```bash
docker run -dit \
  --name <container-name> \
  -p 25565:25565 \
  -v <path-to-your-plugins>:/app/plugins \
  ghcr.io/papermc-community/paper:1.21.10-86
```

💡 **Recommendation:**
For data persistence and easier configuration management, it's recommend to mount external folders such as:
- `/app/logs` - for logs.
- `/app/plugins` - for plugins.
- ... additional files or folders, like configurations and worlds.

## ⚙️ Environment variables
| Environment variables | Default                                      | Description                                                                   |
|-----------------------|----------------------------------------------|-------------------------------------------------------------------------------|
| `INTERNAL_PORT`       | 25565                                        | The internal TCP port **Velocity** listens on - also used by the healthcheck. |
| `JAVA_TOOL_OPTIONS`   | `"-Xms512m -Xmx1024m -Dfile.encoding=UTF-8"` | JVM runtime options.                                                          |

💡 **Recommendation:**
It's recommend to fine-tune `JAVA_TOOL_OPTIONS` based on your hardware and workload.
