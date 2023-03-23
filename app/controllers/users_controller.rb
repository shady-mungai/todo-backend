class UsersController < ApplicationController
    #GET users
    def index
        render json: User.all, status: :ok
    end

    #GET users{id}
    def show
        #condtionally render the user if its there else show an error
        user = User.find_by(id: params[:id])
        if user
          render json: user, status: :ok
        else
            render json: { error: "User not found"},status: :not_found  
        end
    end

    def update 
        user = Task.find_by_id(params[:id])
        if user
            user.update(user_params)
            render json: task, status: :ok
        else
            render json: { error: "Task not found" },status: :not_found
        end
    end

    def create 
        user = User.create!(user_params)
        render json: user, status: :ok
    rescue ActiveRecord::RecordInvalid

    def login
        user = User.find_by(email: params[:email])

        if user && user.authenticate(params[:password])
            token = encode_tokenz({id: user.id})
            render json: { user: user,token: token }, status: :ok
        else
            render json: { error: }
    private
    
    def production_params
    end


end
