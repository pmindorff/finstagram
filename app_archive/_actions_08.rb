
helpers do
  
  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    end
  end
  
  def logged_in?
    if session[:user_id]
      true
    else
      false
    end
  end

end



get '/' do
  @posts = Post.order(created_at: :desc)
 erb(:index)
end


get '/login' do
 erb(:login)
end

post '/login' do
  username = params[:username]
  password = params[:password]  
  
  user = User.find_by(username: username)
  
  if user && user.password == password
    session[:user_id] = user.id
 #   "Success! User with id #{session[:user_id]} is logged in!"
   @posts = Post.order(created_at: :desc)
   erb(:index)
  else
    @error_message = "Login failed."
    erb(:login)
  end
end


get '/signup' do
  @user = User.new
erb(:signup)
end

post '/signup' do
  email          = params[:email]
  avatar_url     = params[:avatar_url]
  username       = params[:username]
  password       = params[:password]

  @user = User.new({email: email, avatar_url: avatar_url,username: username, password: password})
  
    if @user.save
      "Ccongrats! you have signed up."
    else
      erb(:signup)
    end
end

get '/posts/new' do
  erb(:"posts/new")
end

post '/posts' do
  photo_url = params[:photo_url]
  
  # instantiate new Post
  @post = Post.new({photo_url: photo_url})
  
  # if @post validates, save
  if @post.save
    redirect(to('/'))
  else
    # if it doesnt validate, print error message
    @post.errors.full_messages.inspect
  end
end

  
  