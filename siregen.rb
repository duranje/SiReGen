require 'active_support/inflector'

model = ARGV[0]
router = <<-ROUTER
get "/#{model.pluralize}" do
	@#{model.pluralize} = #{model.capitalize}.all
	erb :"/#{model.pluralize}/index"
end

get "/#{model.pluralize}/new" do
	erb :"/#{model.pluralize}/new"
end

post "/#{model.pluralize}" do
	@#{model} = #{model.capitalize}.new(params[:#{model}])
	if @#{model}.save
		if request.xhr?
			@#{model}
		else
			redirect "/#{model.pluralize}"
		end
	else
		erb :"/#{model.pluralize}/new"
	end
end

get "/#{model.pluralize}/:id" do
	@#{model} = #{model.capitalize}.find(params[:id])
	erb "/#{model.pluralize}/show"
end

get "/#{model.pluralize}/:id/edit" do
	erb :"/#{model.pluralize}/edit"
end

put "/#{model.pluralize}/:id" do
	@#{model} = #{model.capitalize}.find(params[:id])
	@#{model}.update(params[:#{model}])
	redirect "/#{model.pluralize}/params[:id]"
end

delete "/#{model.pluralize}/:id" do
	@#{model} = #{model.capitalize}.find(params[:id])
	@#{model}.destroy
	redirect "/#{model.pluralize}/index"
end
ROUTER

f = File.new("#{model.pluralize}.rb", "wb")
f.write(router)
