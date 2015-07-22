# Homepage (Root path)
enable :sessions

before '/*' do
  unless request.path == '/' ||
    request.path == '/users/login' ||
    request.path == '/users/signup' ||
    if !session['username']
      redirect '/users/login'
    end
  end
end

def set_session_info(user)
  session['user_id'] = user.id
  session['username'] = user.username
end

def delete_session_info
  session['user_id'] = nil
  session['username'] = nil
end

get '/' do
  if session['user_id']
    redirect '/songs'
  else
    erb :index
  end
end

get '/songs' do
  @song = Song.all
  erb :'songs/index'
end

get '/songs/new' do
  erb :'songs/new'
end

post '/songs' do
  @song = Song.new(params[:song])
  @song.user_id = session['user_id']
  if @song.save
    redirect '/songs'
  else
    erb :'songs/new'
  end
end

get '/songs/:id' do
  @song = Song.find(params[:id])
  erb :'songs/show'
end

get '/users/signup' do
  erb :'users/signup'
end

post '/users/signup' do
  @user = User.new(params[:user])
  if @user.save
    set_session_info(@user)
    redirect '/songs'
  else
    erb :'users/signup'
  end
end

get '/users/login' do
  erb :'users/login'
end

post '/users/login' do
  @user = User.find_by_username(params[:username])
  if @user == nil 
    @error = 'Username not found!'
    return erb :'users/login'
  end
  if @user.password == params[:password]
    set_session_info(@user)
    redirect '/songs'
  else
    @error = 'Password incorrect!'
    erb :'users/login'
  end
end

get '/users/logout' do
  delete_session_info
  redirect '/'
end


