# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Pick a unique cookie name to distinguish our session data from others'
  require "jcode"
  $KCODE="UFT8"
#	init_gettext "qjin"
  session :session_key => '_qjin_session_id'

 # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  # If you want "remember me" functionality, add this before_filter to Application Controller

#  helper :all 

  def qjin_server
    return 'http://122.152.25.122:3000/'
  end

  before_filter
  def han2zen(str)
    str=str.to_s
    str= str.tr('a-zA-Z','ａ-ｚＡ-Ｚ')
  end

  def low2upper(str)
    str= str.tr('ａ-ｚ','Ａ-Ｚ')
  end

  def zen_num2han_num(str)
    str=str.tr('０-９','0-9')
  end

  def hanalph2zenalph
    str=params.to_s
    params= str.tr('a-zA-Z','ａ-ｚＡ-Ｚ')
  end  

  def search2bango
    begin
        @query = params[:q]
      unless  @query
        @page_title = '企業名からの検索'
      else
        @page_title = '企業名から：「'+@query + '」 の検索結果 ' 
        @uketsuke_nen = nendo
        @query=han2zen(@query)
        @query=low2upper(@query)
        conditions = [ 'jigyosho_mei1 like ? or jigyosho_mei2 like ? or furikana like ? or kigyo_bango like ? ',
                     "%#{@query}%","%#{@query}%","%#{@query}%", "%#{@query}%"]
        @kigyo_daichos = KigyoDaicho.find(:all, :order => 'kigyo_bango',  
                                        :conditions => conditions )
      end
    rescue
    end
  end

  def search2bango_kako    #2013.9.11 start of edit
    begin
        @query = params[:q]
      unless  @query
        @page_title = '企業名からの検索'
      else
        @page_title = '企業名から：「'+@query + '」 の検索結果 '
        if @kako_data==false then  @uketsuke_nen = nendo else @uketsuke_nen ="" end
        @query=han2zen(@query)
        @query=low2upper(@query)
        conditions = [ 'jigyosho_mei1 like ? or jigyosho_mei2 like ? or furikana like ? or kigyo_bango like ?',
                     "%#{@query}%","%#{@query}%","%#{@query}%", "%#{@query}%"]
        @kigyo_daichos = KigyoDaicho.find(:all, :order => 'kigyo_bango',
                                        :conditions => conditions )
      end
    rescue
    end
  end

  def kigyo_search
    @query = params[:q]
    @query=han2zen(@query)
    @query=low2upper(@query)
    conditions = [ 'jigyosho_mei1 like ? or furikana like ? or kigyo_bango like ?',
                     "%#{@query}%","%#{@query}%", "%#{@query}%"]
    @kigyo_daichos = KigyoDaicho.find(:all, :order => 'kigyo_bango',
                                      :conditions => conditions)
  end

  def search_params
    @uketsuke_nen = nendo
    @query = params[:q]
    unless @query
      render :action => 'search_params'
    return
    end
    conditions = ['uketsuke_bango? or shokushu_bango? or shokushu_mai like? or
         shokugyo_code? or tenkin? or koutai? or kihonkyu>? or kijunnai_tingin>? or sintai?',
   "%#{@query}%", "%#{@query}%","%#{@query}%",
        "%#{@query}%", "%#{@query}%","%#{@query}%","%#{@query}%", "%#{@query}%","%#{@query}%" ]
    @kus = KyujinUketsuke.find(:all, :order => 'uketsuke_bango',                  :conditions => conditions )
    @kus_pages,  @kus = paginate :kus,
     :conditions => ['uketsuke_nen= ?', @uketsuke_nen],
     :order => 'uketsuke_bango DESC',
     :per_page => 25
  end

  def nendo(d=Date.today)
    year=d.year
    month=d.month
    if month <= 6 then year-1 else year end
  end


end
