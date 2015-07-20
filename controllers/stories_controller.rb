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
  if @user.id == @story.user_id
    erb :"stories/delete_story"
  else
    redirect "/users/#{@user.id}/stories"
  end
end

delete "/stories/:id" do
  current_user
  @story = Story.find(params["id"])
  if @user.id == @story.user_id
    if @story.delete
      return "Success."
    else
      return "Failed."
    end
  else
    redirect "/users/#{@user.id}/stories"
  end
end

get "/stories/:id/edit" do
  current_user
  @story = Story.find(params["id"])
  if @user.id == @story.user_id
    erb :"stories/edit_story"
  else
    redirect "/users/#{@user.id}/stories"
  end
end

put "/stories/:id" do
  current_user
  @story = Story.find(params["stories"]["id"])
  if @user.id == @story.user_id
    if @story.update(params["stories"])
      redirect "users/#{@user.id}/stories/#{@story.id}"
    else
      erb :"stories/edit_story"
    end
  else
    redirect "/users/#{@user.id}/stories"
  end
end

get "/users/:user_id/stories/:id" do
  @user = User.find(params["user_id"])
  @story = Story.find(params["id"])
  erb :"stories/single_story"
end
