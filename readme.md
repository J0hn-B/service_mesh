# Service Mesh PoC

Deploy Linkerd in a PoC project, in a simple way for demonstration purposes.  
Linkerd works by installing a set of ultralight, transparent proxies next to each service instance.

> Prerequisites: Docker

Following the instructions, a K3d cluster with one server and two agent nodes is created.  
After cluster creation ArgoCD is getting installed, fetching and configuring Google's [Online Boutique](https://github.com/GoogleCloudPlatform/microservices-demo) test project.

To continue:

- `git clone https://github.com/J0hn-B/_bootstrap.git`
- `cd ~/_bootstrap/`
- `chmod +x /scripts/*.sh`
- `cd /scripts`
- `./deploy.sh`  
  The script will provide all the information you need to access ArgoCD UI and the webapp.  
  Wait a couple of minutes for the app to deploy and sync.

  ![ArgoCD](/assets/1.png)

  > Tip: If you cant access the app at localhost:8000 or ArgoCD at localhost:8088, simply run the ./k3d_install.sh again. Port-forwards may drop connection after a while.

## Linkerd

1. Create certificate:

   > reference: (<https://gist.github.com/fntlnz/cf14feb5a46b2eda428e000157447309>)

   - `cd ~/_bootstrap`
   - `openssl genrsa -out rootCA.key 4096`
   - `openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 1024 -out rootCA.crt`

2. Install Linkerd CLI: <https://linkerd.io/2.10/getting-started/>

   - Add Linkerd to your path: `export PATH=$PATH:$HOME/.linkerd2/bin`

3. Install Linkerd to your cluster from CLI:

   - Create the Linkerd secret

     ```bash
     kubectl -n linkerd create secret tls linkerd-trust-anchor \
      --cert rootCA.crt \
      --key rootCA.key
     ```

   - Validate your Kubernetes cluster
     `linkerd check --pre`

   - Install Linkerd onto the cluster  
     `linkerd install | kubectl apply -f -`  
     `linkerd check`

4. Access Linkerd and add the application

   - Access dashboard  
     `linkerd dashboard &`

   - Add the app to Linkerd  
     `kubectl get -n default deploy -o yaml | linkerd inject - | kubectl apply -f -`

   - Validate mTLS for your app  
     `linkerd -n default edges deployment`

Clean up resources: `k3d cluster delete multiserver`
