class TargetsController < ApplicationController
  
  def new  

    @target = Target.new 

  end  
    
  def create  

    @target = Target.new()

  end

  def edit

    @target = Target.find(params[:id])
    
  end


  def index

    @targets = Target.all

  end

  def show

    @target = Target.find(params[:id])

  end

end