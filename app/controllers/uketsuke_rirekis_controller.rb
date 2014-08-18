require 'application.rb'
class UketsukeRirekisController < ApplicationController
  def index
#  if Date.today.month>7 then @nendo=Date.today.year else @nendo= Date.today.year-1 end
    @nendo=nendo
  list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @nendo = nendo
    @uketsuke_rireki_pages,
    @uketsuke_rirekis = paginate :uketsuke_rirekis,
                    :conditions => ['uketsuke_nen= ?', @nendo],
                    :order => 'uketsuke_bango DESC',
                    :per_page => 25
  end

  def show
    @uketsuke_rireki = UketsukeRireki.find(params[:id])
  end

  def new
    @uketsuke_rireki = UketsukeRireki.new
    @uketsuke_nen=nendo
    @nendo=nendo
    @last_number=0
    begin 
       
    rescue  
      
    else
      
    end 
  end

  def create
    begin
    @uketsuke_rireki = UketsukeRireki.new(params[:uketsuke_rireki])
    if @uketsuke_rireki.save
      flash[:notice] = '新しい受付の更新に成功しました'
      redirect_to :action => 'list'
    else
      render :action => 'list'
    end
    rescue
    end
   
  end

  def edit
    @uketsuke_rireki = UketsukeRireki.find(params[:id])

  end

  def update
    @uketsuke_rireki = UketsukeRireki.find(params[:id])
    if @uketsuke_rireki.update_attributes(params[:uketsuke_rireki])
      flash[:notice] = '受付履歴の更新に成功しました。'
      redirect_to :action => 'show', :id => @uketsuke_rireki
    else
      render :action => 'edit'
    end
  end

  def destroy
    @destroied_kigyo = UketsukeRireki.find(params[:id])
    UketsukeRireki.find(params[:id]).destroy
    redirect_to :action => 'search_from_kigyo_bango',
                :q => @destroied_kigyo.kigyo_bango
  end

  def search
    params[:q] = "q?=#{cookies[:kigyo_bango].to_i}"
    render :action => 'search_from_kigyo_bango'
  end

  def kyujin_daicho_out

  end
  def update_uketsuke_rirekis_from_kyujin_uketsuke
    nendo=Date.today.year
    ur_max=UketsukeRireki.maximum(:uketsuke_bango,
                            :conditions => ["uketsuke_nen=?", nendo])
    if ur_max==nil then ur_max=0 end
    ku_max=KyujinUketsuke.maximum(:uketsuke_bango,
                            :conditions => ["uketsuke_nen=?", nendo])
    ((ur_max+1)..ku_max).each  do |ub|
#    
#   frm_num<=next_num_of UketsukeRireki
#   to_num <=max_num_of KyujinUketsuke   
#    (frm_num..to_num).each  do |ub| # when manual_update
      ur=UketsukeRireki.new()
      ku=KyujinUketsuke.find_by_uketsuke_bango(ub,
                            :conditions =>["uketsuke_nen=?",nendo])
      ur.kigyo_bango=ku.kigyo_bango  
      ur.uketsuke_nen=nendo
      ur.uketsuke_bango= ub
      ur.kigyo_daicho_id= KigyoDaicho.find_by_kigyo_bango(ku.kigyo_bango).id
      ur.kyujinhyo_maisu=KyujinUketsuke.maximum(:shokushu_bango,
        :conditions =>["uketsuke_nen=? and uketsuke_bango=?", nendo, ub])+1
      ur.save

    end
      render :action => 'index'
  rescue=>e
    p e.backtrace
    
  end

  def update_kigyodaicho_ids
    @uketsuke_rirekis=UketsukeRireki.find(:all)
    @uketsuke_rirekis.each do |rireki|
      @kigyo_daicho = KigyoDaicho.find(:first,
                        :conditions => "kigyo_bango = #{rireki.kigyo_bango}")
      unless @kigyo_daicho.nil?
        rireki.kigyo_daicho_id = @kigyo_daicho.id
        rireki.save
      end
    end
       flash[:notice] = '全部の企業台帳_id の更新に成功しました。'
      redirect_to :action => 'index'
  end

  def search_from_kigyo_bango
    @kigyo_bango = params[:q]
    unless @kigyo_bango
      redirect_to :action => 'list'
      return
    end
    conditions = ['kigyo_bango = ?', @kigyo_bango]
    begin
    @uketsuke_rirekis = UketsukeRireki.find(:all,
                                            :conditions => conditions,
                                           :order => "uketsuke_nen DESC")
    render :action => 'search_from_kigyo_bango'
 
   rescue
       redirect_to :action => 'new_this_kigyo',
                               :kigyo_bango => @kigyo_bango,
                               :kigyo_daicho_id => @id
#       render :action => 'new_this_kigyo' #cannot use of render 20110502
   end
  end

  def new_this_kigyo
      uketsuke_nen=self.nendo
      kigyo_bango=params[:q].to_i
      uketsuke_bango=kigyo_bango.to_i-uketsuke_nen
      @uketsuke_rireki = UketsukeRireki.new
      @uketsuke_rireki.uketsuke_bango=uketsuke_bango
      @uketsuke_rireki.uketsuke_nen=uketsuke_nen
      render
  end

  def create_in_this_kigyo
    @uketsuke_rireki = UketsukeRireki.new(params[:uketsuke_rireki])
    if @uketsuke_rireki.save
      flash[:notice] = '新しい受付の更新に成功しました'
      @kigyo = @uketsuke_rireki.kigyo_bango
      redirect_to :action => 'search_from_kigyo_bango',
                :q => @kigyo
    else
      render :action => 'new_this_kigyo'
    end
  end

  def rireki_out
    content_type = if request.user_agent =~ /windows/i
                     'application/vnd.ms-excel'
                   else
                     'text/csv'
                   end
    CSV::Writer.generate(output = " ") do |csv|
      UketsukeRireki.find(:all).each do |uketsuke_rireki|
        csv << [uketsuke_rireki.kigyo_bango, uketsuke_rireki.uketsuke_nen,
          uketsuke_rireki.uketsuke_bango, uketsuke_rireki.kigyo_daicho_id,
          uketsuke_rireki.kyujinhyo_maisu]
      end
    end
    send_data(output,
              :type => content_type,
              :filename => "uketsuke_rireki.csv")
  end

end
