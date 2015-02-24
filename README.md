# Ssssh!

"ssssh" is a small tool that can be used to encrypt and decrypt secrets, using the AWS "Key Management Service" (KMS).

## Usage

Encrypt secrets like this:

    ssssh encrypt KEY-ID < secrets.txt > secrets.encrypted

Later, you can decrypt them:

    ssssh decrypt < secrets.encrypted > secrets.txt

This assumes that the necessary AWS_xxx environment variables are set, and that KEY-ID is the name or alias of an existing KMS key.

## Limitations

"ssssh" can only encrypt small amounts of data; up to 4 KB.

## See also

If you'd rather install a Python interpreter than a Ruby one, secrets may also be decrypted using the AWS CLI.

    base64 -d < secrets.encrypted > secrets.bin
    aws kms decrypt --ciphertext-blob fileb://`pwd`/secret.bin --output text --query Plaintext | base64 -d > secrets.txt
