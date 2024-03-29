class UsersController < ApplicationController
  before_filter :signed_in_user,  only: [:edit, :update, :index, :destroy, :following, :followers]
  before_filter :correct_user,    only: [:edit, :update]
  before_filter :admin_user,      only: :destroy
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def new
    if signed_in?
      redirect_to root_path
    else
      @user = User.new
    end
  end
  
  def create
    if signed_in?
      redirect_to root_path
    else
      @user = User.new(params[:user])
      # respond_to do |format|          
        if @user.save
          sign_in @user
          flash[:success] = "Welcome to the Sample App!"
          # redirect_to @user
          # Tell the UserMailer to send a welcome Email after save
          UserMailer.welcome_email(@user).deliver
          redirect_to @user
          # format.html { redirect_to(@user, :notice => 'User was successfully created.') }
          # format.json { render :json => @user, :status => :created, :location => @user }
        else
          render 'new' #this is here from before while a lot of this method is adapted now for the email send
          # format.html { render :action => "new" }
          # format.json { render :json => @user.errors, :status => :unprocessable_entity }
        end
      # end
    end
  end
  
  def destroy
    if current_user?(@user) #Not sure if this is correct until I get the test on auth_page_spec working
      flash[:error] = "You can't delete yourself!"
      redirect_to users_path
    else
      User.find(params[:id]).destroy
      flash[:success] = "User destroyed."
      redirect_to users_path
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end
  
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
