class ChefJsonsController < ApplicationController
  before_action :set_chef_json, only: [:show, :edit, :update, :destroy]

  # GET /chef_jsons
  # GET /chef_jsons.json
  def index
    @chef_jsons = ChefJson.all
  end

  # GET /chef_jsons/1
  # GET /chef_jsons/1.json
  def show
  end

  # GET /chef_jsons/new
  def new
    @chef_json = ChefJson.new
  end

  # GET /chef_jsons/1/edit
  def edit
  end

  # POST /chef_jsons
  # POST /chef_jsons.json
  def create
    @chef_json = ChefJson.new(chef_json_params)

    respond_to do |format|
      if @chef_json.save
        format.html { redirect_to @chef_json, notice: 'Chef json was successfully created.' }
        format.json { render action: 'show', status: :created, location: @chef_json }
      else
        format.html { render action: 'new' }
        format.json { render json: @chef_json.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chef_jsons/1
  # PATCH/PUT /chef_jsons/1.json
  def update
    respond_to do |format|
      if @chef_json.update(chef_json_params)
        format.html { redirect_to @chef_json, notice: 'Chef json was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @chef_json.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chef_jsons/1
  # DELETE /chef_jsons/1.json
  def destroy
    @chef_json.destroy
    respond_to do |format|
      format.html { redirect_to chef_jsons_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chef_json
      @chef_json = ChefJson.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chef_json_params
      params.require(:chef_json).permit(:chef_id, :key, :value)
    end
end
