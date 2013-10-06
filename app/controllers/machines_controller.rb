class MachinesController < ApplicationController
  before_action :set_machine, only: [:show, :edit, :update, :destroy, :toggle]

  # GET /machines
  # GET /machines.json
  def index
    @machines = Machine.all
  end

  # GET /machines/1
  # GET /machines/1.json
  def show
  end

  # GET /machines/new
  def new
    @machine = Machine.new
  end

  # GET /machines/1/edit
  def edit
  end

  # POST /machines
  # POST /machines.json
  def create
    @machine = Machine.new(machine_params)

    respond_to do |format|
      if @machine.save
        @machine.vagrant_init
        @machine.generate_vagrant
        @machine.up
        
        format.html { redirect_to @machine, notice: 'Machine was successfully created.' }
        format.json { render action: 'show', status: :created, location: @machine }
      else
        format.html { render action: 'new' }
        format.json { render json: @machine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /machines/1
  # PATCH/PUT /machines/1.json
  def update
    respond_to do |format|
      if @machine.update(machine_params)
        @machine.vagrant_init
        @machine.generate_vagrant
        
        format.html { redirect_to @machine, notice: 'Machine was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @machine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /machines/1
  # DELETE /machines/1.json
  def destroy
    path = Rails.root.join("vms", "#{@machine.id}")
    output = `cd #{path}; vagrant destroy -f`
    FileUtils.rm_rf(path)
    @machine.destroy
    respond_to do |format|
      format.html { redirect_to machines_url }
      format.json { head :no_content }
    end
  end
  
  def toggle
    if @machine.get_status != Status.where(name: "Up").first
      @machine.up
    else
      @machine.suspend
    end
    redirect_to action: 'index', status: :moved_permanently
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_machine
      @machine = Machine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def machine_params
      params.require(:machine).permit(:name, :description, :box_id, :network_id, :key_id, :chef_ids => [], :puppet_ids => [], :bash_ids => [])
    end
end
