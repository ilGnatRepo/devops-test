minikube stop
# docker start registry
minikube start 
minikube ssh 'echo "192.168.31.107 registry.local" | sudo tee -a /etc/hosts'

kubectl get svc -n kube-system kube-dns | awk 'NR==2 {print $3}' | \
xargs -I {} minikube ssh 'sed "/nameserver/d" /etc/resolv.conf | sudo tee /etc/resolv.conf > /dev/null && \
echo "nameserver {}" | sudo tee -a /etc/resolv.conf'

# minikube start --driver=docker \
#   --container-runtime=docker \
#   --image-repository=registry.local:8000 \
#   --base-image="registry.local:8000/kicbase:v0.0.45" \
#   --insecure-registry="registry.local:8000" \
#   --cache-images=true \
#   --gpus=all \
#   --memory=6g \
#   --force 

# minikube addons enable nvidia-device-plugin --images="NvidiaDevicePlugin=nvidia/k8s-device-plugin:v0.16.2@sha256:e1c677f8f75152e642876d76e48f545ddec9bcccd8cbc4d0a133ff715fad6407"
# minikube addons enable ingress --images="KubeWebhookCertgenCreate=kube-webhook-certgen:v1.4.3@sha256:a529382f6a723d4fcb2cf83bd5a0fcf46b492760bda17a28348df87cd8925506,KubeWebhookCertgenPatch=kube-webhook-certgen:v1.4.3@sha256:a529382f6a723d4fcb2cf83bd5a0fcf46b492760bda17a28348df87cd8925506,IngressController=nginx-ingress-controller:v1.11.2@sha256:b10dae6f289b838b37a9989c912cbf780acb07c3f726f5648c2871d5e0919b33"



# minikube ssh "sudo nvidia-ctk runtime configure --runtime=docker && sudo systemctl restart docker" && minikube ssh "exit"
# minikube kubectl -- -n kube-system get all | grep -E "nvidia"

# sleep 5
# minikube kubectl -- apply -f ./app/anythingllm.yml
# minikube tunnel
