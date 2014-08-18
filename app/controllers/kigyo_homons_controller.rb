require 'application'
class KigyoHomonsController < ApplicationController
#  active_scaffold :kigyo_homons do |config|
#		 config.list.per_page =2
#	 end

	def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @kigyo_homon_pages,
		@kigyo_homons = paginate :kigyo_homons, :order => 'visit_date DESC', :per_page => 15 #idの逆順で表示
  end

  def new
    @kigyo_homon = KigyoHomon.new
    @kigyo_homon.kigyo_bango=params[:bango]
    @kigyo_homon.jigyosho_mei1=params[:mei1]
    @kigyo_homon.jigyosho_mei2=params[:mei2]
  end

  def create()
    @kigyo_homon = KigyoHomon.new(params[:kigyo_homon])
    if @kigyo_homon.save
      flash[:notice] = '新規の企業訪問データは保存されました'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def show
    @kigyo_homon = KigyoHomon.find(params[:id])
  end

  def edit
    @kigyo_homon = KigyoHomon.find(params[:id])
  end

  def update
    @kigyo_homon = KigyoHomon.find(params[:id])
    if @kigyo_homon.update_attributes(params[:kigyo_homon])
      flash[:notice] = '企業訪問データの更新に成功しました'
      redirect_to :action => 'list'  #, :id => @kigyo_homon
    else
      render :action => 'edit'
    end
  end

  def destroy
    KigyoHomon.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

  def search
		@kigyo_homon = KigyoHomon.find(:all,	:conditions => params[:conditions], :order => 'kigyo_bango' )
   render :action => 'list'
	end

	def jigyoshomei1_for_lookup
		@kigyo_daichos=KigyoDaicho.find(:all)
		@headers['Content-type']='text/javascript'
	end

end
