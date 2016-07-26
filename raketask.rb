desc "create generic CRUD controller given a model name"
task :controller do
  unless ENV.has_key?('NAME')
    raise "Must specify model name e.g., rake generate:controller NAME=user"
  end
  model = ENV['NAME']
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

  controller_name = ENV['NAME']
  controller_filename = ENV['NAME'].pluralize + '.rb'
  controller_path = APP_ROOT.join('app', 'controllers', controller_filename)

  if File.exist?(controller_path)
    raise "ERROR: controller file '#{controller_path}' already exists"
  end

  puts "Creating #{controller_path}"
  File.open(controller_path, 'w+') do |f|
    f.write(router)
  end
end
