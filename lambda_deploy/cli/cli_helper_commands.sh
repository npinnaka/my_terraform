# get the subnet and  maximum number of available ip addresses
export max_subnet_info=`aws ec2 describe-subnets --query 'Subnets[*].[AvailableIpAddressCount, SubnetId] | max_by(@, &[0])' |sed "s/\"//g"`
echo $max_subnet_info

# get the subnet-name with  maximum number of available ip addresses
export subnet_name=`aws ec2 describe-subnets --query 'Subnets[*].[AvailableIpAddressCount, SubnetId] | max_by(@, &[0])[1]' |sed "s/\"//g"`
echo $subnet_name

#get the subnet-name with max avaliable ip addresse with in given list of subnets. update filter.json
export subnet_name=`aws ec2 describe-subnets --filter file://filter.json --query 'Subnets[*].[AvailableIpAddressCount, SubnetId] | max_by(@, &[0])[1]' |sed "s/\"//g"`
echo $subnet_name

# get the subnet with sort by number of available ip addresses
export ordered_subnet_info=`aws ec2 describe-subnets --query 'Subnets[*].[AvailableIpAddressCount, SubnetId] | sort_by(@, &[0])'`
echo $ordered_subnet_info

