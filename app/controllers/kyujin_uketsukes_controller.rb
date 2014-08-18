#この文字コードはutf-8です
class KyujinUketsukesController < ApplicationController
#	require 'breakpoint'

  def index
    @kyujin_uketsuke = KyujinUketsuke.new
  end

  def next_index
    @kyujin_uketsuke = KyujinUketsuke.new(params[:kyujin_uketsuke])
    @kyujin_uketsuke.uketsuke_code = @kyujin_uketsuke.uketsuke_bango.to_s + "-" + @kyujin_uketsuke.shokushu_bango.to_s
    @kigyo_daicho=KigyoDaicho.find_or_create_by_kigyo_bango(@kyujin_uketsuke.kigyo_bango)
    @kigyo_info=KigyoInfo.find_by_kigyo_number(
                    @kyujin_uketsuke.kigyo_bango, :order=>'input_date DESC')
    if @kigyo_info==nil then @kigyo_info=KigyoInfo.new(
		             	 :kigyo_number=>@kyujin_uketsuke.kigyo_bango)
    end
    @kigyo_info.kigyo_daicho_id=@kigyo_daicho.id if @kigyo_info.kigyo_daicho_id==nil
      @kigyo_info.save
  end
  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
#  verify :method => :post, :only => [ :destroy, :create, :update ],
#         :redirect_to => { :action => :list }

  def list
    @nendo = nendo()
    @kyujin_uketsuke_pages,
    @kyujin_uketsukes = paginate( :kyujin_uketsukes,
                                  :conditions => ["uketsuke_nen = ?", @nendo],
                                  :order    => 'uketsuke_bango DESC',
                                  :per_page => 25)
  end

  def show
    @kyujin_uketsuke = KyujinUketsuke.find(params[:id])
  end

  def new
#    @kyujin_uketsuke = KyujinUketsuke.new
  end

  def create 
    begin
      @kyujin_uketsuke = KyujinUketsuke.new(params[:kyujin_uketsuke])
      @kigyo_daicho=KigyoDaicho.find_by_kigyo_bango(@kyujin_uketsuke.kigyo_bango)
      params[:kigyo_daicho][:yubin_zip]=params[:kigyo_daicho][:yubin_zip].to_s.gsub(/[^0-9]/u, '')
      @kigyo_daicho.update_attributes(params[:kigyo_daicho])
      @kigyo_info=KigyoInfo.create(params[:kigyo_info])
      @kigyo_info.kigyo_daicho_id=@kigyo_daicho.id
      @kigyo_info.kigyo_number=@kigyo_daicho.kigyo_bango
      @kigyo_info.input_date=DateTime.now

    KyujinUketsuke.transaction do
      @kyujin_uketsuke.save!	 
      @kigyo_daicho.save!
      @kigyo_info.save!
      redirect_to :action => 'show', :id => @kyujin_uketsuke
    end
      make_rireki(params[:kyujin_uketsuke], params[:kigyo_daicho])
    rescue ActiveRecord::RecordInvalid => e
      @kigyo_daicho.valid?
      @kigyo_info.valid?
      render :action => :next_index
    end
  end
  def kyujin_daicho_out

  end

  def export_csv
    require 'csv'
    from_number=params[:frm_num]

#    last_number=KyujinUketsuke.count(:uketsuke_bango, :conditions =>[
#                                  "uketsuke_bango >= ? and uketsuke_nen =?",
#                                       from_number.to_i, nendo]) 
    last_number=KyujinUketsuke.maximum(:uketsuke_bango, :conditions =>[
                        "uketsuke_bango >= ? and uketsuke_nen =?",
                                       from_number.to_i, nendo])
#    kds=KyujinUketsuke.find(:all,
#      :conditions=>["uketsuke_bango >= ? and uketsuke_nen = ?", from_number.to_i, nendo], :limit => to_number, :order=> 'uketsuke_bango')

    kds=KyujinUketsuke.find_by_sql("select * from kyujin_uketsukes where uketsuke_nen = #{nendo} and uketsuke_bango >= #{from_number} and uketsuke_bango <= #{last_number} order by uketsuke_bango")


    cntnt_type = "text/csv"
    file_name = "kyujin_daicho.csv"
    CSV::Writer.generate(output = "") do |csv|
      kds.each do |kd|
        @kinfo=KigyoInfo.find_by_kigyo_number(kd.kigyo_bango,
					:order => 'input_date DESC')
#        render :text =>"存在するか？　#{@kinfo}"
#        if @kinfo.size == 0 then break end
        begin
        @kdaicho=KigyoDaicho.find_by_kigyo_bango(kd.kigyo_bango)
        csv << [ kd.uketsuke_date, kd.uketsuke_code, kd.uketsuke_bango,
	    kd.kigyo_bango, kd.shokushu_bango,@kdaicho.jigyosho_mei1,
            @kdaicho.jigyosho_mei2,
            @kdaicho.shozaichi, kd.tenkin, @kdaicho.seisan_hinmoku,
            @kinfo.jugyoinsu, @kinfo.sihon_oku, @kinfo.sihon_senman,
	    kd.koutai, kd.kihonkyu, kd.kijunnai_tingin, 
            kd.kikai, kd.denki, kd.joho, kd.kouka, 
            kd.kenchiku, kd.kei, kd.kyujin_sosu, kd.shokushu_mei,
            @kdaicho.sangyo_code, kd.shokugyo_code, kd.sintai,
	    kd.kengaku, kd.heigan, kd.bikou, kd.irai_jikou  ]
        rescue => ex
            puts "there are no data in kigyo_info for kigyo_bango=#{kigyo_bango} "
        end
      end
    end 
#   output = Iconv.conv('SJIS', 'UTF-8', output)  #「株」「(株)」が引っかかることが多い
    output = NKF.nkf('-Ws', output)
		send_data(output, :type => cntnt_type, :filename => file_name)
	rescue ActiveRecord::RecordInvalid => e
    kds.valid?
  end
 
  def edit
    @kyujin_uketsuke = KyujinUketsuke.find(params[:id])
  end

  def update
    @kyujin_uketsuke = KyujinUketsuke.find(params[:id])
#		@kyujin_uketsuke.uketsuke_nen = 	zen2han_num(@kyujin_uketsuke.uketsuke_nen.strip)
    if @kyujin_uketsuke.update_attributes(params[:kyujin_uketsuke])
      flash[:notice] = '受け付けた求人の更新に成功しました。'
      redirect_to :action => 'show', :id => @kyujin_uketsuke
    else
      render :action => 'edit'
    end
  end

  def destroy
    KyujinUketsuke.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  def search
    @query = params[:q]
    unless @query
       redirect_to :action => 'search_result'
    return
    end
  conditions = [ 'jigyosho_mei1 like ? or furikana like ? or kigyo_bango like ?',"%#{@query}%","%#{@query}%", @query]
  @kyujin_uketsukes = KyujinUketsuke.find(:all, :order => 'kihon_kyu',
 				:conditions => conditions)
		render :action => 'search_result'
  end

  def search_kigyoname
    @query = params[:q]
          conditions = [ ' kigyo_bango like ?', @query]
          @kigyo_daichos = KigyoDaicho.find(:first,  :conditions => conditions)
  end
			 
private
  def make_rireki(ku, kd) 
#		if Time.now.month >= 7 then
#			@nendo=Time.now.year
#		else
#			@nendo=Time.now.year-1
#		end
    @nendo=nendo
    @ur= UketsukeRireki.new()
    @urs=UketsukeRireki.find_all_by_kigyo_bango_and_uketsuke_nen(
    @kyujin_uketsuke.kigyo_bango, @nendo )
    if @urs==[] then
      @ur.kyujinhyo_maisu=1
      @ur.uketsuke_nen = @nendo
      @ur.kigyo_bango=@kyujin_uketsuke.kigyo_bango
    else
      @ur=@urs.first
      @ur.kyujinhyo_maisu=@urs.count
    end
      @ur.uketsuke_bango=@kyujin_uketsuke.uketsuke_bango
      @ur.kigyo_daicho_id=@kigyo_daicho.id
      @ur.update
  end

  def num_zen2han(str)
    str=str.tr('０-９','0-9')
  end

  def num_check_ku(a)
    a[:kihonkyu]=num_zen2han(a[:kihonkyu].to_s) unless a[:kihonkyu]==nil
    a[:kijunnai_tingin]=num_zen2han(a[:kijunnai_tingin].to_s) unless a[:kijunnai_tingin]==nil
    a[:kyujin_sosu]=num_zen2han(a[:kyujin_sosu].to_s) unless a[:kyujin_sosu]==nil
    a[:shokugyo_code]=num_zen2han(a[:shokugyo_code].to_s) unless a[:shokugyo_code]==nil
  end

  def num_check_ki(a)
    a[:jugyoinsu]=num_zen2han(a[:jugyoinsu].to_s) if 	a[:jugyoinsu]
    a[:sihon_oku]=num_zen2han(a[:sihon_oku].to_s) if 	a[:sihon_oku]
    a[:sihon_senman]=num_zen2han(a[:sihon_senman].to_s) if a[:sihon_senman]
  end 

  def num_check_kd(a)
    a[:jugyoinsu]=num_zen2han(a[:jugyoinsu].to_s) if 	a[:jugyoinsu]
    a[:sihon_oku]=num_zen2han(a[:sihon_oku].to_s) if 	a[:sihon_oku]
    a[:sihon_senman]=num_zen2han(a[:sihon_senman].to_s) if a[:sihon_senman]
    a[:kihonkyu]=num_zen2han(a[:kihonkyu].to_s) if  a[:kihonkyu]
    a[:kijunnai_tingin]=num_zen2han(a[:kijunnai_tingin].to_s) if a[:kijunnai_tingin]
    a[:kyujin_sosu]=num_zen2han(a[:kyujin_sosu].to_s) if a[:kyujin_sosu]
    a[:shokugyo_code]=num_zen2han(a[:shokugyo_code].to_s) if a[:shokugyo_code]
  end 

end