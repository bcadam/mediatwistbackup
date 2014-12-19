class UsersController < ApplicationController
  def new  
    @user = User.new  
  end  
    
  def create  
    @user = User.new(params[:user])  
    if @user.save  
      redirect_to root_url, :notice => "Signed up!"
    else  
      render "new"  
    end  
  end

  def profile
    @user = current_user
    @sites = Site.where(:userid => @user.id)
  end

  def destroysite
  end


end
