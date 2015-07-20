get "/" do
  session[:id] = nil
  @user = User.new
  erb :"users/login"
end

get "/users" do
  erb :"users/show"
end

get "/users/new" do
  @user = User.new  
  erb :"users/create_user"
end

post "/users" do
  params["users"]["password"] = BCrypt::Password.create(params["users"]["password"])
  @user = User.new(params["users"])
  if user.valid?
    user.save
    session[:id] = user.id
    redirect "/users/#{@user.id}"
  else
    erb :"users/create_user"
  end
end

post "/users/login" do
  @user = User.where("email" => params["users"]["email"]).first
  if @user.valid? && @user.valid_password?(params["users"]["password"])
    session[:id] = @user.id
    redirect "/users/#{@user.id}"
  else
    erb :"users/login"
  end
end

get "/users/delete/:id" do
  @user = User.find(params["id"])
  erb :"users/delete_user"
end

delete "/users/:id" do
  if User.delete(params["id"])
    return "Success."
  else
    return "Failed."
  end
end

get "/users/:id/edit" do
  @user = User.find(params["id"])
  erb :"users/edit_user"
end

put "/users/:id" do
  @user = User.find(params["users"]["id"])
  if @user.update(params["users"])
    redirect "/users/#{@user.id}"
  else
    erb :"users/edit_user"
  end
end

get "/users/:id" do
  @user = User.find(params["id"])
  erb :"users/single_user"
end
