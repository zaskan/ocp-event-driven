#!/bin/bash

# GitOps Configuration
oc adm policy add-cluster-role-to-user cluster-admin  system:serviceaccount:openshift-gitops:openshift-gitops-argocd-application-controller -n openshift-gitops

# Create environment using GitOps
oc apply -f environment/environment.yaml

# Instructions
ARGO_USER=admin
ARGO_PASS=$(oc get secret openshift-gitops-cluster -n openshift-gitops -ojsonpath='{.data.admin\.password}' | base64 -d)
ARGO_ROUTE=$(oc get route openshift-gitops-server -n openshift-gitops -o jsonpath='{.status.ingress[0].host}')

echo "Login into ArgoCD using the following info:"
echo ""
echo "    URL: https://$ARGO_ROUTE"
echo "    User: $ARGO_USER"
echo "    Pass: $ARGO_PASS"
echo ""
echo "Review the created resources inside demo-environment app and press SYNC"
