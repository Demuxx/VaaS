class PuppetMachinesController < ApplicationController
  before_action :set_puppet_machine, only: [:show, :edit, :update, :destroy]

  # GET /puppet_machines
  # GET /puppet_machines.json
  def index
    @puppet_machines = PuppetMachine.all
  end

  # GET /puppet_machines/1
  # GET /puppet_machines/1.json
  def show
  end

  # GET /puppet_machines/new
  def new
    @puppet_machine = PuppetMachine.new
  end

  # GET /puppet_machines/1/edit
  def edit
  end

  # POST /puppet_machines
  # POST /puppet_machines.json
  def create
    @puppet_machine = PuppetMachine.new(puppet_machine_params)

    respond_to do |format|
      if @puppet_machine.save
        format.html { redirect_to @puppet_machine, notice: 'Puppet machine was successfully created.' }
        format.json { render action: 'show', status: :created, location: @puppet_machine }
      else
        format.html { render action: 'new' }
        format.json { render json: @puppet_machine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /puppet_machines/1
  # PATCH/PUT /puppet_machines/1.json
  def update
    respond_to do |format|
      if @puppet_machine.update(puppet_machine_params)
        format.html { redirect_to @puppet_machine, notice: 'Puppet machine was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @puppet_machine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /puppet_machines/1
  # DELETE /puppet_machines/1.json
  def destroy
    @puppet_machine.destroy
    respond_to do |format|
      format.html { redirect_to puppet_machines_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_puppet_machine
      @puppet_machine = PuppetMachine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def puppet_machine_params
      params.require(:puppet_machine).permit(:puppet_id, :machine_id)
    end
end
