get "/users" do
  
  erb :"users/show"
end


get "/users/new" do
  @user = User.new
  erb :"users/create_user"
end

post "/users" do
  @user = User.create(params["users"])
  
  redirect "/users/#{@user.id}"
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

get "/users/:id" do
  erb :"users/test"
end

# post users
# delete users/:id
# get /users/:id/edit
#post /users/id/edit
#get /users/id
