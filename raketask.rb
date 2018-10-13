require 'active_support/inflector'

desc "create generic CRUD controller given a model name"
task :controller do
  unless ENV.has_key?('NAME')
    raise "Must specify model name e.g., rake generate:controller NAME=user"
  end
  model = ENV['NAME']
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
