class Admin::FoodsController < AdminController

  def index
    @food = @school.food
  end

  def new
    @food = @school.food.new(menu_type: 0)
  end

  def edit
    @food = Food.find(params[:id])
  end

  def create
    @food = @school.food.new(params[:food])
    if @food.save
      redirect_to :action => :index
    else
      render 'new'
    end
  end

  def update
    @food = Food.find(params[:id])
    if @food.update_attributes(params[:food])
       redirect_to :action => :index
      else
        render 'edit'
      end
    end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to :action => :index
  end

end