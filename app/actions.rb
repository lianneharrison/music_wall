# Homepage (Root path)
get '/' do
  erb :index
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
    redirect '/songs'
  else
    @error = 'Password incorrect!'
    erb :'users/login'
  end
end



