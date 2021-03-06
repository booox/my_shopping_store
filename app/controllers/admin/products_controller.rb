class Admin::ProductsController <  AdminController
  before_action :set_product, only: [:show, :edit, :update, :destroy, :on_sale, :off_sale]
  

  def index
    @products = Product.all
  end

  def show
    set_page_title @product.title
  end

  def new
    @product = Product.new
    @photo = @product.build_photo
  end

  def edit
    @photo = @product.photo || @product.build_photo
    # if @product.photo.present?
    #   @photo = @product.photo
    # else
    #   @photo = @product.build_photo
    # end
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_url, notice: 'Product was successfully created.'
    else
      render :new
    end

  end

  def update
    if @product.update(product_params)
      redirect_to admin_products_url, notice: 'Product was successfully created.'
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path
  end

  def on_sale
    @product.turn_on_sale
    redirect_to :back, notice: "#{@product.title} is ON-SALE now!"
  end

  def off_sale
    @product.turn_off_sale
    redirect_to :back, notice: "#{@product.title} is OFF-SALE now!"
  end

  private



  def set_product
    @product = Product.friendly.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :price,
                                    photo_attributes: [:image, :id])
  end

end
