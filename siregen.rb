require 'dry/inflector'

inflector = Dry::Inflector.new
model = ARGV[0]
model_plural = inflector.pluralize(model)

router = <<-ROUTER
  get "/#{model_plural}" do
    @#{model_plural} = #{model.capitalize}.all
    erb :"/#{model_plural}/index"
  end

  get "/#{model_plural}/new" do
    erb :"/#{model_plural}/new"
  end

  post "/#{model_plural}" do
    @#{model} = #{model.capitalize}.new(params[:#{model}])
    if @#{model}.save
      if request.xhr?
        @#{model}
      else
        redirect "/#{model_plural}"
      end
    else
      erb :"/#{model_plural}/new"
    end
  end

  get "/#{model_plural}/:id" do
    @#{model} = #{model.capitalize}.find(params[:id])
    erb "/#{model_plural}/show"
  end

  get "/#{model_plural}/:id/edit" do
    erb :"/#{model_plural}/edit"
  end

  put "/#{model_plural}/:id" do
    @#{model} = #{model.capitalize}.find(params[:id])
    @#{model}.update(params[:#{model}])
    redirect "/#{model_plural}/params[:id]"
  end

  delete "/#{model_plural}/:id" do
    @#{model} = #{model.capitalize}.find(params[:id])
    @#{model}.destroy
    redirect "/#{model_plural}/index"
  end
ROUTER

f = File.new("#{model_plural}.rb", "wb")
f.write(router)
