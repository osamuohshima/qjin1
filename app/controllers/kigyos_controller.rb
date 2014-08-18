class KigyosController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @kigyo_pages, @kigyos = paginate :kigyos, :per_page => 10
  end

  def show
    @kigyo = Kigyo.find(params[:id])
  end

  def new
    @kigyo = Kigyo.new
  end

  def create
    @kigyo = Kigyo.new(params[:kigyo])
    if @kigyo.save
      flash[:notice] = 'Kigyo was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @kigyo = Kigyo.find(params[:id])
  end

  def update
    @kigyo = Kigyo.find(params[:id])
    if @kigyo.update_attributes(params[:kigyo])
      flash[:notice] = 'Kigyo was successfully updated.'
      redirect_to :action => 'show', :id => @kigyo
    else
      render :action => 'edit'
    end
  end

  def destroy
    Kigyo.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
