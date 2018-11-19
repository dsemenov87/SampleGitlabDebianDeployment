## Staging Deploy Infrastructure

Clone this repository to local directory.

### GitLab Dotnet Debian Runner

```bash
sudo cp -r ./gitlab-runner /etc/
sudo chown -R backend:backend /etc/gitlab-runner
cd /etc/gitlab-runner
docker-compose up -d
```

### Create dotnet service from template

```bash
/etc/gitlab-runner
```