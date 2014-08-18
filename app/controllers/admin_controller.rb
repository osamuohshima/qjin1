class AdminController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @kyujin_daicho_pages, @kyujin_daichos = paginate :kyujin_daichos, :per_page => 10
  end

  def show
    @kyujin_daicho = KyujinDaicho.find(params[:id])
  end

  def new
    @kyujin_daicho = KyujinDaicho.new
  end

  def create
    @kyujin_daicho = KyujinDaicho.new(params[:kyujin_daicho])
    if @kyujin_daicho.save
      flash[:notice] = 'KyujinDaicho was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @kyujin_daicho = KyujinDaicho.find(params[:id])
  end

  def update
    @kyujin_daicho = KyujinDaicho.find(params[:id])
    if @kyujin_daicho.update_attributes(params[:kyujin_daicho])
      flash[:notice] = 'KyujinDaicho was successfully updated.'
      redirect_to :action => 'show', :id => @kyujin_daicho
    else
      render :action => 'edit'
    end
  end

  def destroy
    KyujinDaicho.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

	def csv  #see => http://www008.upp.so-net.ne.jp/letitbe/rails016.htm
　　　src = Article.find(:all).map { |articles| articles.export_row }
　　　buf = ''
　　　Article.find(:all).each do |articles|
	      CSV.generate_row(articles.export_row, Article::COL_SIZE, buf)
　　　end
　　　send_data(buf, :type => 'text/csv; charset=UTF-8', :filename => 'results.csv')
　end
end
