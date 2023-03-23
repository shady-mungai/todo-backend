class ApplicationController < ActionController::API

    def encode_token
        JWT.ecode(payload, "secret")
    end

    def decode_token
        # get the token from the headers
        auth_header = request.headers['Authorization']
        # check whether the token is present
        if auth_header
        # 'Bearer ghgfdnhfng' split(' ')[1]
            token = auth_header.split(' ')[1]
        # wrap the decoding pro2cess within a exception
        begin
            JWT.decode(token, 'secret', true, algorithm: 'HS256')

        rescue JWT::DecodeError
            nil
            
        end
    end

    def authorised_user
        # use the decoded_token method to get user details 
        decoded_token = decode_token()
        if decoded_token
            # take out thr user id
            user_id = decoded_token[0][:id]

           # |[{payload},{header},{verify_signature}]|
                # {
                #     "id":10,
                #     "name":"John"
                # }
        # find the user that matches the id
            user = User.find_by_id(id: user_id)
        else
            render json: { error: "User not found" }, status: :not_found

    end

    def authorize
        render json: { message: "Unauthorized access "}, status: :unauthorized unless
        authorised_user

    end

    # def split 
    #     string = 'bearer hgfhfdhjfg'
    #     puts string.split[1]
    # end

end
