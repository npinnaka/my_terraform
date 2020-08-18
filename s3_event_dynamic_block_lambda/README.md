# tf_dyna_s3_event_lambda

Add Multiple S3 events triggers to a lambda functions.
I want to add multiple s3 events to trigger lambda on 3 folders in a s3 bucket

## Installation
clone or fork repo.

```bash
git clone git@github.com:npinnaka/tf_dyna_s3_event_lambda.git
```

## Usage

```terraform
terraform init
terraform plan
terraform apply 
```

## output
S3 bucket should have 3 events point to same lambda function on 3 folders a,b,c

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)