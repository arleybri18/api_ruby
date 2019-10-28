class UserTokenController < Knock::AuthTokenController
    # in rails 5.2
    skip_before_action :verify_authenticity_token
end
