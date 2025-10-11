# PocketBase Docker Image (Unofficial)

> **DISCLAIMER**: This is an **unofficial** Docker image for PocketBase. This project is not affiliated with, endorsed by, or connected to the official PocketBase project or its maintainers. Use at your own risk.

## About

This repository provides a Docker image for [PocketBase](https://pocketbase.io/), an open-source backend consisting of embedded database (SQLite) with realtime subscriptions, built-in auth management, convenient dashboard UI and simple REST-ish API.

## Warning

⚠️ **Use at your own risk** ⚠️

- This is an **unofficial** community-maintained Docker image
- Not officially supported by the PocketBase team
- May not receive immediate updates when new PocketBase versions are released
- No warranty or guarantees provided
- Always backup your data regularly

For production use, consider the [official PocketBase installation methods](https://pocketbase.io/docs/).

## Quick Start

### Using Docker Run

```bash
docker run -d \
  --name pocketbase \
  -p 8080:8080 \
  -v pocketbase_data:/pb/pb_data \
  ghcr.io/NATroutter/pocketbase:latest
```

### Using Docker Compose

```yaml
services:
  pocketbase:
    image: ghcr.io/NATroutter/pocketbase:latest
    container_name: pocketbase
    restart: unless-stopped
    ports:
      - "8080:8080"
    volumes:
      - ./data:/pb_data
    environment:
      - PB_ENCRYPTION=your-32-character-encryption-key
      - TZ=UTC
```

Then run:

```bash
docker-compose up -d
```

## Accessing PocketBase

Once the container is running, you can access:
- Admin UI: http://localhost:8080/_/
- API: http://localhost:8080/api/

## Volumes

The Docker image supports the following volume mounts:

- `/pb_data` - **Required.** Contains your SQLite database, uploaded files, and application logs. **Always mount this volume to persist your data.** Without this volume, all data will be lost when the container is removed.

- `/pb_migrations` - **Optional.** Directory for database migration files. Mount this if you want to manage database schema changes through migration files. This allows you to version control your database structure.

- `/pb_public` - **Optional.** Serves static files directly from PocketBase. Any files placed here will be publicly accessible. Useful for hosting frontend applications or static assets alongside your API.

- `/pb_hooks` - **Optional.** Directory for JavaScript/Go hooks that extend PocketBase functionality. Mount this to add custom business logic, validation rules, or event handlers that execute during specific PocketBase operations.

## Environment Variables

You can customize the PocketBase instance using environment variables:

- `TZ` - **Optional.** Timezone (default: UTC)
- `PB_ENCRYPTION` - **Required for production.** A 32-character random string used to encrypt sensitive data in the database (like user passwords, OAuth tokens, etc.). **Important:** Once set, do not change this value or you won't be able to decrypt existing data. Generate a secure random string and keep it safe.

  Generate a random 32-character key:
  ```bash
  # Linux/macOS
  openssl rand -base64 32 | head -c 32

  # Windows (PowerShell)
  -join ((65..90) + (97..122) + (48..57) | Get-Random -Count 32 | % {[char]$_})
  ```

## Building Locally

To build the image yourself:

```bash
git clone https://github.com/NATroutter/PokectBase-Dockerized.git
cd PokectBase-Dockerized
docker build -t pocketbase:local .
```

## Updating

To update to the latest version:

```bash
docker pull ghcr.io/NATroutter/pocketbase:latest
docker-compose down
docker-compose up -d
```

**Important**: Always backup your `pb_data` directory before updating.

## Backup

Always backup your data regularly:

```bash
# Backup the entire data directory
docker cp pocketbase:/pb/pb_data ./backup_$(date +%Y%m%d)
```

Or if using docker-compose with local volume:

```bash
# Stop the container
docker-compose down

# Backup the data directory
tar -czf pb_data_backup_$(date +%Y%m%d).tar.gz ./pb_data

# Restart the container
docker-compose up -d
```

## Support

This is a community project. For issues related to:
- **Docker image**: Open an issue in this repository
- **PocketBase itself**: Visit the [official PocketBase repository](https://github.com/pocketbase/pocketbase)

## License

This Docker implementation is provided as-is. PocketBase itself is licensed under MIT License.

## Official Resources

- [PocketBase Official Website](https://pocketbase.io/)
- [PocketBase Documentation](https://pocketbase.io/docs/)
- [PocketBase GitHub](https://github.com/pocketbase/pocketbase)

---

**Remember**: This is an unofficial Docker image. Always refer to the [official PocketBase documentation](https://pocketbase.io/docs/) for the most up-to-date and supported installation methods.
