## Amazon EKS with Terraform

![amazon-eks.png](../images/amazon-eks.png)

Create an AWS EKS cluster with Terraform. Deploying the EKS cluster may take around 15-20 minutes.

## Prerequisites

- An AWS account
- Terraform >=0.14
- AWS CLI v2
- kubectl

## Deployment steps

1. Clone the repository:
```
```

2. Configure AWS credentials using any one of the below methods:
```
export AWS_ACCESS_KEY_ID=AKAIXXXXXX
export AWS_SECRET_ACCESS_KEY=XXXXXX
export AWS_SESSION_TOKEN=XXXXXX
```

OR

```
aws configure
```

3. Update the Input Parameters:
   - Navigate to parameters -> parameters.tf file
   - Update the parameters as per your requirement.


4. Deploy the AWS EKS cluster:

```
terraform init
terraform apply
```

5. Decommissioning the AWS EKS Cluster setup:

```
terraform destroy
```
