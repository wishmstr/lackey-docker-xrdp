![alt text](<docs/CleanShot 2024-07-03 at 21.06.28.png>)

# Development

## Commands

| Command      | Description                                    |
| ------------ | ---------------------------------------------- |
| `make build` | Build the docker image.                        |
| `make up`    | Start the docker container.                    |
| `make run`   | Run the docker image standalone.               |
| `make shell` | Open a shell in the already running container. |

## Development

To save time, you can use multiple `make` targets to re-build the container and then start it:

```bash
make build up         # Build the container using the cache and start it.
make build/nocache up # Ignore cache and rebuild the container and start it.
```

Get glx information:

```bash
DISPLAY=:1 glxinfo
```