class BashMachinesController < ApplicationController
  before_action :set_bash_machine, only: [:show, :edit, :update, :destroy]

  # GET /bash_machines
  # GET /bash_machines.json
  def index
    @bash_machines = BashMachine.all
  end

  # GET /bash_machines/1
  # GET /bash_machines/1.json
  def show
  end

  # GET /bash_machines/new
  def new
    @bash_machine = BashMachine.new
  end

  # GET /bash_machines/1/edit
  def edit
  end

  # POST /bash_machines
  # POST /bash_machines.json
  def create
    @bash_machine = BashMachine.new(bash_machine_params)

    respond_to do |format|
      if @bash_machine.save
        format.html { redirect_to @bash_machine, notice: 'Bash machine was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bash_machine }
      else
        format.html { render action: 'new' }
        format.json { render json: @bash_machine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bash_machines/1
  # PATCH/PUT /bash_machines/1.json
  def update
    respond_to do |format|
      if @bash_machine.update(bash_machine_params)
        format.html { redirect_to @bash_machine, notice: 'Bash machine was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bash_machine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bash_machines/1
  # DELETE /bash_machines/1.json
  def destroy
    @bash_machine.destroy
    respond_to do |format|
      format.html { redirect_to bash_machines_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bash_machine
      @bash_machine = BashMachine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bash_machine_params
      params.require(:bash_machine).permit(:bash_id, :machine_id)
    end
end
