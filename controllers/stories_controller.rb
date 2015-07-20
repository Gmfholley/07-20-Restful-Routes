get "/users/:id/stories" do
  @user = User.find(params["id"])
  erb :"stories/show"
end


get "/stories/new" do
  current_user
  @story = Story.new
  erb :"stories/create_story"
end

post "/stories" do
  current_user
  @story = Story.new(params["stories"])
  if @story.save
    redirect "/users/#{@user.id}/stories/#{@story.id}"
  else
    erb :"stories/create_story"
  end
end

get "/stories/delete/:id" do
  current_user
  @story = Story.find(params["id"])
  erb :"stories/delete_story"
end

delete "/stories/:id" do
  current_user
  if Story.delete(params["id"])
    return "Success."
  else
    return "Failed."
  end
end

get "/stories/:id/edit" do
  current_user
  @story = Story.find(params["id"])
  erb :"stories/edit_story"
end

put "/stories/:id" do
  current_user
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
