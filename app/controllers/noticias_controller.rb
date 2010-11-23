class NoticiasController < ApplicationController
  before_filter :admin_required, :except =>[:index,:show]

  # GET /noticias
  # GET /noticias.xml
  def index
    @noticias = Noticia.sorted
    respond_to do |format|
      format.html # index.html.erb
      format.rss { render :action => "index.rxml", :layout => false }
      format.xml  { render :xml => @noticias }
    end
  end

  # GET /noticias/1
  # GET /noticias/1.xml
  def show
    @noticia = Noticia.find(params[:id])
    @comment = Comment.new if logged_in?  
    @page_description = @noticia.intro.to_s[0..300]
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @noticia }
    end
  end

  # GET /noticias/new
  # GET /noticias/new.xml
  def new
    @noticia = Noticia.new  

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @noticia }
    end
  end

  # GET /noticias/1/edit
  def edit
    @noticia = Noticia.find(params[:id])
  end

  # POST /noticias
  # POST /noticias.xml
  def create
    @noticia = Noticia.new(params[:noticia])
    @noticia.intro = RedCloth.new(@noticia.intro.to_s).to_html
    @noticia.content = RedCloth.new(@noticia.content.to_s).to_html
    @noticia.user_id = current_user.id

    respond_to do |format|
      if @noticia.save
        flash[:notice] = t(:noticia_created)
        format.html { redirect_to(@noticia) }
        format.xml  { render :xml => @noticia, :status => :created, :location => @noticia }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @noticia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /noticias/1
  # PUT /noticias/1.xml
  def update
    @noticia = Noticia.find(params[:id])
    @noticia.user_id = current_user.id

    respond_to do |format|
      if @noticia.update_attributes(params[:noticia])
        flash[:notice] = t(:noticia_updated)
        format.html { redirect_to(@noticia) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @noticia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /noticias/1
  # DELETE /noticias/1.xml
  def destroy
    @noticia = Noticia.find(params[:id])
    @noticia.destroy

    respond_to do |format|
      format.html { redirect_to(noticias_url) }
      format.xml  { head :ok }
    end
  end
  
end
