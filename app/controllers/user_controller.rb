class UserController < ApplicationController
    
  def welcome
    @user = User.find(session[:user_id])
  end
  def index  
  end

  def signup
  end

  def login
  end
  def add_session_login
    username = params[:username] 
    password = params[:password_digest]
    user = User.find_by_username(username)
    if user
        if user.password_digest == password
            session[:user_id] = user.id
        else
            return redirect_to :controller => :user , :action =>:login
        end
    else
        return redirect_to :controller => :user , :action => :signup
    end

    return redirect_to :controller => :user, :action => :welcome
  end

  def logout
    session[:user_id] = nil
    return redirect_to :controller => :user, :action => :index
  end


  def add_session
    n = params[:name]
    
    year = params[:year]
    email = params[:email]
    mobile = params[:mobile]
    username = params[:username] 
    password = params[:password_digest]
    user = User.find_by_username(username)
    if user
        if user.password_digest == password
            session[:user_id] = user.id
        else
            return redirect_to :controller => :user , :action =>:login
        end
    else
        user = User.create(:name => n, :password_digest => password, :year => year, :email => email, :username => username, :mobile => mobile)
        session[:user_id] = user.id
         
    end 
    return redirect_to :controller => :user , :action => :category  
  end

  def category
    @u = User.find(session[:user_id])
    @c=Category.all
  end

  def categorys
    #for categories
    cids=params[:ids]
    #for user 
    uid=params[:id]
    u=User.find(uid)
    u.category_ids = cids
    u.save
    redirect_to :controller => :user , :action => :show
  end

  def show
    @u=User.find(session[:user_id])
  end
end
