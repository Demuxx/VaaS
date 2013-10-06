class ChefsController < ApplicationController
  before_action :set_chef, only: [:show, :edit, :update, :destroy]

  # GET /chefs
  # GET /chefs.json
  def index
    @chefs = Chef.all
  end

  # GET /chefs/1
  # GET /chefs/1.json
  def show
  end

  # GET /chefs/new
  def new
    @chef = Chef.new
  end

  # GET /chefs/1/edit
  def edit
  end

  # POST /chefs
  # POST /chefs.json
  def create
    params, tarbal, databag = parse_params(chef_params)
    @chef = Chef.new(params)
    respond_to do |format|
      if @chef.save
        @chef.databag_path = Rails.root.join("uploads", "chefs", "#{@chef.id}", databag.original_filename).to_s if !databag.nil?
        @chef.cookbook_path = Rails.root.join("uploads", "chefs", "#{@chef.id}", tarbal.original_filename).to_s
        @chef.save
        
        put_file(databag, @chef.databag_path) if !databag.nil?
        put_file(tarbal, @chef.cookbook_path) if !tarbal.nil?
        
        format.html { redirect_to @chef, notice: 'Chef was successfully created.' }
        format.json { render action: 'show', status: :created, location: @chef }
      else
        format.html { render action: 'new' }
        format.json { render json: @chef.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chefs/1
  # PATCH/PUT /chefs/1.json
  def update
    path = Rails.root.join("uploads", "chefs")
    old_chef = @chef.dup
    params, tarbal, databag = parse_params(chef_params)
    respond_to do |format|
      if @chef.update(params)
        @chef.databag_path = Rails.root.join("uploads", "chefs", "#{@chef.id}", databag.original_filename).to_s if !databag.nil?
        @chef.cookbook_path = Rails.root.join("uploads", "chefs", "#{@chef.id}", tarbal.original_filename).to_s if !tarbal.nil?
        @chef.save
        
        put_file(databag, @chef.databag_path, old_chef.databag_path) if !databag.nil?
        put_file(tarbal, @chef.cookbook_path, old_chef.cookbook_path) if !tarbal.nil?
        
        format.html { redirect_to @chef, notice: 'Chef was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @chef.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chefs/1
  # DELETE /chefs/1.json
  def destroy
    FileUtils.rm_rf(Rails.root.join("uploads", "chefs", "#{@chef.id}"))
    @chef.destroy
    respond_to do |format|
      format.html { redirect_to chefs_url }
      format.json { head :no_content }
    end
  end

  private
    def parse_params(params)
      tarbal = params.delete(:tarbal)
      databag = params.delete(:databag)
      params[:cookbook_name] = tarbal.original_filename if !tarbal.nil?
      params[:databag_name] = databag.original_filename if !databag.nil?
      return [params, tarbal, databag]
    end
    
    def put_file(binary, new_path, old_path=nil)
      FileUtils.rm_f(old_path) if !old_path.nil?
      FileUtils.mkdir_p(File.dirname(new_path))
      File.open(new_path, 'w+b') do |file|
        file.write(binary.read)
      end
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_chef
      @chef = Chef.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chef_params
      params.require(:chef).permit(:name, :tarbal, :databag)
    end
end
