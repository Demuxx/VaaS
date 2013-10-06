class PuppetOptionsController < ApplicationController
  before_action :set_puppet_option, only: [:show, :edit, :update, :destroy]

  # GET /puppet_options
  # GET /puppet_options.json
  def index
    @puppet_options = PuppetOption.all
  end

  # GET /puppet_options/1
  # GET /puppet_options/1.json
  def show
  end

  # GET /puppet_options/new
  def new
    @puppet_option = PuppetOption.new
  end

  # GET /puppet_options/1/edit
  def edit
  end

  # POST /puppet_options
  # POST /puppet_options.json
  def create
    @puppet_option = PuppetOption.new(puppet_option_params)

    respond_to do |format|
      if @puppet_option.save
        format.html { redirect_to @puppet_option, notice: 'Puppet option was successfully created.' }
        format.json { render action: 'show', status: :created, location: @puppet_option }
      else
        format.html { render action: 'new' }
        format.json { render json: @puppet_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /puppet_options/1
  # PATCH/PUT /puppet_options/1.json
  def update
    respond_to do |format|
      if @puppet_option.update(puppet_option_params)
        format.html { redirect_to @puppet_option, notice: 'Puppet option was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @puppet_option.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /puppet_options/1
  # DELETE /puppet_options/1.json
  def destroy
    @puppet_option.destroy
    respond_to do |format|
      format.html { redirect_to puppet_options_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_puppet_option
      @puppet_option = PuppetOption.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def puppet_option_params
      params.require(:puppet_option).permit(:name, :option, :puppet_id)
    end
end
