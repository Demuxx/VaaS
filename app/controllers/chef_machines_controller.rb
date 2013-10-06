class ChefMachinesController < ApplicationController
  before_action :set_chef_machine, only: [:show, :edit, :update, :destroy]

  # GET /chef_machines
  # GET /chef_machines.json
  def index
    @chef_machines = ChefMachine.all
  end

  # GET /chef_machines/1
  # GET /chef_machines/1.json
  def show
  end

  # GET /chef_machines/new
  def new
    @chef_machine = ChefMachine.new
  end

  # GET /chef_machines/1/edit
  def edit
  end

  # POST /chef_machines
  # POST /chef_machines.json
  def create
    @chef_machine = ChefMachine.new(chef_machine_params)

    respond_to do |format|
      if @chef_machine.save
        format.html { redirect_to @chef_machine, notice: 'Chef machine was successfully created.' }
        format.json { render action: 'show', status: :created, location: @chef_machine }
      else
        format.html { render action: 'new' }
        format.json { render json: @chef_machine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chef_machines/1
  # PATCH/PUT /chef_machines/1.json
  def update
    respond_to do |format|
      if @chef_machine.update(chef_machine_params)
        format.html { redirect_to @chef_machine, notice: 'Chef machine was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @chef_machine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chef_machines/1
  # DELETE /chef_machines/1.json
  def destroy
    @chef_machine.destroy
    respond_to do |format|
      format.html { redirect_to chef_machines_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chef_machine
      @chef_machine = ChefMachine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chef_machine_params
      params.require(:chef_machine).permit(:chef_id, :machine_id)
    end
end
