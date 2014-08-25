# BRAINTREE_CONFIG = YAML::load(File.open("#{Rails.root}/config/braintree.yml"))[Rails.env]
# 
# Braintree::Configuration.environment = BRAINTREE_CONFIG['environment']
# Braintree::Configuration.merchant_id = BRAINTREE_CONFIG['merchant_id']
# Braintree::Configuration.public_key = BRAINTREE_CONFIG['public_key']
# Braintree::Configuration.private_key = BRAINTREE_CONFIG['private_key']

BraintreeRails::Configuration.environment = :sandbox
BraintreeRails::Configuration.merchant_id = "6rjmt346s5nksjpk"
BraintreeRails::Configuration.public_key = "n8svkm5cz9v323f5"
BraintreeRails::Configuration.private_key = "fe000919e8c76d30cf1bd9e3af37dabc"
BraintreeRails::Configuration.client_side_encryption_key = "MIIBCgKCAQEApYnXlN/B7/q9S9WRi+vzpUfooC6gc+OJb/Oe28XI8fsDZo3WfNwJbVEJQ2jGLvY5bR1tDFkIsyNjHL3iv/LHRwRr49c8YI869WjYP4DlnreQHobNiE9YFl0cd5oGG9gPYBH/2SupOOfkZA0OYfc4NpPbJ+U0p2u9imnIhnAEos78BPIvyi19NFAzZ+sW3iWgcCB9FC/ARpPySc8AVIp4bUlSCp3nFHGPLzFmU4ULzHs0LZWhAA7S1+8zKa8u7kiZe9mt9Crz2dZw66dzbTu1VnEyXrolm+yXLtCE5C0j3hzADVjOzd1KrmOdASDLp/CzLA/kY2DO49wGd7OUnkG7RwIDAQAB"