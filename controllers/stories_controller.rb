get "/users/:id/stories" do
  @user = User.find(params["id"])
  erb :"stories/show"
end


get "/users/:id/stories/new" do
  @story = Story.new
  @user = User.find(params["id"])
  erb :"stories/create_story"
end

post "/users/:id/stories" do
  @story = Story.new(params["stories"])
  @user = User.find(params["id"])
  if @story.save
    redirect "/users/#{@user.id}/stories/#{@story.id}"
  else
    erb :"stories/create_story"
  end
end

get "/users/:user_id/stories/delete/:id" do
  @story = Story.find(params["id"])
  @user = User.find(params["user_id"])
  erb :"stories/delete_story"
end

delete "/users/:user_id/stories/:id" do
  @user = User.find(params["user_id"])
  if Story.delete(params["id"])
    return "Success."
  else
    return "Failed."
  end
end

get "/users/:user_id/stories/:id/edit" do
  @user = User.find(params["user_id"])
  @story = Story.find(params["id"])
  erb :"stories/edit_story"
end

put "/users/:user_id/stories/:id/edit" do
  @user = User.find(params["user_id"])
  @story = Story.find(params["stories"]["id"])
  if @story.update(params["stories"])
    redirect "users/#{@user.id}/stories/#{@story.id}"
  else
    erb :"stories/edit_story"
  end
end

get "/users/:user_id/stories/:id" do
  @user = User.find(params["user_id"])
  @story = Story.find(params["id"])
  erb :"stories/single_story"
end
