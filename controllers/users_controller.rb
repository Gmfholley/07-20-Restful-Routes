get "/" do
  session[:id] = nil
  @user = User.new
  erb :"users/login"
end

get "/users" do
  if session["id"]
    @user = User.find(session["id"])
  else
    @user = User.new
  end
  erb :"users/show"
end

get "/new_user" do
  @user = User.new  
  erb :"users/create_user"
end

post "/new_user" do
  params["users"]["password"] = BCrypt::Password.create(params["users"]["password"])
  @user = User.new(params["users"])
  if @user.valid?
    @user.save
    session[:id] = @user.id
    redirect "/users/#{@user.id}"
  else
    erb :"users/create_user"
  end
end

post "/users/login" do
  @user = User.where("email" => params["users"]["email"]).first
  if !@user.nil? && @user.valid_password?(params["users"]["password"])
    session[:id] = @user.id
    redirect "/users/#{@user.id}"
  else
    erb :"users/login"
  end
end

get "/delete_profile" do
  current_user
  erb :"users/delete_user"
end

delete "/users" do
  current_user
  if @user.delete(params["id"])
    redirect "/"
  else
    erb :"users/delete_user"
  end
end

get "/edit_profile" do
  current_user
  erb :"users/edit_user"
end

put "/users" do
  current_user
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
