get "/users" do
  
  erb :"users/show"
end


get "/users/new" do
  @user = User.new
  erb :"users/create_user"
end


# post users
# delete users/:id
# get /users/:id/edit
#post /users/id/edit
#get /users/id
