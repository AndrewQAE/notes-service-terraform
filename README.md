# Notes Service – Terraform

Automates the "AWS Lambda Project" (Simple Notes API) with Terraform:

| PDF step | Terraform resource |
|---|---|
| 1. DynamoDB table `Notes` (key `noteId`) | `aws_dynamodb_table.notes` |
| 2. Lambda `notes-service`, Python 3.14 | `aws_lambda_function.notes` |
| 3. Lambda permission to use DynamoDB | `aws_iam_role.lambda` + `aws_iam_role_policy.dynamodb_access` |
| 4. Lambda code | `lambda/lambda_function.py` (zipped automatically) |
| 5. HTTP API, open, `ANY /notes-service` | `aws_apigatewayv2_*` + `aws_lambda_permission.apigw` |
| 6. Test with curl | `test.sh` |
| CloudWatch logs | `aws_cloudwatch_log_group.lambda` (14-day retention) |

## Prerequisites (macOS)

```bash
brew install awscli          # if not already installed
aws configure                # enter Access Key, Secret, region eu-west-2
aws sts get-caller-identity  # check credentials work
```

> If you already created the `Notes` table or `notes-service` function by hand
> in the console, delete them first (or change `table_name` / `function_name`
> in `terraform.tfvars`), otherwise `apply` will fail with "already exists".

## Deploy

```bash
cd notes-service-terraform
terraform init
terraform plan
terraform apply          # type 'yes'
```

The API URL is printed at the end as `api_endpoint`
(e.g. `https://abc123.execute-api.eu-west-2.amazonaws.com/default/notes-service`).

## Test

```bash
chmod +x test.sh
./test.sh
```

Or manually:

```bash
API=$(terraform output -raw api_endpoint)
curl -X POST "$API" -H "Content-Type: application/json" -d '{"content": "My first note"}'
curl "$API"
```

## Change the code

Edit `lambda/lambda_function.py` and run `terraform apply` again – Terraform
detects the change and redeploys the function.

## Logs

```bash
aws logs tail /aws/lambda/notes-service --follow
```

## Tear down

```bash
terraform destroy
```
