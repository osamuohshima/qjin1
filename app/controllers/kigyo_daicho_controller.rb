class KigyoDaichoController < ApplicationController
  require "csv"
  def index
    order = 'kigyo_bango'
    order = 'furikana' if params[:sort] == 'byname'
    @kigyo_daichos = KigyoDaicho.find(:all, :order => order)
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @kigyo_daicho_pages, @kigyo_daichos = paginate :kigyo_daichos, :per_page => 20, :order => 'kigyo_bango DESC' 
  end

  def show
    @kigyo_daicho = KigyoDaicho.find(params[:id])
  end

  def new
    @kigyo_daicho = KigyoDaicho.new
  end

  def create
    @nendo = nendo
    @kigyo_daicho = KigyoDaicho.new(params[:kigyo_daicho])
    if @kigyo_daicho.save
      flash[:notice] = '新しい企業の登録に成功しました'
      redirect_to :action => 'search', :q => @kigyo_daicho.kigyo_bango
    else
      render :action => 'new'
    end
  end

  def edit
    @kigyo_daicho = KigyoDaicho.find(params[:id])
  end

  def update
    @kigyo_daicho = KigyoDaicho.find(params[:id])
    if @kigyo_daicho.update_attributes(params[:kigyo_daicho])
      flash[:notice] = '企業台帳の更新に成功しました'
      redirect_to :action => 'show', :id => @kigyo_daicho
    else
      render :action => 'edit'
    end
  end

  def destroy
    KigyoDaicho.find(params[:id]).destroy
    redirect_to :action => 'index'
  end

  def search
    @query = params[:q]
    unless @query
      redirect_to :action => 'index'
      return
    end
    conditions = [ 'jigyosho_mei1 like ? or jigyosho_mei2 like ? or furikana like ? or
                 kigyo_bango like ?', "%#{@query}%","%#{@query}%","%#{@query}%", "%#{@query}%"]
    @kigyo_daichos = KigyoDaicho.find(:all, :order => 'kigyo_bango',
                                      :conditions => conditions)
    render :action => 'index'
  end

  def search_kigyobango
    @query = params[:q]
    conditions = [ ' kigyo_bango like ?', @query]
    @kigyo_daichos = KigyoDaicho.find(:first,  :conditions => conditions)
  end

  def edit_uketsuke_rireki
#    @kigyo = KigyoDaicho.find(params[:id])
#    @kigyo_bango = @kigyo.kigyo_bango
    session[:kigyo_id]=params[:id]
    begin
    redirect_to :controller => 'uketsuke_rirekis',
                :action => 'search_from_kigyo_bango',
                :q => KigyoDaicho.find(params[:id]).kigyo_bango
#    flash[:notice] = "パラメータは#{params}です"
    rescue
     redirect_to :controller=>'uketsuke_rirekis',
                 :action=>'new_this_kigyo',
                 :id => session[:kigyo_id]

    end  
  end
  
  def kigyo_out
    content_type = if request.user_agent =~ /windows/i
                     'application/vnd.ms-excel'
                   else
                     'text/csv'
                   end
    CSV::Writer.generate(output = " ") do |csv|
      KigyoDaicho.find(:all).each do |kigyo_daicho|
        csv << [kigyo_daicho.kigyo_bango, kigyo_daicho.jigyosho_mei1,
          kigyo_daicho.jigyosho_mei2, kigyo_daicho.furikana,
          kigyo_daicho.shozaichi, kigyo_daicho.yubin_zip,
          kigyo_daicho.shozaichi1, kigyo_daicho.shozaichi2,
          kigyo_daicho.tantou_yaku, kigyo_daicho.tantou_mei,
          kigyo_daicho.tele_number, kigyo_daicho.sangyo_code,
          kigyo_daicho.seisan_hinmoku]
      end
    end
    output= NKF.nkf('-Ws',output)
    send_data(output,
              :type => content_type,
              :filename => "kigyo_daicho.csv")
  end

end
