
helpers do
  
  def current_user
    if session[:user_id].nil?
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

