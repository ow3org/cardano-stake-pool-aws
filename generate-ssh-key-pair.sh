# TODO: we need to check if the key exists before we would create it

# only used temporary for testing
aws ec2 delete-key-pair \
    --region us-east-1 \
    --key-name cardano-stake-pool \
    --query "KeyMaterial" \
    --output text > cardano-stake-pool.pem

# create the AWS Key Pair which we need to ssh into the server
aws ec2 create-key-pair \
    --region us-east-1 \
    --key-name cardano-stake-pool \
    --query "KeyMaterial" \
    --output text > cardano-stake-pool.pem

# set proper rights on the secret key
chmod 400 ./cardano-stake-pool.pem

# move the file to the permanent .ssh directory
mv ./cardano-stake-pool.pem $HOME/.ssh/cardano-stake-pool.pem

echo 'AWS Key Pair was successfully created and moved to:'
echo $HOME/.ssh/cardano-stake-pool.pem
