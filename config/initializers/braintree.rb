# BRAINTREE_CONFIG = YAML::load(File.open("#{Rails.root}/config/braintree.yml"))[Rails.env]
# 
# Braintree::Configuration.environment = BRAINTREE_CONFIG['environment']
# Braintree::Configuration.merchant_id = BRAINTREE_CONFIG['merchant_id']
# Braintree::Configuration.public_key = BRAINTREE_CONFIG['public_key']
# Braintree::Configuration.private_key = BRAINTREE_CONFIG['private_key']

BraintreeRails::Configuration.environment = :sandbox
BraintreeRails::Configuration.merchant_id = "k4b8c5364jj37n8m"
BraintreeRails::Configuration.public_key = "zb8dyp27fzpzrqyc"
BraintreeRails::Configuration.private_key = "2bdc99283c2000cc2bfa448fb236da1a"
BraintreeRails::Configuration.client_side_encryption_key = "MIIBCgKCAQEAqu1rnHeirm6hDVentjrRLwwltkxuQAg9csrZJohasyHcc2tHIQWTqHzzGE09RJ5oUA7d2IxZQSoryi9Rjfxx666NGekwep472j3QjL8OsovMtNhbT6WmOniStIv0ievbAM2ZBuumvmt8tutk6tD+fVYzodZu6UOUktNzQ7VArJKMrnnbLkyMJfNbhq0u2dgmMmth/YmazmrnV8MesYaP8xXFVhVqLHB1BmYe6/gtfne6N9eV4G791Eks/AywwHKXza5jbnquhkhhXLFtDk3GJ5lSCgyfggROR7aOmR1RT9aFLtzaqirm0iqQaqFZ2rr1DcHx/fwoAK2a6kKE/4/rbQIDAQAB+fVYzodZu6UOUktNzQ7VArJKMrnnbLkyMJfNbhq0u2dgmMmth/YmazmrnV8MesYaP8xXFVhVqLHB1BmYe6/gtfne6N9eV4G791Eks/AywwHKXza5jbnquhkhhXLFtDk3GJ5lSCgyfggROR7aOmR1RT9aFLtzaqirm0iqQaqFZ2rr1DcHx/fwoAK2a6kKE/4/rbQIDAQAB"