get "/stories" do
  erb :"stories/show"
end


get "/stories/new" do
  @story = Story.new
  erb :"stories/create_story"
end

post "/stories" do
  @story = Story.create(params["stories"])
  redirect "/stories/#{@story.id}"
end

get "/stories/delete/:id" do
  @story = Story.find(params["id"])
  erb :"stories/delete_story"
end

delete "/stories/:id" do
  if Story.delete(params["id"])
    return "Success."
  else
    return "Failed."
  end
end

get "/stories/:id/edit" do
  @story = Story.find(params["id"])
  erb :"stories/edit_story"
end

put "/stories/:id/edit" do
  @story = Story.find(params["stories"]["id"])
  if @story.update(params["stories"])
    redirect "/stories/#{@story.id}"
  else
    erb :"stories/edit_story"
  end
end

get "/stories/:id" do
  @story = Story.find(params["id"])
  erb :"stories/single_story"
end
