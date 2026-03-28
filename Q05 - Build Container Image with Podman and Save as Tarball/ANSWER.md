# Answer 5 – Build Container Image with Podman and Save as Tarball

## Using Podman

```bash
cd /root/app-source
podman build -t my-app:1.0 .
podman images | grep my-app
podman save -o /root/my-app.tar my-app:1.0
ls -lh /root/my-app.tar
```

## Using Docker (alternative)

```bash
cd /root/app-source
docker build -t my-app:1.0 .
docker save -o /root/my-app.tar my-app:1.0
ls -lh /root/my-app.tar
```
