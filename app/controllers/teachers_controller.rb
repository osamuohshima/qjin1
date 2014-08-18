require 'application.rb'
class TeachersController < ApplicationController
 require 'jcode' 
  def index
   
  end

  def destroy
    Teacher.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

  def show

  end

end
