get "/users" do
  
  erb :show
end


get "/users/new" do
  @user = User.new
  erb :user_create
end
# post users
# delete users/:id
# get /users/:id/edit
#post /users/id/edit
#get /users/id