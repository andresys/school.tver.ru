class Admin::FoodsController < AdminController
  before_filter lambda {FoodType.current = params[:type]}

  def index
    @year = params[:year] && params[:year].to_i || Date.today.year
    ids = FoodType.current.types.map {|t| t[:id]}
    @years = @school.food.where(menu_type: ids).group_by{|food| food.date.beginning_of_year}.keys.map(&:year)
    @school_group = @school.food.where(menu_type: ids).where('extract(year  from date) = ?', @year).group_by{|food| food.date.beginning_of_month}.to_a
  end

  def new
    ids = FoodType.current.types.map {|t| t[:id]}
    @food = @school.food.new(menu_type: ids.first)
  end

  def edit
    @food = Food.find(params[:id])
  end

  def create
    @food = @school.food.new(params[:food])
    if @food.save
      redirect_to :action => :index, :type => FoodType.current.slug
    else
      render 'new'
    end
  end

  def update
    @food = Food.find(params[:id])
    if @food.update_attributes(params[:food])
       redirect_to :action => :index, :type => FoodType.current.slug
      else
        render 'edit'
      end
    end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to :action => :index, :type => FoodType.current.slug
  end

end