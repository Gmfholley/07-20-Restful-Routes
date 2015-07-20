get "/users/:id/stories" do
  @user = User.find(params["id"])
  erb :"stories/show"
end


get "/new_story" do
  current_user
  @story = Story.new
  erb :"stories/create_story"
end

post "/new_story" do
  current_user
  @story = Story.new(params["stories"])
  if @story.save
    redirect "/users/#{@user.id}/stories/#{@story.id}"
  else
    erb :"stories/create_story"
  end
end

get "/delete_story/:id" do
  current_user
  @story = Story.find(params["id"])
  if @user.id == @story.user_id
    erb :"stories/delete_story"
  else
    redirect "/users/#{@user.id}/stories"
  end
end

delete "/delete_story/:id" do
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

get "/edit_story/:id" do
  current_user
  @story = Story.find(params["id"])
  if @user.id == @story.user_id
    erb :"stories/edit_story"
  else
    redirect "/users/#{@user.id}/stories"
  end
end

put "/edit_story/:id" do
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
