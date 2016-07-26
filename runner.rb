model = ARGV[0]
router = <<-ROUTER
get "/#{model}s" do
	@#{model}s = #{model.capitalize}.all
	erb :"/#{model}s/index"
end

get "/#{model}s/new" do
	erb :"/#{model}s/new"
end

post "/#{model}s" do
	@#{model} = #{model.capitalize}.new(params[:#{model}])
	if @#{model}.save
		if request.xhr?
			@#{model}
		else
			redirect "/#{model}s"
		end
	else
		erb :"/#{model}s/new"
	end
end

get "/#{model}s/:id" do
	@#{model} = #{model.capitalize}.find(params[:id])
	erb "/#{model}s/show"
end

get "/#{model}s/:id/edit" do
	erb :"/#{model}s/edit"
end

put "/#{model}s/:id" do
	@#{model} = #{model.capitalize}.find(params[:id])
	@#{model}.update(params[:#{model}])
	redirect "/#{model}s/params[:id]"
end

delete "/#{model}s/:id" do
	@#{model} = #{model.capitalize}.find(params[:id])
	@#{model}.destroy
	redirect "/#{model}s/index"
end
ROUTER

f = File.new("#{model}s.rb", "wb")
f.write(router)