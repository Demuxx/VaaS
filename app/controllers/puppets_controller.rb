class PuppetsController < ApplicationController
  before_action :set_puppet, only: [:show, :edit, :update, :destroy]

  # GET /puppets
  # GET /puppets.json
  def index
    @puppets = Puppet.all
  end

  # GET /puppets/1
  # GET /puppets/1.json
  def show
  end

  # GET /puppets/new
  def new
    @puppet = Puppet.new
  end

  # GET /puppets/1/edit
  def edit
  end

  # POST /puppets
  # POST /puppets.json
  def create
    @puppet = Puppet.new(puppet_params)

    respond_to do |format|
      if @puppet.save
        format.html { redirect_to @puppet, notice: 'Puppet was successfully created.' }
        format.json { render action: 'show', status: :created, location: @puppet }
      else
        format.html { render action: 'new' }
        format.json { render json: @puppet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /puppets/1
  # PATCH/PUT /puppets/1.json
  def update
    respond_to do |format|
      if @puppet.update(puppet_params)
        format.html { redirect_to @puppet, notice: 'Puppet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @puppet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /puppets/1
  # DELETE /puppets/1.json
  def destroy
    @puppet.destroy
    respond_to do |format|
      format.html { redirect_to puppets_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_puppet
      @puppet = Puppet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def puppet_params
      params.require(:puppet).permit(:name, :manifest_file)
    end
end
