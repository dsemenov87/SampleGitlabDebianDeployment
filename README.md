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

Create NuGet template package:

```bash
cd ./dotnet-template
nuget pack ./Modulbank.ServiceTemplate.CSharp.nuspec
nuget push ./Modulbank.ServiceTemplate.CSharp.1.0.0.nupkg -Source http://172.21.13.86/nuget
```

Install NuGet template:
```bash
cd ./dotnet-template

```