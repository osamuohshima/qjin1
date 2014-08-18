class KigyoInfoController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @kigyo_info_pages,
    @kigyo_infos = paginate( :kigyo_infos,
                                  :order    => 'kigyo_number DESC',
                                  :per_page => 25)
  end

  def show
    @kigyo_info = KigyoInfo.find(params[:id])
  end

  def new
    @kigyo_info = KigyoInfo.new(:jugyoinsu =>0)
  end

  def create
    @kigyo_info = KigyoInfo.new(params[:kigyo])
    if @kigyo_info.save
      flash[:notice] = 'KigyoInfo was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @kigyo_info = KigyoInfo.find(params[:id])
  end

  def update
    @kigyo_info = KigyoInfo.find(params[:id])
    if @kigyo_info.update_attributes(params[:kigyo_info])
      flash[:notice] = '更新された企業情報は保存されました'
      redirect_to :action => 'show', :id => @kigyo_info
    else
      render :action => 'edit'
    end
  end

  def destroy
    KigyoInfo.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
