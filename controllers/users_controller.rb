get "/users" do
  erb :"users/show"
end


get "/users/new" do
  @user = User.new
  erb :"users/create_user"
end

post "/users" do
  @user = User.new(params["users"])
  if @user.save
    redirect "/users/#{@user.id}"
  else
    erb :"users/create_user"
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

put "/users/:id/edit" do
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
