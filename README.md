# tf-core

This repo is part of series of personal repos where I do tests on the following topics:

1. Terraform Cloud CI/CD pipeline based on GitHub Actions for central infrastructure and release management and team collaboration
2. Managing and Deploying EKS cluster (dev and prod stages)
3. Deploying test apps on the EKS cluster (dev and prod stages)
4. Central AWS VPC (peered with PROD and DEV VPCs), used for Client VPN connection with Certificase based authentication
5. GitHub Actions running in every repo with special rules to check the Terrafrom code before merging branches (more check can be added)

This particular repo is the Core repository where we manage the different stages and their respective variables. It simulates 2 stages (DEV and PROD) and the branching model. It is so called "monorepo" as we have folders who are responsible for different thigs (Netwokring, Compute, Security etc.). It pull the state of the Central VPN repo, so we can consum the VPN settings from there and create the routes on this side. For now the branching model is:
1. Commit only to DEV with (GitHub actions checks)
2. Terraform Clod automatic apply on the DEV branch
3. Once tested - merge from Dev to PROD branch
4. Manualy applies on terrafrom cloud on the PROD workspaces
