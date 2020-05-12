# HashiCorp **`vault`** all token policies.
The provided script leverages [vault-ruby gem](https://github.com/hashicorp/vault-ruby/) using token `accessor_id` to to list all combinations of token policy and their totals.

The script can be helpful in the context of policies that are associated with tokens (`/auth` lease) and which need to be checked for which policy groups are generating the bulk of tokens.

Refer to the contents of **`vault-tokens-by-policy.rb`** for setting Vault address and credentials.

```bash
nano vault-tokens-by-policy.rb ;
 # Vault.address = "http://192.168.178.101:8200";
 # Vault.token   = "root";
 # // ^^ set address & credentials.

gem install vault ;
 # // install vault libraries

ruby vault-tokens-by-policy.rb ;
 # Running Ruby: vault-tokens-by-policy.rb
 # 
 # TOKEN POLICY COUNTS:
 # ["root"]: 1
 # ["users-read-only"]: 3
 #
 # INSPECTED: 3 total accessor tokens.
 # 
 # Ruby ACCESSOR TOKENS POLICY CHECKS TOOK: 0.002511 seconds to complete.
```


## Notes
This is intended as a mere practise exercise.

See [Vault api-docs/libraries](https://www.vaultproject.io/api-docs/libraries) for other application specific frameworks which may be used in authoring other / similar tools to help automate interactions with Vault. 

Equivalent API methods related accessors are detailed at [api-docs/auth/token](https://www.vaultproject.io/api-docs/auth/token).

[aphorise/hashicorp.vault-tokens-deletion-by-accessor](https://github.com/aphorise/hashicorp.vault-tokens-deletion-by-accessor)

------
