require 'application'
class UketsukePdfsController < ApplicationController
  def index
    redirect_to :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @nendo = nendo
    @uketsuke_pdfs_pages, 
    @uketsuke_pdfs = paginate(:uketsuke_pdfs, 
      :conditions => ['uketsuke_nen= ?', @nendo],
      :order => "kyujin_uketsuke_id is null ",
      :order => "uketsuke_bango DESC",
#      :order => "pdf_name DESC",
      :per_page => 25)
  end

  def new
    @uketsuke_pdfs =UketsukePdf.new 
    render
  end

  def create
    begin
      @uketsuke_pdfs = UketsukePdf.new(params[:uketsuke_pdfs])
      if @uketsuke_pdfs.shokushu_bango = ''
      @uketsuke_pdfs.shokushu_bango=0 
      end
      @kyujin_uketsuke_code = @uketsuke_pdfs.uketsuke_bango.to_s +
                              "-" + @uketsuke_pdfs.shokushu_bango.to_s
      @kyujin_uketsukes = KyujinUketsuke.find(:first,
             :conditions =>    "uketsuke_nen = @uketsuke_pdfs.uketsuke_nen and
                            uketsuke_code= @kyujin_uketsuke_code ") 
      @uketsuke_pdfs.kyujin_uketsuke_id = @kyujin_uketsukes.id
      if @uketsuke_pdfs.save
        flash[:notice] = 'UketsukePdf の新規作成に成功しました'
        redirect_to :action => 'list'
      else
        render :action => 'new'
      end
    rescue
    flash[:notice] = '受付番号と職種番号が違います。または、求人受付データが更新されていません'
    render :action => 'edit'
   end
  end

  def edit
    begin
     id=params[:id].to_i-1
     @uketsuke_pdfs = UketsukePdf.find(id+1)
     @uketsuke_pdfs_last=UketsukePdf.find(id)
     if @uketsuke_pdfs.shokushu_bango > 0
       @uketsuke_pdfs.uketsuke_bango=@uketsuke_pdfs_last.uketsuke_bango.to_i
     else   
       @uketsuke_pdfs.uketsuke_bango=@uketsuke_pdfs_last.uketsuke_bango.to_i+1
     end
     ku= KyujinUketsuke.find(:first,
          :conditions => ['uketsuke_nen= ? and uketsuke_bango= ?
                                  and shokushu_bango= ?',
                          @uketsuke_pdfs.uketsuke_nen, 
                          @uketsuke_pdfs.uketsuke_bango,
                          @uketsuke_pdfs.shokushu_bango])
      @uketsuke_pdfs.kyujin_uketsuke_id = ku.id
      @uketsuke_pdfs.input_date=ku.input_date
    rescue
      flash[:notice] = '受付番号と職種番号が違います。または、求人受付データが更新されていません'
      render :action => 'edit'             
    end
  end

  def update         #編集し登録する場合
    @up = UketsukePdf.find(params[:id])
    @up.attributes = params[:uketsuke_pdfs]
    ku_id=KyujinUketsuke.find(:first,
           :conditions => ['uketsuke_nen= ? and uketsuke_bango= ? and shokushu_bango= ?',
           @up.uketsuke_nen, @up.uketsuke_bango, @up.shokushu_bango]).id
    @up.kyujin_uketsuke_id=ku_id
    if @up.save
      flash[:notice] = 'UketsukePdfの更新に成功しました'
      redirect_to :action => 'list', :id => @up.id, :page =>@uketsuke_pdfs_pages
    else
      render :action => 'edit'
    end
  rescue
    flash[:notice] = 'たぶん求人受付データがまだ入力されていません'
    render :action => 'index' 
  end

  def destroy
    UketsukePdf.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

  def fileinfo
   @attachment = Attachment.info params[:uketsuke_nen], params[:filename]
  end

  def attach_file
    Attachment.save params[:attached]
    redirect_to :action => 'show', :id => params[:attached][:id]
  end

  def  download
   files = Attachment.info params[:uketsuke_nen], params[:filename]
   send_file files.cleanpath
  end

  def update_kyujin_uketsuke_ids     #automatic get kyujin_uketsukes_id
    @nendo=nendo()
    @uke_pdfs = UketsukePdf.find(:all, :conditions=>['uketsuke_nen= ?',@nendo])
    @uke_pdfs.each do |uke_pdf|
  unless ( uke_pdf.uketsuke_bango == nil || uke_pdf.shokushu_bango == nil)
    @kyujin = KyujinUketsuke.find(:first,
    :conditions => ['uketsuke_nen=? and uketsuke_bango=? and shokushu_bango=?',
        uke_pdf.uketsuke_nen, uke_pdf.uketsuke_bango, uke_pdf.shokushu_bango])
        uke_pdf.kyujin_uketsuke_id = @kyujin.id unless @kyujin.nil?
        uke_pdf.save
      else
        uk_pdf.shokushu_bango = 0
      end
    end
    flash[:notice] = 'UketsukePdf のkyujin_uketsuke_idsの更新に成功しました'
    render :action => 'list' 
  end

  def update_pdf_names  #automatic put new pdf_filenames into UketsukePdf table 
    @nendo = nendo()
    present_size= UketsukePdf.find(:all,
      :conditions => ['uketsuke_nen = ?', @nendo]).size
    dir_name = "public/attached/pdf/" + @nendo.to_s + "/kyujin_hyo/"
    @pdf_dir = `ls #{dir_name}`.strip.split(nil)
    @pdf_dir.each do |file_name|
         if UketsukePdf.find(:first,
      :conditions => ['pdf_name = ?', file_name]).nil? #=>xxxxx
           @new_pdf = UketsukePdf.new
           @new_pdf.pdf_name = file_name
           @new_pdf.uketsuke_nen = @nendo
           @new_pdf.input_date = Time.now
           @new_pdf.shokushu_bango = 0           # kari bango
           @new_pdf.uketsuke_bango = 1           # kari bango
           @new_pdf.save
          end
     end
     flash[:notice] = 'UketsukePdf のpdf名の登録に成功しました'
  end

  def search
    @nendo = nendo()
    @query = params[:q]
    unless @query
      redirect_to :action => 'index'
      return
    end
    conditions = [ 'uketsuke_bango like ? and  uketsuke_nen like ?',
                     "#{@query}", "#{@nendo}"]
    @uketsuke_pdfs = UketsukePdf.find(:all, :order => 'shokushu_bango',
                                      :conditions => conditions)
    render :action => 'index' 
  end
end
