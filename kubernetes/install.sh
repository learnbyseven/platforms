#!/bin/sh
sleep 2
apt update
sleep 2
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
sleep 2
sysctl -p
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1 
EOF
sleep 2
sudo sysctl --system
sleep 2
apt update
sleep 2
apt-get install -y apt-transport-https ca-certificates curl gpg gnupg lsb-release software-properties-common
sleep 3
mkdir -p -m 755 /etc/apt/keyrings
sleep 2
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
sleep 2
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sleep 2
sudo apt-get update
sleep 2
sudo apt-get install -y kubelet kubeadm kubectl
sleep 2
sudo systemctl enable --now kubelet
sleep 2
sudo apt update
sleep 2
apt autoremove -y
modprobe br_netfilter
sleep 2
echo 1 > /proc/sys/net/bridge/bridge-nf-call-iptables
sleep 2
echo 1 > /proc/sys/net/ipv4/ip_forward
sleep 2
CRIO_VERSION=v1.29
sleep 2
curl -fsSL https://download.opensuse.org/repositories/isv:/cri-o:/stable:/$CRIO_VERSION/deb/Release.key |     gpg --dearmor -o /etc/apt/keyrings/cri-o-apt-keyring.gpg
sleep 3
echo "deb [signed-by=/etc/apt/keyrings/cri-o-apt-keyring.gpg] https://download.opensuse.org/repositories/isv:/cri-o:/stable:/$CRIO_VERSION/deb/ /" |     tee /etc/apt/sources.list.d/cri-o.list
sleep 3
apt-get update
sleep 2
apt-get install -y cri-o
sleep 2
systemctl start crio.service && systemctl enable crio.service
sleep 3
kubeadm init --pod-network-cidr=192.168.0.0/16 --apiserver-bind-port=6443 
sleep 20
kubectl get nodes
sleep 2
mkdir -p $HOME/.kube && sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config && sudo chown $(id -u):$(id -g) $HOME/.kube/config
sleep 2
kubectl get nodes
sleep 2
kubectl taint nodes --all node-role.kubernetes.io/control-plane-
sleep 2
kubectl get nodes
sleep 2
sudo kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml
sleep 10
kubectl get pods -A

