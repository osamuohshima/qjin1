class KyujinDaichoController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

#  def list_kyujin_daicho
  def list
    # @kigyo_daicho = KigyoDaicho.find(all)
			@kigyo_daicho = KigyoDaicho.find(params[:id])
     @kyujin_daicho_pages, @kyujin_daichos=paginate(:kyujin_daichos,
         :conditions => ['kigyo_daicho_id=?',@kigyo.id],:per_page => 10)
  end

  def show
    @kyujin_daichos = KyujinDaichos.find(params[:id])
  end

  def new
    @kyujin_daichos = KyujinDaichos.new
  end

  def create
    @kyujin_daichos = KyujinDaichos.new(params[:kyujin_daichos])
    if @kyujin_daichos.save
      flash[:notice] = 'KyujinDaichos was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
#	:confirm bd
		end
  end

  def edit
    @kyujin_daichos = KyujinDaichos.find(params[:id])
  end

  def update
    @kyujin_daichos = KyujinDaichos.find(params[:id])
    if @kyujin_daichos.update_attributes(params[:kyujin_daichos])
      flash[:notice] = 'KyujinDaichos was successfully updated.'
      redirect_to :action => 'show', :id => @kyujin_daichos
    else
      render :action => 'edit'
    end
  end

  def destroy
    KyujinDaichos.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
