class RestaurantsController < ApplicationController
  before_filter :owner_required, :only => [:edit, :update]
  before_filter :admin_required, :only => [:destroy]
  before_filter :find_rest_categories, :only => [:index,:new, :edit, :update, :donde_puedo_comer, :create]
  before_filter :login_required, :only => [:new, :create]

  # GET /restaurants
  # GET /restaurants.xml
  def index
    @restaurants = Restaurant.find(:all, :order => 'created_at DESC', :limit => 8)
    @page_description = t(:restaurants_index_description)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @restaurants }
    end
  end

  # GET /restaurants/1
  # GET /restaurants/1.xml
  def show
    @restaurant = Restaurant.find(params[:id])
    @comment = Comment.new if logged_in?
    @page_description = @restaurant.description

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @restaurant }
      format.print { render :layout => "print"}
    end
  end

  # GET /restaurants/new
  # GET /restaurants/new.xml
  def new
    @restaurant = Restaurant.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @restaurant }
    end
  end

  # GET /restaurants/1/edit
  def edit
    @restaurant = @obj
  end

  # POST /restaurants
  # POST /restaurants.xml
  def create
    @restaurant = Restaurant.new(params[:restaurant])
    @restaurant.user_id = current_user.id

    respond_to do |format|
      if @restaurant.save
        flash[:notice] = t(:Restaurant_created)
        format.html { redirect_to(@restaurant) }
        format.xml  { render :xml => @restaurant, :status => :created, :location => @restaurant }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @restaurant.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /restaurants/1
  # PUT /restaurants/1.xml
  def update
    @restaurant = @obj
    respond_to do |format|
      if @restaurant.update_attributes(params[:restaurant])
        flash[:notice] = t(:Restaurant_updated)
        format.html { redirect_to(@restaurant) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @restaurant.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def especialidad
    @rest_category = RestCategory.find(params[:id])
    @restaurants = @rest_category.restaurants.best_voted
    @page_description= "#{t(:best_restaurants_by_category_desc)} #{@rest_category.name}"
    if @restaurants.empty?
      flash[:notice] = t(:no_restaurants_in_this_category)
      redirect_to(:back)
    end
  end
  
  def donde_puedo_comer
    @page_description = t(:restaurants_searcher)
    @restaurant = Restaurant.new    
  end

  def resultados
    @page_description = t(:restaurant_results)
    unless params[:restaurant].values.to_s.blank?
      @restaurants = Restaurant.search(params[:restaurant]) 
    else
      flash[:error] = t(:fill_at_least_one_field)
      redirect_to donde_puedo_comer_restaurants_path
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.xml
  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy

    respond_to do |format|
      flash[:notice] = t(:restaurant_deleted)
      format.html { redirect_to(restaurants_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def find_rest_categories
    @rest_categories = RestCategory.find(:all, :order => 'name')    
  end
end
