# Ssssh!

"ssssh" is a small tool that can be used to encrypt and decrypt secrets, using the AWS "Key Management Service" (KMS).

## Usage

Encrypt secrets like this:

    ssssh encrypt KEY-ID < secrets.txt > secrets.encrypted

Later, you can decrypt them:

    ssssh decrypt < secrets.encrypted > secrets.txt

KEY-ID can be the id or ARN of a KMS master key, or alias prefixed by "alias/".  See document on [Encrypt](http://docs.aws.amazon.com/kms/latest/APIReference/API_Encrypt.html) for more details.

Naturally, suitable AWS credentials must be provided (via environment variables, command-line options, or EC2 instance profile).

## Limitations

"ssssh" can only encrypt small amounts of data; up to 4 KB.

## Use as a command shim

"ssssh exec" is a command shim that makes it easy to use secrets transported
via the (Unix) process environment.  It decrypts any environment variables
prefixed by "`KMS_ENCRYPTED_`", and executes a specified command.

For example:

```
$ export KMS_ENCRYPTED_DB_PASSWORD=$(ssssh encrypt alias/app-secrets 'seasame')
$ ssssh exec -- env | grep PASSWORD
KMS_ENCRYPTED_DB_PASSWORD=CiAbQLOo2VC4QTV/Ng986wsDSJ0srAe6oZnLyzRT6pDFWRKOAQEBAgB4G0CzqNlQuEE1fzYPfOsLA0idLKwHuqGZy8s0U+qQxVkAAABlMGMGCSqGSIb3DQEHBqBWMFQCAQAwTwYJKoZIhvcNAQcBMB4GCWCGSAFlAwQBLjARBAzfFR0tsHRq18JUhMcCARCAImvuMNYuHUut3BT7sZs9a31qWcmOBUBXYEsD+kx2GxUxBPE=
DB_PASSWORD=seasame
```

In this example, "ssssh exec":

- found `$KMS_ENCRYPTED_DB_PASSWORD` in the environment
- decrypted the contents
- put the result in `$DB_PASSWORD`
- executed `env`

"ssssh exec" works well as an entrypoint for Docker images, e.g.

    # Include "ssssh" to decode KMS_ENCRYPTED_STUFF
    RUN gem install ssssh
    ENTRYPOINT ["ssssh", "exec", "--"]

## See also

If you'd rather install a Python interpreter than a Ruby one, secrets may also be decrypted using the AWS CLI.

    base64 -d < secrets.encrypted > /tmp/secrets.bin
    aws kms decrypt --ciphertext-blob fileb:///tmp/secrets.bin --output text --query Plaintext | base64 -d > secrets.txt

If you'd rather not install an interpreter at all, there's a Go-lang port of "ssssh":

* https://github.com/realestate-com-au/shush

## Changes

### 1.3.0 (2016-10-26)

* Add `ssssh exec` subcommand.
* Add support for `$KMS_ENCRYPTION_CONTEXT`.

### 1.2.0 (2015-04-27)

* Add support for encryption contexts (`--context` option).
