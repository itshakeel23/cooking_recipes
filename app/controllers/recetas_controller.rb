class RecetasController < ApplicationController
  # GET /recetas
  # GET /recetas.xml
  def index
    @recetas = Receta.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @recetas }
    end
  end

  # GET /recetas/1
  # GET /recetas/1.xml
  def show
    @receta = Receta.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @receta }
    end
  end

  # GET /recetas/new
  # GET /recetas/new.xml
  def new
    @receta = Receta.new

    3.times{ @receta.steps.build }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @receta }
    end
  end

  # GET /recetas/1/edit
  def edit
    @receta = Receta.find(params[:id])
  end

  # POST /recetas
  # POST /recetas.xml
  def create
    @receta = Receta.new(params[:receta])

    respond_to do |format|
      if @receta.save
        flash[:notice] = 'Receta was successfully created.'
        format.html { redirect_to(@receta) }
        format.xml  { render :xml => @receta, :status => :created, :location => @receta }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @receta.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /recetas/1
  # PUT /recetas/1.xml
  def update
    @receta = Receta.find(params[:id])

    respond_to do |format|
      if @receta.update_attributes(params[:receta])
        flash[:notice] = 'Receta was successfully updated.'
        format.html { redirect_to(@receta) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @receta.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /recetas/1
  # DELETE /recetas/1.xml
  def destroy
    @receta = Receta.find(params[:id])
    @receta.destroy

    respond_to do |format|
      format.html { redirect_to(recetas_url) }
      format.xml  { head :ok }
    end
  end
end
